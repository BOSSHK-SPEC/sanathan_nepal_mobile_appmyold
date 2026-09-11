import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/mock_panchanga_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/entities/panchanga.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/entities/suva_sait.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/usecases/get_panchanga.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/usecases/get_suva_saits.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/cubit/panchanga_cubit.dart';

class _MockGetPanchanga extends Mock implements GetPanchanga {}

class _MockGetSaits extends Mock implements GetSuvaSaits {}

void main() {
  final day = DateTime(2023, 2, 23);
  final nextDay = DateTime(2023, 2, 24);
  late _MockGetPanchanga getPanchanga;
  late _MockGetSaits getSaits;
  late Panchanga p1;
  late Panchanga p2;
  late List<SuvaSait> saits;

  setUpAll(() async {
    registerFallbackValue(DateTime(2000));
    final source = MockPanchangaDataSource(
      resolver: const FixedRegionResolver(Region.nepal),
      now: () => day,
    );
    p1 = (await source.fetchPanchanga(day)).toEntity();
    p2 = (await source.fetchPanchanga(nextDay)).toEntity();
    saits = [for (final m in await source.fetchSuvaSaits()) m.toEntity()];
  });

  setUp(() {
    getPanchanga = _MockGetPanchanga();
    getSaits = _MockGetSaits();
    when(() => getPanchanga(day)).thenAnswer((_) async => Result.success(p1));
    when(
      () => getPanchanga(nextDay),
    ).thenAnswer((_) async => Result.success(p2));
    when(() => getSaits()).thenAnswer((_) async => Result.success(saits));
  });

  PanchangaCubit build() => PanchangaCubit(
    getPanchanga: getPanchanga,
    getSuvaSaits: getSaits,
    initialDate: day,
  );

  // 23 Feb 2023 = फागुन ११, २०७९ B.S.; 24 Feb = फागुन १२.
  const saitYear = 2079;
  const saitMonth = 11;

  group('PanchangaCubit', () {
    blocTest<PanchangaCubit, PanchangaState>(
      'load emits loading then success with panchanga and saits',
      build: build,
      act: (c) => c.load(),
      expect: () => [
        PanchangaState(
          date: day,
          saitYear: saitYear,
          saitMonth: saitMonth,
          panchanga: const LoadState.loading(),
          saits: const LoadState.loading(),
        ),
        PanchangaState(
          date: day,
          saitYear: saitYear,
          saitMonth: saitMonth,
          panchanga: LoadState.loaded(p1),
          saits: LoadState.loaded(saits),
        ),
      ],
    );

    blocTest<PanchangaCubit, PanchangaState>(
      'nextDay loads the following day and keeps saits',
      build: build,
      seed: () => PanchangaState(
        date: day,
        saitYear: saitYear,
        saitMonth: saitMonth,
        panchanga: LoadState.loaded(p1),
        saits: LoadState.loaded(saits),
      ),
      act: (c) => c.nextDay(),
      expect: () => [
        PanchangaState(
          date: nextDay,
          saitYear: saitYear,
          saitMonth: saitMonth,
          panchanga: LoadState.loading(previous: p1),
          saits: LoadState.loaded(saits),
        ),
        PanchangaState(
          date: nextDay,
          saitYear: saitYear,
          saitMonth: saitMonth,
          panchanga: LoadState.loaded(p2),
          saits: LoadState.loaded(saits),
        ),
      ],
      verify: (_) => verifyNever(() => getSaits()),
    );

    blocTest<PanchangaCubit, PanchangaState>(
      'sait month/year navigation rolls over years and switches view',
      build: build,
      act: (c) => c
        ..nextSaitMonth()
        ..nextSaitMonth()
        ..previousSaitYear()
        ..setSaitView(SaitView.yearly),
      expect: () => [
        PanchangaState(date: day, saitYear: 2079, saitMonth: 12),
        PanchangaState(date: day, saitYear: 2080, saitMonth: 1),
        PanchangaState(date: day, saitYear: 2079, saitMonth: 1),
        PanchangaState(
          date: day,
          saitYear: 2079,
          saitMonth: 1,
          saitView: SaitView.yearly,
        ),
      ],
    );

    blocTest<PanchangaCubit, PanchangaState>(
      'India resolver uses the Saka calendar for the sait month',
      build: () => PanchangaCubit(
        getPanchanga: getPanchanga,
        getSuvaSaits: getSaits,
        resolver: const FixedRegionResolver(Region.india),
        initialDate: day,
      ),
      act: (c) => c.previousSaitMonth(),
      // 23 Feb 2023 = Phalguna 4, 1944 Saka → previous = Magha 1944.
      expect: () => [PanchangaState(date: day, saitYear: 1944, saitMonth: 11)],
    );

    blocTest<PanchangaCubit, PanchangaState>(
      'load emits failure on error',
      build: () {
        when(
          () => getPanchanga(day),
        ).thenAnswer((_) async => const Result.failure(NetworkFailure()));
        return build();
      },
      act: (c) => c.load(),
      expect: () => [
        PanchangaState(
          date: day,
          saitYear: saitYear,
          saitMonth: saitMonth,
          panchanga: const LoadState.loading(),
          saits: const LoadState.loading(),
        ),
        PanchangaState(
          date: day,
          saitYear: saitYear,
          saitMonth: saitMonth,
          panchanga: const LoadState.failed(NetworkFailure()),
          saits: LoadState.loaded(saits),
        ),
      ],
      verify: (c) =>
          expect(c.state.panchanga.errorMessage, 'No internet connection'),
    );
  });
}
