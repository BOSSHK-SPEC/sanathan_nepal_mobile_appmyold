import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/regional_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/data/repositories/date_conversion_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/entities/date_parts.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/usecases/convert_gregorian_to_traditional.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/usecases/convert_traditional_to_gregorian.dart';

void main() {
  const nepal = FixedRegionResolver(Region.nepal);
  const india = FixedRegionResolver(Region.india);
  final repo = DateConversionRepositoryImpl(
    nepal,
    RegionalCalendarEventsDataSource(nepal),
    now: () => DateTime(2023, 3, 13),
  );

  test('Nepal: 2079 Falgun 22 → 2023-03-06 (Monday, Holi)', () async {
    final r = await ConvertTraditionalToGregorian(repo)(
      const DateParts(year: 2079, month: 11, day: 22),
    );
    final v = r.valueOrNull!;
    expect(v.ad, DateTime(2023, 3, 6));
    expect(v.weekdayIndex, 1);
    expect(v.events.map((e) => e.id), contains('2079-11-22-holi'));
    expect(v.isHoliday, isTrue);
    expect(v.isWeekend, isFalse);
    expect(v.daysFromToday, -7);
    expect(v.shakaSamvat, 1944);
    expect(v.nepalSambat, 1143);
    expect(v.vikramSamvat, 2079);
  });

  test('Nepal: 2023-11-24 → 2080 Mangsir 8', () async {
    final r = await ConvertGregorianToTraditional(repo)(
      const DateParts(year: 2023, month: 11, day: 24),
    );
    final v = r.valueOrNull!;
    expect(v.traditional, const TraditionalDate(2080, 8, 8));
    expect(v.ageBreakdown.years, 0);
    expect(v.ageBreakdown.months, 8);
  });

  test('Nepal: Saturday is the weekend', () async {
    final v = (await repo.gregorianToTraditional(
      const DateParts(year: 2023, month: 3, day: 11),
    )).valueOrNull!;
    expect(v.isWeekend, isTrue);
    expect(v.isHoliday, isTrue);
  });

  test('rejects invalid days', () async {
    final r = await repo.traditionalToGregorian(
      const DateParts(year: 2079, month: 11, day: 31),
    );
    expect(r.failureOrNull, isA<ValidationFailure>());
    final r2 = await repo.gregorianToTraditional(
      const DateParts(year: 2023, month: 2, day: 30),
    );
    expect(r2.failureOrNull, isA<ValidationFailure>());
    final r3 = await repo.traditionalToGregorian(
      const DateParts(year: 1900, month: 1, day: 1),
    );
    expect(r3.failureOrNull, isA<ValidationFailure>());
  });

  test('round trip is stable', () async {
    for (final d in [DateTime(1990, 1, 1), DateTime(2040, 12, 31)]) {
      final t = (await repo.gregorianToTraditional(
        DateParts(year: d.year, month: d.month, day: d.day),
      )).valueOrNull!;
      final back = (await repo.traditionalToGregorian(
        DateParts(
          year: t.traditional.year,
          month: t.traditional.month,
          day: t.traditional.day,
        ),
      )).valueOrNull!;
      expect(back.ad, d);
    }
  });

  group('India (Saka ⇄ Gregorian)', () {
    final indiaRepo = DateConversionRepositoryImpl(
      india,
      RegionalCalendarEventsDataSource(india),
      now: () => DateTime(2026, 8, 18),
    );

    test('Shravana 27, 1948 Saka → 18 Aug 2026 (Tuesday, VS 2083)', () async {
      final v = (await ConvertTraditionalToGregorian(indiaRepo)(
        const DateParts(year: 1948, month: 5, day: 27),
      )).valueOrNull!;
      expect(v.ad, DateTime(2026, 8, 18));
      expect(v.weekdayIndex, 2);
      expect(v.isWeekend, isFalse);
      expect(v.isToday, isTrue);
      expect(v.shakaSamvat, 1948);
      expect(v.vikramSamvat, 2083);
    });

    test('15 Aug 2026 → Shravana 24, 1948; Independence Day holiday', () async {
      final v = (await ConvertGregorianToTraditional(indiaRepo)(
        const DateParts(year: 2026, month: 8, day: 15),
      )).valueOrNull!;
      expect(v.traditional, const TraditionalDate(1948, 5, 24));
      expect(v.events.map((e) => e.id), ['2026-08-15-independence-day']);
      expect(v.isHoliday, isTrue);
      expect(v.isWeekend, isFalse); // Saturday – not the Indian weekend.
    });

    test('Sunday is the weekend in India', () async {
      final v = (await indiaRepo.gregorianToTraditional(
        const DateParts(year: 2026, month: 8, day: 16), // Sunday
      )).valueOrNull!;
      expect(v.isWeekend, isTrue);
      final sat = (await indiaRepo.gregorianToTraditional(
        const DateParts(year: 2026, month: 8, day: 15), // Saturday
      )).valueOrNull!;
      expect(sat.isWeekend, isFalse);
    });

    test('Panchanga sunrise uses New Delhi / IST', () async {
      final v = (await indiaRepo.gregorianToTraditional(
        const DateParts(year: 2026, month: 8, day: 18),
      )).valueOrNull!;
      expect(v.panchanga.sunrise.hour, inInclusiveRange(5, 6));
    });

    test('validates the Saka month length (Chaitra 30 days in 1948)', () async {
      final r = await indiaRepo.traditionalToGregorian(
        const DateParts(year: 1948, month: 1, day: 31),
      );
      expect(r.failureOrNull, isA<ValidationFailure>());
      final ok = await indiaRepo.traditionalToGregorian(
        const DateParts(year: 1948, month: 2, day: 31),
      );
      expect(ok.valueOrNull!.ad, DateTime(2026, 5, 21));
    });
  });
}
