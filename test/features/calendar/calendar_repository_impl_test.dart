import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/india_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/nepal_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/regional_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/entities/calendar_view_mode.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/entities/lunar_day.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/services/calendar_year_range.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/services/lunar_calculator.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/services/panchanga_approximator.dart';

class _MockEvents extends Mock implements CalendarEventsDataSource {}

class _SwitchableResolver implements RegionResolver {
  _SwitchableResolver(this.region);
  @override
  Region region;
  @override
  RegionConfig get config => region.config;
}

void main() {
  const nepal = FixedRegionResolver(Region.nepal);
  const india = FixedRegionResolver(Region.india);

  group('CalendarRepositoryImpl (Nepal)', () {
    late CalendarRepositoryImpl repo;

    setUp(() {
      repo = CalendarRepositoryImpl(
        RegionalCalendarEventsDataSource(nepal),
        nepal,
        now: () => DateTime(2023, 3, 6), // 2079 Falgun 22 (Holi)
      );
    });

    test('builds a 42-cell BS month with real conversions', () async {
      final result = await repo.getMonth(year: 2079, month: 11);
      final month = result.valueOrNull!;
      expect(month.days.length, 42);
      expect(month.mode, CalendarViewMode.traditional);
      // 2079 Falgun 1 = 2023-02-13 (Monday) → one leading Sunday cell.
      expect(month.days.first.isCurrentMonth, isFalse);
      expect(month.days[1].isCurrentMonth, isTrue);
      expect(month.days[1].traditional.day, 1);
      expect(month.days[1].ad, DateTime(2023, 2, 13));
      expect(month.currentMonthDays.length, 30);
      // Today flagged & carries the Holi event.
      final today = month.today!;
      expect(today.traditional.day, 22);
      expect(today.events.map((e) => e.id), contains('2079-11-22-holi'));
      expect(today.isHoliday, isTrue);
      expect(month.events.length, 4);
    });

    test('builds an AD month whose secondary numbers are BS days', () async {
      final result = await repo.getMonth(
        year: 2023,
        month: 3,
        mode: CalendarViewMode.gregorian,
      );
      final month = result.valueOrNull!;
      expect(month.currentMonthDays.length, 31);
      final first = month.currentMonthDays.first;
      expect(first.ad.day, 1);
      expect(first.traditional.month, 11); // Falgun
      expect(first.traditional.day, 17);
    });

    test('Saturdays are the weekend / holiday in Nepal', () async {
      final month = (await repo.getMonth(year: 2080, month: 1)).valueOrNull!;
      for (final d in month.days) {
        expect(d.isWeekend, d.ad.weekday == DateTime.saturday);
        if (d.ad.weekday == DateTime.saturday) expect(d.isHoliday, isTrue);
      }
    });

    test('maps data-source exceptions to failures', () async {
      final events = _MockEvents();
      when(
        () => events.fetchEvents(
          from: any(named: 'from'),
          to: any(named: 'to'),
        ),
      ).thenThrow(Exception('boom'));
      final failing = CalendarRepositoryImpl(events, nepal);
      final result = await failing.getEvents(
        from: DateTime(2023, 4, 14),
        to: DateTime(2023, 5, 14),
      );
      expect(result, isA<ResultFailure<dynamic>>());
    });
  });

  group('CalendarRepositoryImpl (India)', () {
    late CalendarRepositoryImpl repo;

    setUp(() {
      repo = CalendarRepositoryImpl(
        RegionalCalendarEventsDataSource(india),
        india,
        now: () => DateTime(2026, 8, 18),
      );
    });

    test('Gregorian month carries Saka dates, Sunday weekend and Indian '
        'festivals', () async {
      final month = (await repo.getMonth(
        year: 2026,
        month: 8,
        mode: CalendarViewMode.gregorian,
      )).valueOrNull!;
      expect(month.currentMonthDays.length, 31);
      final today = month.today!;
      expect(today.ad, DateTime(2026, 8, 18));
      expect(today.traditional, const TraditionalDate(1948, 5, 27)); // Shravana
      for (final d in month.days) {
        expect(d.isWeekend, d.ad.weekday == DateTime.sunday);
      }
      final ids = month.events.map((e) => e.id);
      expect(ids, contains('2026-08-15-independence-day'));
      expect(ids, contains('2026-08-28-raksha-bandhan'));
      expect(ids, isNot(contains('2083-04-30-independence-day')));
      final independence = month.events.firstWhere(
        (e) => e.id.endsWith('independence-day'),
      );
      expect(independence.isHoliday, isTrue);
      expect(independence.title(languageCode: 'hi'), 'स्वतंत्रता दिवस');
      expect(independence.title(languageCode: 'en'), 'Independence Day');
    });

    test('Saka month grid: Shravana 1948 starts on 23 July 2026', () async {
      final month = (await repo.getMonth(year: 1948, month: 5)).valueOrNull!;
      expect(month.mode, CalendarViewMode.traditional);
      expect(month.currentMonthDays.length, 31);
      expect(month.currentMonthDays.first.ad, DateTime(2026, 7, 23));
      expect(month.currentMonthDays.first.traditional.day, 1);
    });
  });

  group('RegionalCalendarEventsDataSource', () {
    test('switches dataset with the region at call time', () async {
      final resolver = _SwitchableResolver(Region.nepal);
      final source = RegionalCalendarEventsDataSource(resolver);
      final holi2023 = await source.fetchEvents(
        from: DateTime(2023, 3, 6),
        to: DateTime(2023, 3, 6),
      );
      expect(holi2023.map((e) => e.id), contains('2079-11-22-holi'));

      resolver.region = Region.india;
      final diwali2025 = await source.fetchEvents(
        from: DateTime(2025, 10, 20),
        to: DateTime(2025, 10, 20),
      );
      expect(diwali2025.single.id, '2025-10-20-diwali');
      expect(diwali2025.single.isHoliday, isTrue);
      final nothing = await source.fetchEvents(
        from: DateTime(2023, 3, 6),
        to: DateTime(2023, 3, 6),
      );
      expect(nothing, isEmpty);
    });

    test('seeds are keyed by Gregorian date and sorted', () async {
      final nepal = NepalCalendarEventsDataSource();
      final holi = nepal.seed.firstWhere((e) => e.id == '2079-11-22-holi');
      expect(holi.date, DateTime(2023, 3, 6));
      final india = IndiaCalendarEventsDataSource();
      final year2026 = await india.fetchEvents(
        from: DateTime(2026),
        to: DateTime(2026, 12, 31),
      );
      expect(year2026.length, greaterThan(30));
      for (var i = 1; i < year2026.length; i++) {
        expect(year2026[i].date.isBefore(year2026[i - 1].date), isFalse);
      }
      expect(year2026.map((e) => e.id), contains('2026-01-26-republic-day'));
      expect(year2026.map((e) => e.id), contains('2026-11-08-diwali'));
    });
  });

  group('supportedYears', () {
    test('Bikram Sambat 1970–2100 ⇒ Gregorian 1914–2042', () {
      const bs = BikramSambatCalendar();
      expect(supportedYears(bs, CalendarViewMode.traditional), (
        min: 1970,
        max: 2100,
      ));
      expect(supportedYears(bs, CalendarViewMode.gregorian), (
        min: 1914,
        max: 2042,
      ));
    });
    test('Saka 1800–2100 ⇒ Gregorian 1879–2177', () {
      const saka = SakaCalendar();
      expect(supportedYears(saka, CalendarViewMode.gregorian), (
        min: 1879,
        max: 2177,
      ));
      expect(isYearSupported(saka, CalendarViewMode.traditional, 1948), isTrue);
      expect(isYearSupported(saka, CalendarViewMode.traditional, 2200), false);
    });
  });

  group('PanchangaApproximator', () {
    test('sunrise/sunset for Kathmandu are plausible', () {
      final p = PanchangaApproximator.forDate(DateTime(2023, 2, 23));
      expect(p.sunrise.hour, 6);
      expect(p.sunset.hour, inInclusiveRange(17, 18));
      expect(p.nakshatraNe, isNotEmpty);
    });
    test('forRegion(India) uses New Delhi / IST', () {
      final delhi = PanchangaApproximator.forRegion(
        DateTime(2026, 8, 18),
        india.config,
      );
      final ktm = PanchangaApproximator.forRegion(
        DateTime(2026, 8, 18),
        nepal.config,
      );
      // Delhi is ~8° west of Kathmandu but IST is 15 min behind NST → the
      // sun rises later on the Delhi clock.
      expect(delhi.sunrise.isAfter(ktm.sunrise), isTrue);
      expect(delhi.sunrise.hour, inInclusiveRange(5, 6));
      expect(delhi.sunset.hour, inInclusiveRange(18, 19));
    });
    test('siderealMonthIndex: mid-May is Vrishabha (Jestha)', () {
      expect(
        PanchangaApproximator.siderealMonthIndex(DateTime(2023, 5, 20)),
        1,
      );
    });
  });

  group('LunarCalculator', () {
    test('Holi 2023 (Mar 6) is around Purnima', () {
      final d = LunarCalculator.forDate(DateTime(2023, 3, 6));
      expect(d.paksha, Paksha.shukla);
      expect(d.tithiIndex, inInclusiveRange(14, 15));
    });
    test('Laxmi Puja 2023 (Nov 12) is around Aunsi', () {
      final d = LunarCalculator.forDate(DateTime(2023, 11, 12));
      expect(d.paksha, Paksha.krishna);
      expect(d.tithiIndex, inInclusiveRange(14, 15));
    });
  });
}
