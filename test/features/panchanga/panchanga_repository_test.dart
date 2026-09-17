import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/mock_panchanga_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/panchanga_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/sun_calculator.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/repositories/panchanga_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/entities/time_window.dart';

class _MockSource extends Mock implements PanchangaDataSource {}

const _nepal = FixedRegionResolver(Region.nepal);
const _india = FixedRegionResolver(Region.india);

void main() {
  group('SunCalculator', () {
    test('Kathmandu sunrise/sunset are plausible on 23 Feb 2023', () {
      final rise = SunCalculator.sunEvent(DateTime(2023, 2, 23), rise: true);
      final set = SunCalculator.sunEvent(DateTime(2023, 2, 23), rise: false);
      // Real values ≈ 06:31 / 17:59.
      expect(rise.hour, 6);
      expect(rise.minute, inInclusiveRange(20, 40));
      expect(set.hour, inInclusiveRange(17, 18));
    });

    test('New Delhi (IST) sunrise/sunset are plausible on 23 Feb 2023', () {
      final rise = SunCalculator.sunEvent(
        DateTime(2023, 2, 23),
        rise: true,
        lat: 28.6139,
        lon: 77.2090,
        utcOffsetHours: 5.5,
      );
      final set = SunCalculator.sunEvent(
        DateTime(2023, 2, 23),
        rise: false,
        lat: 28.6139,
        lon: 77.2090,
        utcOffsetHours: 5.5,
      );
      // Real values ≈ 06:53 / 18:17.
      expect(rise.hour, 6);
      expect(rise.minute, inInclusiveRange(40, 59));
      expect(set.hour, 18);
    });
  });

  group('PanchangaRepositoryImpl', () {
    test('getPanchanga returns deterministic data', () async {
      final repo = PanchangaRepositoryImpl(
        MockPanchangaDataSource(resolver: _nepal),
      );
      final a = (await repo.getPanchanga(DateTime(2023, 2, 23))).valueOrNull!;
      final b = (await repo.getPanchanga(DateTime(2023, 2, 23))).valueOrNull!;
      expect(a, b);
      expect(a.shakaSamvat, 1944);
      expect(a.nepalSamvat, 1143);
      expect(a.nepalSamvatMonthNe, 'चिल्लाथ्व');
      expect(a.tithiTitleNe, startsWith('फागुन शुक्ल'));
      expect(a.planets, hasLength(6));
      expect(a.dayDetails, isNotEmpty);
      expect(a.tithi.endsAt.isAfter(a.sunrise), isTrue);
      expect(a.sunset.isAfter(a.sunrise), isTrue);
    });

    test('getSuvaSaits returns the eight design categories spanning three '
        'B.S. years, sorted, with upcoming dates', () async {
      final now = DateTime(2023, 2, 23);
      final repo = PanchangaRepositoryImpl(
        MockPanchangaDataSource(resolver: _nepal, now: () => now),
      );
      final saits = (await repo.getSuvaSaits()).valueOrNull!;
      expect(saits, hasLength(8));
      expect(saits.map((s) => s.id), contains('bibaha'));
      expect(saits.first.titleNe, 'पास्नी गर्ने साइत');
      expect(saits.first.titleEn, 'Pasni (rice feeding) sait');
      for (final s in saits) {
        final sorted = [...s.dates]..sort();
        expect(s.dates, sorted);
        expect(s.upcoming(now, max: 3), hasLength(3));
        expect(s.upcoming(now).every((d) => !d.isBefore(now)), isTrue);
        // Every month of B.S. 2078–2080 has at least one date.
        const cal = BikramSambatCalendar();
        for (var y = 2078; y <= 2080; y++) {
          for (var m = 1; m <= 12; m++) {
            expect(cal.daysInMonth(y, m), greaterThan(0));
            expect(s.daysIn(cal, y, m), isNotEmpty, reason: '${s.id} $y/$m');
          }
        }
      }
      // Wedding & hom fall on "today" (design bullets).
      final today = saits.where((s) => s.isOn(now)).map((s) => s.id);
      expect(today, containsAll(['bibaha', 'hom']));
    });

    test(
      'Nepal: kaal windows are computed but tithi title uses BS month',
      () async {
        final repo = PanchangaRepositoryImpl(
          MockPanchangaDataSource(resolver: _nepal),
        );
        final p = (await repo.getPanchanga(DateTime(2023, 2, 23))).valueOrNull!;
        expect(p.rahuKaal, isNotNull);
        expect(p.choghadiya, hasLength(8));
        expect(p.tithiTitleEn, startsWith('Falgun'));
      },
    );

    test('India: New Delhi sunrise, Saka month title, kaal windows', () async {
      final repo = PanchangaRepositoryImpl(
        MockPanchangaDataSource(resolver: _india),
      );
      final day = DateTime(2023, 2, 23); // Thursday, Saka Phalguna 4, 1944.
      final p = (await repo.getPanchanga(day)).valueOrNull!;
      final nepal = (await PanchangaRepositoryImpl(
        MockPanchangaDataSource(resolver: _nepal),
      ).getPanchanga(day)).valueOrNull!;
      // New Delhi rises later than Kathmandu (further west, IST).
      expect(p.sunrise.isAfter(nepal.sunrise), isTrue);
      expect(p.tithiTitleEn, startsWith('Phalguna'));
      expect(p.tithiTitleNe, startsWith('फाल्गुन'));
      expect(p.shakaSamvat, 1944);
      // Thursday: Rahu Kaal = 6th segment, Yamaganda = 1st, Gulika = 3rd.
      final segment = p.sunset.difference(p.sunrise) ~/ 8;
      expect(p.rahuKaal!.kind, TimeWindowKind.rahuKaal);
      expect(p.rahuKaal!.start, p.sunrise.add(segment * 5));
      expect(p.yamaganda!.start, p.sunrise);
      expect(p.gulikaKaal!.start, p.sunrise.add(segment * 2));
      // Abhijit is the 8th of the day's 15 muhurtas (it was solar noon ± 24
      // minutes, which no published panchang uses; Drik Panchang matches the
      // muhurta rule to the minute).
      final muhurta = Duration(
        seconds: p.sunset.difference(p.sunrise).inSeconds ~/ 15,
      );
      expect(p.abhijitMuhurat!.start, p.sunrise.add(muhurta * 7));
      expect(p.abhijitMuhurat!.duration, muhurta);
      expect(p.choghadiya, hasLength(8));
      // Thursday's day Choghadiya starts with Shubh and ends with Shubh.
      expect(p.choghadiya.first.nameEn, 'Shubh');
      expect(p.choghadiya.last.nameEn, 'Shubh');
      expect(p.choghadiya.first.start, p.sunrise);
      expect(p.choghadiya.last.end, p.sunset);
    });

    test('India: suva saits use muhurat wording', () async {
      final now = DateTime(2023, 2, 23);
      final repo = PanchangaRepositoryImpl(
        MockPanchangaDataSource(resolver: _india, now: () => now),
      );
      final saits = (await repo.getSuvaSaits()).valueOrNull!;
      expect(saits.map((s) => s.id), contains('bibaha'));
      expect(saits.first.titleEn, 'Annaprashan muhurat');
      expect(saits.first.titleNe, 'अन्नप्राशन मुहूर्त');
      expect(saits.map((s) => s.titleEn), contains('Havan muhurat'));
    });

    test('maps exceptions to failures', () async {
      final source = _MockSource();
      when(source.fetchSuvaSaits).thenThrow(const CacheException('nope'));
      final repo = PanchangaRepositoryImpl(source);
      final result = await repo.getSuvaSaits();
      expect(result.failureOrNull, const CacheFailure('nope'));
    });
  });
}
