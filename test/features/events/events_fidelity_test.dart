import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/calendar_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/calendar_day_cell.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/month_calendar_view.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/mock_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/repositories/event_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/repositories/event_repository.dart';
import 'package:sanathan_nepal_mobile_app/features/events/events_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/pages/event_form_page.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/pages/events_page.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/event_chip_row.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/event_date_section.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/events_for_date_section.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/events_header_card.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/events_list_body.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/events_tab_strip.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/festival_tile.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/my_event_row.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/panchanga_injection.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

final _now = DateTime(2026, 8, 17);

Widget _app(
  Widget home, {
  Locale locale = const Locale('en'),
  Region region = Region.nepal,
  bool dark = false,
}) => RegionScope(
  region: region,
  child: MaterialApp(
    theme: dark ? AppTheme.dark() : AppTheme.light(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

Future<void> _pump(
  WidgetTester tester,
  Widget app, {
  Size size = const Size(375, 812),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void main() {
  final sl = GetIt.instance;

  Future<void> setUpRegion(Region region) async {
    await sl.reset();
    sl.registerSingleton<RegionResolver>(FixedRegionResolver(region));
    registerCalendarFeature(sl);
    registerPanchangaFeature(sl);
    registerEventsFeature(sl);
    sl.unregister<EventsDataSource>();
    sl.registerLazySingleton<EventsDataSource>(
      () => MockEventsDataSource(resolver: sl<RegionResolver>(), now: _now),
    );
    sl.unregister<EventRepository>();
    sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(sl(), clock: () => _now),
    );
  }

  setUp(() => setUpRegion(Region.nepal));
  tearDown(sl.reset);

  group('EventsPage (Figma 625:1213)', () {
    testWidgets('header card, tab strip, boxed chips and festival tiles', (
      tester,
    ) async {
      await _pump(tester, _app(const EventsPage()));
      // Header: "View Calendar" link + today column + compact month grid.
      expect(find.text('View Calendar'), findsOneWidget);
      expect(find.byType(EventsHeaderCard), findsOneWidget);
      expect(find.byType(MonthCalendarView), findsOneWidget);
      // Tab strip with the three tabs.
      expect(find.byType(EventsTabStrip), findsOneWidget);
      expect(find.text('Festivals'), findsOneWidget);
      expect(find.text('To-Do'), findsOneWidget);
      // Festival chips (boxed) + tiles with thumbnail / badge / add button.
      expect(find.widgetWithText(EventChip, 'Important'), findsOneWidget);
      expect(find.byType(FestivalTile), findsWidgets);
      expect(find.text('Days Left'), findsWidgets);
      expect(find.text('Add Event/Reminder'), findsWidgets);

      // "Important" chip narrows the list.
      final all = find.byType(FestivalTile).evaluate().length;
      await tester.tap(find.widgetWithText(EventChip, 'Important'));
      await tester.pumpAndSettle();
      expect(find.byType(FestivalTile).evaluate().length, lessThan(all));

      // My Events tab: card header row + rows + "New Event" pill.
      await tester.tap(
        find.descendant(
          of: find.byType(EventsTabStrip),
          matching: find.text('My Events'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(MyEventsCard), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.byType(MyEventRow), findsWidgets);
      expect(find.text('New Event'), findsOneWidget);
      expect(find.textContaining('Days Remaining'), findsWidgets);
      expect(find.textContaining('Reminder:'), findsWidgets);
      // Personal chip filters.
      await tester.tap(find.widgetWithText(EventChip, 'Birthday'));
      await tester.pumpAndSettle();
      expect(find.byType(MyEventRow), findsOneWidget);
      expect(find.text('My Birthday'), findsOneWidget);
    });

    testWidgets('To-Do tab: chips per to-do narrow the list, dark 320px', (
      tester,
    ) async {
      await _pump(
        tester,
        _app(
          const EventsPage(initialGroup: EventGroup.todo),
          locale: const Locale('ne'),
          dark: true,
        ),
        size: const Size(320, 700),
      );
      expect(find.text('गर्नु-पर्ने कार्यहरु'), findsWidgets);
      expect(find.text('मिति'), findsOneWidget);
      final rows = find.byType(MyEventRow).evaluate().length;
      expect(rows, greaterThan(1));
      // Chip = to-do title (also the row title) → only that row remains.
      await tester.tap(find.widgetWithText(EventChip, 'घर भाडा'));
      await tester.pumpAndSettle();
      expect(find.byType(MyEventRow), findsOneWidget);
      // Back to all.
      await tester.tap(find.widgetWithText(EventChip, 'सबै'));
      await tester.pumpAndSettle();
      expect(find.byType(MyEventRow).evaluate().length, rows);
    });
  });

  group('EventFormPage inline calendar (Figma 671:1975)', () {
    testWidgets('tapping a day updates the selected date box', (tester) async {
      await _pump(
        tester,
        _app(EventFormPage(initialDate: DateTime(2026, 8, 20))),
        size: const Size(375, 900),
      );
      expect(find.byType(EventDateSection), findsOneWidget);
      expect(find.byType(MonthCalendarView), findsOneWidget);
      // Default mode B.S. → traditional ISO of 20 Aug 2026 (Bhadra 4, 2083).
      expect(find.text('2083-05-04'), findsOneWidget);

      // Tap the cell of 25 Aug 2026 on the inline grid.
      final target = DateTime(2026, 8, 25);
      final cell = find.byWidgetPredicate(
        (w) => w is CalendarDayCell && w.day.ad == target,
      );
      expect(cell, findsOneWidget);
      await tester.tap(cell);
      await tester.pumpAndSettle();
      expect(find.text('2083-05-09'), findsOneWidget);

      // A.D. radio → Gregorian ISO of the same day.
      await tester.tap(find.text('A.D'));
      await tester.pumpAndSettle();
      expect(find.text('2026-08-25'), findsOneWidget);
    });
  });

  group('EventsForDateSection', () {
    testWidgets('lists festivals / my events / to-dos of one day', (
      tester,
    ) async {
      await _pump(
        tester,
        _app(
          Scaffold(
            body: SingleChildScrollView(
              child: EventsForDateSection(
                date: _now.add(const Duration(days: 2)),
              ),
            ),
          ),
        ),
      );
      expect(find.text('Events'), findsOneWidget);
      expect(find.text('Add Event/Reminder'), findsOneWidget);
      // Seed: "House Rent" to-do falls on now + 2 days.
      expect(find.text('To-Do Lists'), findsOneWidget);
      expect(find.text('House Rent'), findsOneWidget);

      // A day without anything → empty message.
      await tester.pumpWidget(
        _app(
          Scaffold(
            body: EventsForDateSection(
              date: _now.add(const Duration(days: 1)),
              showTodos: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Events not available'), findsOneWidget);
    });
  });
}
