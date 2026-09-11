import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/regional_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/entities/calendar_view_mode.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/usecases/get_calendar_month.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/cubit/calendar_cubit.dart';

class _MockGetMonth extends Mock implements GetCalendarMonth {}

void main() {
  setUpAll(() {
    registerFallbackValue(const CalendarMonthParams(year: 2079, month: 11));
  });

  DateTime now() => DateTime(2023, 3, 6); // 2079-11-22
  const nepal = FixedRegionResolver(Region.nepal);
  const india = FixedRegionResolver(Region.india);
  final realGetMonth = GetCalendarMonth(
    CalendarRepositoryImpl(
      RegionalCalendarEventsDataSource(nepal),
      nepal,
      now: now,
    ),
  );
  CalendarCubit buildNepal({CalendarViewMode? mode}) => CalendarCubit(
    getMonth: realGetMonth,
    resolver: nepal,
    now: now,
    initialMode: mode,
  );

  group('CalendarCubit', () {
    test('initial state is the current BS month (Nepal default)', () {
      final cubit = buildNepal();
      expect(cubit.state.year, 2079);
      expect(cubit.state.month, 11);
      expect(cubit.state.viewMode, CalendarViewMode.traditional);
    });

    test('India opens on the current Gregorian month by default', () {
      DateTime indiaNow() => DateTime(2026, 8, 18);
      final cubit = CalendarCubit(
        getMonth: GetCalendarMonth(
          CalendarRepositoryImpl(
            RegionalCalendarEventsDataSource(india),
            india,
            now: indiaNow,
          ),
        ),
        resolver: india,
        now: indiaNow,
      );
      expect(cubit.state.viewMode, CalendarViewMode.gregorian);
      expect(cubit.state.year, 2026);
      expect(cubit.state.month, 8);
    });

    blocTest<CalendarCubit, CalendarState>(
      'India: setViewMode(traditional) lands on the Saka month of today',
      build: () {
        DateTime indiaNow() => DateTime(2026, 8, 18);
        return CalendarCubit(
          getMonth: GetCalendarMonth(
            CalendarRepositoryImpl(
              RegionalCalendarEventsDataSource(india),
              india,
              now: indiaNow,
            ),
          ),
          resolver: india,
          now: indiaNow,
        );
      },
      act: (c) async {
        await c.load();
        await c.setViewMode(CalendarViewMode.traditional);
      },
      verify: (c) {
        expect(c.state.viewMode, CalendarViewMode.traditional);
        expect(c.state.year, 1948);
        expect(c.state.month, 5); // Shravana
        // Tuesday
        expect(c.state.calendarMonth.dataOrNull!.today!.isWeekend, isFalse);
      },
    );

    blocTest<CalendarCubit, CalendarState>(
      'load emits loading then success with 42 days',
      build: buildNepal,
      act: (c) => c.load(),
      expect: () => [
        const CalendarState(
          year: 2079,
          month: 11,
          calendarMonth: LoadState.loading(),
        ),
        isA<CalendarState>()
            .having((s) => s.calendarMonth.isLoaded, 'loaded', isTrue)
            .having((s) => s.days.length, 'days', 42),
      ],
    );

    blocTest<CalendarCubit, CalendarState>(
      'nextMonth wraps year and previousMonth comes back',
      build: buildNepal,
      seed: () => const CalendarState(year: 2079, month: 12),
      act: (c) async {
        await c.nextMonth();
        await c.previousMonth();
      },
      verify: (c) {
        expect(c.state.year, 2079);
        expect(c.state.month, 12);
      },
      expect: () => [
        isA<CalendarState>()
            .having((s) => s.year, 'year', 2080)
            .having((s) => s.month, 'month', 1),
        isA<CalendarState>().having(
          (s) => s.calendarMonth.isLoaded,
          'loaded',
          isTrue,
        ),
        isA<CalendarState>().having((s) => s.month, 'month', 12),
        isA<CalendarState>().having(
          (s) => s.calendarMonth.isLoaded,
          'loaded',
          isTrue,
        ),
      ],
    );

    blocTest<CalendarCubit, CalendarState>(
      'setViewMode(gregorian) keeps the same anchor date',
      build: buildNepal,
      act: (c) async {
        await c.load();
        await c.setViewMode(CalendarViewMode.gregorian);
      },
      verify: (c) {
        expect(c.state.viewMode, CalendarViewMode.gregorian);
        expect(c.state.year, 2023);
        expect(c.state.month, 3);
        expect(
          c.state.calendarMonth.dataOrNull!.mode,
          CalendarViewMode.gregorian,
        );
      },
    );

    blocTest<CalendarCubit, CalendarState>(
      'jumpToDate opens the month containing the date in the active mode',
      build: buildNepal,
      act: (c) => c.jumpToDate(DateTime(2023, 11, 24)), // 2080 Mangsir 8
      verify: (c) {
        expect(c.state.year, 2080);
        expect(c.state.month, 8);
      },
    );

    blocTest<CalendarCubit, CalendarState>(
      'selectDay / clearSelection',
      build: buildNepal,
      act: (c) async {
        await c.load();
        c.selectDay(c.state.days[10]);
        c.clearSelection();
      },
      skip: 2,
      expect: () => [
        isA<CalendarState>().having((s) => s.selectedDay, 'sel', isNotNull),
        isA<CalendarState>().having((s) => s.selectedDay, 'sel', isNull),
      ],
    );

    blocTest<CalendarCubit, CalendarState>(
      'failure from use case is surfaced',
      build: () {
        final m = _MockGetMonth();
        when(
          () => m(any()),
        ).thenAnswer((_) async => const Result.failure(ServerFailure('nope')));
        return CalendarCubit(getMonth: m, resolver: nepal, now: now);
      },
      act: (c) => c.load(),
      expect: () => [
        const CalendarState(
          year: 2079,
          month: 11,
          calendarMonth: LoadState.loading(),
        ),
        const CalendarState(
          year: 2079,
          month: 11,
          calendarMonth: LoadState.failed(ServerFailure('nope')),
        ),
      ],
    );
  });
}
