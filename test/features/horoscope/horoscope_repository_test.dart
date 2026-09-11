import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/datasources/horoscope_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/datasources/mock_horoscope_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/models/horoscope_prediction_model.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/repositories/horoscope_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/horoscope_period.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/zodiac_sign.dart';

class _MockSource extends Mock implements HoroscopeDataSource {}

/// Switchable resolver to prove the data source reads the region per call.
class _SwitchableResolver implements RegionResolver {
  Region current = Region.nepal;
  @override
  Region get region => current;
  @override
  RegionConfig get config => current.config;
}

MockHoroscopeDataSource _source(Region region, DateTime now) =>
    MockHoroscopeDataSource(
      resolver: FixedRegionResolver(region),
      now: () => now,
    );

void main() {
  group('HoroscopeRepositoryImpl', () {
    test('getAll returns 12 predictions from the mock source', () async {
      final repo = HoroscopeRepositoryImpl(
        _source(Region.nepal, DateTime(2023, 2, 23)),
      );
      final result = await repo.getAll(HoroscopePeriod.monthly);
      final list = result.valueOrNull!;
      expect(list, hasLength(12));
      expect(list.map((p) => p.sign), ZodiacSign.values);
      expect(list.every((p) => p.period == HoroscopePeriod.monthly), isTrue);
      expect(
        list.every(
          (p) =>
              p.textNe.isNotEmpty && p.textEn.isNotEmpty && p.textHi.isNotEmpty,
        ),
        isTrue,
      );
      expect(list.first.media.titleEn, contains('Aries Rashifal'));
    });

    test('getPrediction returns the requested sign', () async {
      final repo = HoroscopeRepositoryImpl(
        _source(Region.nepal, DateTime(2023, 2, 23)),
      );
      final result = await repo.getPrediction(
        ZodiacSign.pisces,
        HoroscopePeriod.yearly,
      );
      expect(result.valueOrNull?.sign, ZodiacSign.pisces);
      expect(result.valueOrNull?.lucky.rulingPlanetEn, 'Jupiter');
      expect(result.valueOrNull?.lucky.rulingPlanetFor('hi'), 'बृहस्पति');
    });

    test('maps exceptions to failures', () async {
      final source = _MockSource();
      when(
        () => source.fetchAll(HoroscopePeriod.daily),
      ).thenThrow(const ServerException('down'));
      final repo = HoroscopeRepositoryImpl(source);
      final result = await repo.getAll(HoroscopePeriod.daily);
      expect(result.failureOrNull, const ServerFailure('down'));
    });
  });

  group('MockHoroscopeDataSource – regions', () {
    test('Nepal: media title uses the Bikram Sambat month/year', () async {
      final p = await _source(
        Region.nepal,
        DateTime(2023, 2, 23),
      ).fetchPrediction(ZodiacSign.aries, HoroscopePeriod.daily);
      expect(p.media.titleEn, 'Aries Rashifal - Falgun, 2079');
      expect(p.media.titleNe, 'मेष राशिफल - फागुन, २०७९');
      expect(p.media.titleHi, 'मेष राशिफल – फागुन, २०७९');
    });

    test('India: media title uses the Saka month/year', () async {
      final p = (await _source(
        Region.india,
        DateTime(2026, 8, 18),
      ).fetchPrediction(ZodiacSign.aries, HoroscopePeriod.daily)).toEntity();
      expect(p.media.titleEn, 'Aries Rashifal - Shravana, 1948');
      expect(p.media.titleHi, 'मेष राशिफल – श्रावण, १९४८');
      expect(p.media.titleNe, 'मेष राशिफल - श्रावण, १९४८');
      expect(p.media.titleFor('hi'), p.media.titleHi);
      expect(p.textFor('hi'), p.textHi);
      expect(p.textFor('hi'), contains('आज'));
    });

    test('reads the region at call time (no caching)', () async {
      final resolver = _SwitchableResolver();
      final source = MockHoroscopeDataSource(
        resolver: resolver,
        now: () => DateTime(2026, 8, 18),
      );
      final nepal = await source.fetchPrediction(
        ZodiacSign.leo,
        HoroscopePeriod.daily,
      );
      resolver.current = Region.india;
      final india = await source.fetchPrediction(
        ZodiacSign.leo,
        HoroscopePeriod.daily,
      );
      expect(nepal.media.titleEn, contains('Bhadra, 2083'));
      expect(india.media.titleEn, contains('Shravana, 1948'));
    });

    test('model round-trips Hindi fields through JSON', () async {
      final p = await _source(
        Region.india,
        DateTime(2026, 8, 18),
      ).fetchPrediction(ZodiacSign.taurus, HoroscopePeriod.weekly);
      final json = p.toJson();
      expect(json['sign'], 'taurus');
      expect(json['period'], 'weekly');
      expect(json['text_hi'], p.textHi);
      expect((json['media'] as Map)['duration'], p.media.durationSeconds);
      final copy = HoroscopePredictionModel.fromJson(json);
      expect(copy, p);
      expect(copy.textHi, isNotEmpty);
      expect(copy.media.titleHi, p.media.titleHi);
      expect(copy.toEntity(), p.toEntity());
      expect(HoroscopePredictionModel.fromEntity(p.toEntity()), p);
    });

    test('profile (about / tabs / points / lucky clip) is seeded for every '
        'sign and round-trips through JSON', () async {
      final source = _source(Region.nepal, DateTime(2023, 2, 23));
      final all = await source.fetchAll(HoroscopePeriod.daily);
      for (final m in all) {
        final profile = m.toEntity().profile;
        expect(profile, isNotNull, reason: m.sign.name);
        expect(profile!.aboutNe, isNotEmpty);
        expect(profile.aboutEn, isNotEmpty);
        expect(profile.aboutHi, isNotEmpty);
        expect(profile.tabs, hasLength(3));
        expect(profile.tabs.first.points, hasLength(4));
        expect(profile.tabs.first.points.first.labelNe, 'पैसा');
        expect(profile.tabs.first.points.first.labelEn, 'Money');
        expect(profile.tabs.first.points.first.labelHi, 'धन');
        expect(profile.luckyMedia.duration, greaterThan(Duration.zero));
        for (final t in profile.tabs) {
          expect(t.titleFor('hi'), contains(m.sign.nameHi));
          expect(t.introFor('ne'), isNotEmpty);
        }
      }
      final aries = all.first;
      expect(aries.profile!.aboutEn, startsWith('Aries is the first sign'));
      expect(aries.profile!.tabs[0].titleNe, 'मेष राशि को पुरुष');
      expect(
        aries.profile!.luckyMedia.titleEn,
        'Lucky Color, Number and Stone for Aries Sign',
      );
      final json = aries.toJson();
      expect((json['profile'] as Map)['about_en'], aries.profile!.aboutEn);
      expect(HoroscopePredictionModel.fromJson(json), aries);
    });
  });

  group('Language accessors', () {
    test('ZodiacSign names/letters per language', () {
      expect(ZodiacSign.taurus.displayNameFor('hi'), 'वृषभ');
      expect(ZodiacSign.taurus.displayNameFor('ne'), 'वृष');
      expect(ZodiacSign.taurus.displayNameFor('en'), 'Taurus');
      expect(ZodiacSign.cancer.displayNameFor('hi'), 'कर्क');
      expect(ZodiacSign.aries.lettersFor('hi'), ZodiacSign.aries.lettersNe);
      expect(ZodiacSign.aries.lettersFor('en'), ZodiacSign.aries.lettersEn);
    });

    test('LuckyDetails Hindi falls back to English when empty', () async {
      final p = (await _source(
        Region.india,
        DateTime(2026, 8, 18),
      ).fetchPrediction(ZodiacSign.aries, HoroscopePeriod.daily)).toEntity();
      expect(p.lucky.daysFor('hi'), ['मंगलवार', 'शनिवार', 'शुक्रवार']);
      expect(p.lucky.colorFor('hi'), 'लाल');
      expect(p.lucky.symbolFor('hi'), 'मेढ़ा');
      expect(p.lucky.luckyStoneFor('hi'), 'मूँगा');
      expect(p.lucky.colorFor('ne'), 'रातो');
      expect(p.lucky.colorFor('en'), 'Red');
      expect(HoroscopePeriod.weekly.labelFor('hi'), 'साप्ताहिक');
    });
  });
}
