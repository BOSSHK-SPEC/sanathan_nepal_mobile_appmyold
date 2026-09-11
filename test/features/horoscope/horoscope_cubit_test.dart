import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/datasources/mock_horoscope_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/horoscope_period.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/horoscope_prediction.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/zodiac_sign.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/usecases/get_all_predictions.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/presentation/cubit/horoscope_cubit.dart';

class _MockGetAll extends Mock implements GetAllPredictions {}

void main() {
  late _MockGetAll getAll;
  late List<HoroscopePrediction> daily;

  setUpAll(() async {
    registerFallbackValue(HoroscopePeriod.daily);
    final models = await MockHoroscopeDataSource(
      resolver: const FixedRegionResolver(Region.nepal),
      now: () => DateTime(2023, 2, 23),
    ).fetchAll(HoroscopePeriod.daily);
    daily = [for (final m in models) m.toEntity()];
  });

  setUp(() {
    getAll = _MockGetAll();
    when(() => getAll(any())).thenAnswer((_) async => Result.success(daily));
  });

  HoroscopeCubit build() => HoroscopeCubit(
    getAllPredictions: getAll,
    tick: const Duration(milliseconds: 10),
  );

  group('HoroscopeCubit', () {
    blocTest<HoroscopeCubit, HoroscopeState>(
      'load emits loading then success with 12 predictions',
      build: build,
      act: (c) => c.load(),
      expect: () => [
        const HoroscopeState(predictions: LoadState.loading()),
        HoroscopeState(predictions: LoadState.loaded(daily)),
      ],
      verify: (c) => expect(c.state.selected?.sign, ZodiacSign.aries),
    );

    blocTest<HoroscopeCubit, HoroscopeState>(
      'load emits failure on error',
      build: () {
        when(
          () => getAll(any()),
        ).thenAnswer((_) async => const Result.failure(ServerFailure('x')));
        return build();
      },
      act: (c) => c.load(),
      expect: () => [
        const HoroscopeState(predictions: LoadState.loading()),
        const HoroscopeState(predictions: LoadState.failed(ServerFailure('x'))),
      ],
    );

    blocTest<HoroscopeCubit, HoroscopeState>(
      'selectPeriod reloads with the new period',
      build: build,
      act: (c) => c.selectPeriod(HoroscopePeriod.weekly),
      verify: (_) => verify(() => getAll(HoroscopePeriod.weekly)).called(1),
      expect: () => [
        const HoroscopeState(period: HoroscopePeriod.weekly),
        const HoroscopeState(
          period: HoroscopePeriod.weekly,
          predictions: LoadState.loading(),
        ),
        HoroscopeState(
          period: HoroscopePeriod.weekly,
          predictions: LoadState.loaded(daily),
        ),
      ],
    );

    blocTest<HoroscopeCubit, HoroscopeState>(
      'selectSign updates selectedSign',
      build: build,
      act: (c) => c.selectSign(ZodiacSign.leo),
      expect: () => [const HoroscopeState(selectedSign: ZodiacSign.leo)],
    );

    blocTest<HoroscopeCubit, HoroscopeState>(
      'togglePlayback starts and pauses the mocked player',
      build: build,
      seed: () => HoroscopeState(predictions: LoadState.loaded(daily)),
      act: (c) async {
        c.togglePlayback(ZodiacSign.aries);
        await Future<void>.delayed(const Duration(milliseconds: 35));
        c.togglePlayback(ZodiacSign.aries);
      },
      verify: (c) {
        expect(c.state.isPlaying, isFalse);
        expect(c.state.playingSign, ZodiacSign.aries);
        expect(c.state.position, greaterThan(Duration.zero));
      },
    );

    blocTest<HoroscopeCubit, HoroscopeState>(
      'toggleLike / toggleDetails flip per-sign sets',
      build: build,
      act: (c) => c
        ..toggleLike(ZodiacSign.leo)
        ..toggleDetails(ZodiacSign.leo)
        ..toggleLike(ZodiacSign.leo),
      expect: () => [
        const HoroscopeState(likedSigns: {ZodiacSign.leo}),
        const HoroscopeState(
          likedSigns: {ZodiacSign.leo},
          expandedSigns: {ZodiacSign.leo},
        ),
        const HoroscopeState(expandedSigns: {ZodiacSign.leo}),
      ],
      verify: (c) {
        expect(c.state.isExpanded(ZodiacSign.leo), isTrue);
        expect(c.state.isLiked(ZodiacSign.leo), isFalse);
      },
    );

    blocTest<HoroscopeCubit, HoroscopeState>(
      'lucky clip plays independently of the prediction clip',
      build: build,
      seed: () => HoroscopeState(
        predictions: LoadState.loaded(daily),
        playingSign: ZodiacSign.aries,
        position: const Duration(seconds: 30),
        isPlaying: true,
      ),
      act: (c) => c
        ..togglePlayback(ZodiacSign.aries, lucky: true)
        ..seek(1),
      verify: (c) {
        expect(c.state.playingLuckyClip, isTrue);
        expect(c.state.isPlayingClip(ZodiacSign.aries, lucky: true), isTrue);
        expect(c.state.isPlayingClip(ZodiacSign.aries), isFalse);
        expect(c.state.positionOf(ZodiacSign.aries), Duration.zero);
        expect(
          c.state.positionOf(ZodiacSign.aries, lucky: true),
          daily.first.profile!.luckyMedia.duration,
        );
      },
    );

    blocTest<HoroscopeCubit, HoroscopeState>(
      'seek moves the playhead proportionally',
      build: build,
      seed: () => HoroscopeState(
        predictions: LoadState.loaded(daily),
        playingSign: ZodiacSign.aries,
      ),
      act: (c) => c.seek(0.5),
      verify: (c) => expect(
        c.state.position.inSeconds,
        (daily.first.media.duration.inSeconds * 0.5).round(),
      ),
    );
  });
}
