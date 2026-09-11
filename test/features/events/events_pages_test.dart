import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/calendar_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/mock_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/repositories/event_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/repositories/event_repository.dart';
import 'package:sanathan_nepal_mobile_app/features/events/events_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/pages/event_details_page.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/pages/event_form_page.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/pages/events_page.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/event_chip_row.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/upcoming_events_section.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/panchanga_injection.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

Widget _app(
  Widget home, {
  Locale locale = const Locale('en'),
  Region region = Region.nepal,
}) => RegionScope(
  region: region,
  child: MaterialApp(
    theme: AppTheme.light(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

/// Small-phone viewport (Figma frame is 375 wide) to catch overflows.
Future<void> pumpPhone(WidgetTester tester, Widget app) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void main() {
  final sl = GetIt.instance;

  /// Registers the feature with a deterministic seed for [region].
  Future<void> setUpRegion(Region region) async {
    await sl.reset();
    sl.registerSingleton<RegionResolver>(FixedRegionResolver(region));
    registerCalendarFeature(sl);
    registerPanchangaFeature(sl);
    registerEventsFeature(sl);
    // Deterministic seed + clock for the tests.
    final now = DateTime(2026, 8, 17);
    sl.unregister<EventsDataSource>();
    sl.registerLazySingleton<EventsDataSource>(
      () => MockEventsDataSource(resolver: sl<RegionResolver>(), now: now),
    );
    sl.unregister<EventRepository>();
    sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(sl(), clock: () => now),
    );
  }

  setUp(() => setUpRegion(Region.nepal));

  tearDown(sl.reset);

  testWidgets('EventsPage renders tabs, chips and festival rows', (
    tester,
  ) async {
    await pumpPhone(tester, _app(const EventsPage()));
    await tester.pumpAndSettle();

    expect(find.text('My Events'), findsWidgets);
    expect(find.text('Festivals'), findsOneWidget);
    expect(find.text('To-Do'), findsOneWidget);
    expect(find.text('Government Holidays'), findsOneWidget);
    expect(find.text('Add Event/Reminder'), findsWidgets);

    // Switch to To-Do tab.
    await tester.tap(find.text('To-Do'));
    await tester.pumpAndSettle();
    // Chip + row title.
    expect(find.text('House Rent'), findsNWidgets(2));
    expect(find.text('New Reminder'), findsOneWidget);
    expect(find.text('To-Do Lists'), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
  });

  testWidgets('EventsPage in Nepali shows Devanagari day counts', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const EventsPage(), locale: const Locale('ne')),
    );
    await tester.pumpAndSettle();
    expect(find.text('चाडपर्वहरू'), findsOneWidget);
    expect(find.textContaining('दिन बाँकी'), findsWidgets);
  });

  testWidgets('EventDetailsPage shows festival tabs and personal actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const EventDetailsPage(eventId: 'fst-ram-nawami')),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ram Nawami'), findsOneWidget);
    expect(find.text('How To Celebrate'), findsOneWidget);
    expect(find.text('Attraction Places'), findsOneWidget);
    expect(find.text('Panchanga & Suva Sait >'), findsOneWidget);

    await tester.pumpWidget(
      _app(const EventDetailsPage(eventId: 'usr-anniversary')),
    );
    await tester.pumpAndSettle();
    expect(find.text('Anniversary'), findsWidgets);
    expect(find.text('Invite guests'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('EventFormPage validates the title and lists checklist items', (
    tester,
  ) async {
    await pumpPhone(tester, _app(const EventFormPage()));
    await tester.pumpAndSettle();
    expect(find.text('New Event'), findsOneWidget);
    expect(find.text('Create Event'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Create'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('Please enter a title'),
      find.byType(ListView),
      const Offset(0, 300),
    );
    expect(find.text('Please enter a title'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Add'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Add new list item'),
      'Cake',
    );
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('Cake'), findsOneWidget);
  });

  testWidgets('EventFormPage edit mode pre-fills the event', (tester) async {
    final event = Event(
      id: 'usr-rafting',
      title: LocalizedText.same('Rafting'),
      date: DateTime(2026, 8, 21),
      category: EventCategory.adventure,
    );
    await pumpPhone(tester, _app(EventFormPage(initial: event)));
    await tester.pumpAndSettle();
    expect(find.text('Edit Event'), findsOneWidget);
    expect(find.text('Rafting'), findsOneWidget);
    await tester.dragUntilVisible(
      find.text('Update'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    expect(find.text('Update'), findsOneWidget);
  });

  testWidgets('UpcomingEventsSection renders header pills and dot list', (
    tester,
  ) async {
    await pumpPhone(
      tester,
      _app(
        const Scaffold(
          body: SingleChildScrollView(child: UpcomingEventsSection()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('All Events'), findsOneWidget);
    expect(find.text('Holiday'), findsOneWidget);
    expect(find.text('Vrat'), findsOneWidget);
    // Featured card shows the first upcoming event title twice (dot + card).
    expect(find.text('Medicine Time'), findsWidgets);
  });

  testWidgets('EventsPage in India (English): chips, Gregorian-primary dates', (
    tester,
  ) async {
    await setUpRegion(Region.india);
    await pumpPhone(tester, _app(const EventsPage(), region: Region.india));
    // Region-aware chips.
    expect(find.text('Public Holidays'), findsOneWidget);
    expect(find.text('Government Holidays'), findsNothing);
    expect(find.text('Sikh'), findsWidgets);
    expect(find.text('Jain'), findsWidgets);
    expect(find.text('Kirat'), findsNothing);
    // India festival seed (17 Aug 2026 → Nag Panchami today, Rakhi 28 Aug).
    expect(find.text('Nag Panchami'), findsOneWidget);
    expect(find.text('Raksha Bandhan'), findsOneWidget);
    expect(find.text('Ram Nawami'), findsNothing);
    // Gregorian-primary line with Saka + Vikram year.
    expect(
      find.textContaining(
        '28 Aug, 2026, Friday - Bhadrapada 6, 1948 Saka · VS 2083',
      ),
      findsOneWidget,
    );
    // Header: Gregorian month/year + Saka subtitle (header uses the real
    // clock, so only the shape is asserted).
    expect(find.textContaining(RegExp(r'^[A-Z][a-z]+, 20\d\d$')), findsWidgets);
    // Today column: weekday in the day box + Saka/VS line under it.
    expect(find.textContaining(RegExp(r'^[A-Z][a-z]+day$')), findsWidgets);
    expect(
      find.textContaining(
        RegExp(r'^[A-Z][a-z]+ \d+, 19\d\d Saka · VS 20\d\d$'),
      ),
      findsWidgets,
    );
    // Sikh chip filters the list (chip row scrolls horizontally).
    final sikhChip = find.widgetWithText(EventChip, 'Sikh');
    await tester.ensureVisible(sikhChip);
    await tester.pumpAndSettle();
    await tester.tap(sikhChip);
    await tester.pumpAndSettle();
    expect(find.text('Guru Nanak Jayanti'), findsOneWidget);
    expect(find.text('Raksha Bandhan'), findsNothing);
  });

  testWidgets('EventsPage in India (Hindi) shows Hindi strings and titles', (
    tester,
  ) async {
    await setUpRegion(Region.india);
    await pumpPhone(
      tester,
      _app(
        const EventsPage(),
        locale: const Locale('hi'),
        region: Region.india,
      ),
    );
    expect(find.text('त्योहार'), findsOneWidget);
    expect(find.text('सार्वजनिक अवकाश'), findsWidgets);
    expect(find.text('रक्षा बंधन'), findsOneWidget);
    expect(find.text('नाग पंचमी'), findsOneWidget);
    expect(find.textContaining('दिन शेष'), findsWidgets);
    // Hindi weekday + Devanagari Saka date.
    expect(
      find.textContaining('शुक्रवार - भाद्रपद ६, १९४८ शक'),
      findsOneWidget,
    );
  });

  testWidgets('EventDetailsPage in India links to Shubh Muhurat', (
    tester,
  ) async {
    await setUpRegion(Region.india);
    await tester.pumpWidget(
      _app(const EventDetailsPage(eventId: 'in-diwali'), region: Region.india),
    );
    await tester.pumpAndSettle();
    expect(find.text('Diwali (Deepavali)'), findsOneWidget);
    expect(find.text('Panchanga & Shubh Muhurat >'), findsOneWidget);
    expect(
      find.textContaining('November 8, 2026, Sunday | Kartika 17, 1948 Saka'),
      findsOneWidget,
    );
  });

  testWidgets('EventFormPage in India offers a Saka date mode', (tester) async {
    await setUpRegion(Region.india);
    await pumpPhone(tester, _app(const EventFormPage(), region: Region.india));
    await tester.pumpAndSettle();
    expect(find.text('Saka'), findsOneWidget);
    expect(find.text('B.S.'), findsNothing);
    // Default mode is the traditional calendar → Saka ISO date of today.
    expect(find.textContaining('1948-'), findsOneWidget);
  });
}
