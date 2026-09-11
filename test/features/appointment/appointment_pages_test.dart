import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/appointment_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/appointment_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/astrologer_seed.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/time_slot.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/pages/appointment_details_page.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/pages/my_appointments_page.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/pages/astrologer_picker_page.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/pages/book_appointment_page.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/widgets/appointment_summary_card.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/widgets/booking_calendar.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// Region resolver whose region can be flipped between tests – proves the
/// data source reads the region at call time rather than caching it.
class _SwitchableRegionResolver implements RegionResolver {
  @override
  Region region = Region.nepal;
  @override
  RegionConfig get config => region.config;
}

void main() {
  final resolver = _SwitchableRegionResolver();

  setUpAll(() async {
    GetIt.I.registerSingleton<RegionResolver>(resolver);
    registerAppointmentFeature(GetIt.I);
    // Load the real app font so text metrics match the device (the test
    // fallback font renders every glyph as a 1em square).
    final loader = FontLoader('Mukta')
      ..addFont(rootBundle.load('assets/fonts/Mukta-Regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Mukta-Medium.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Mukta-SemiBold.ttf'));
    await loader.load();
  });
  tearDownAll(() => GetIt.I.reset());
  setUp(() => resolver.region = Region.nepal);

  Widget app(
    Widget home, {
    Locale locale = const Locale('en'),
    bool dark = false,
    Region region = Region.nepal,
  }) {
    resolver.region = region;
    return RegionScope(
      region: region,
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );
  }

  void phone(WidgetTester tester) {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  testWidgets('my appointments lists the bookings, not a astrologer bio', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(app(const MyAppointmentsPage()));
    await tester.pumpAndSettle();

    expect(find.text('My appointments'), findsOneWidget);
    expect(find.byType(AppointmentSummaryCard), findsWidgets);
    expect(find.textContaining('CHAT APPOINTMENT'), findsWidgets);
    // The regression this replaces: no astrologer header, no "book with them"
    // button for somebody the user never chose.
    expect(find.text('Dr. Uttam Upadhyaya (Astrologer)'), findsNothing);
    expect(find.text('Book Your Appointment Now!'), findsNothing);
    expect(find.text('Book appointment'), findsOneWidget);
  });

  testWidgets('my appointments switches between upcoming and past', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(app(const MyAppointmentsPage()));
    await tester.pumpAndSettle();

    Set<String> shownIds() => tester
        .widgetList<AppointmentSummaryCard>(find.byType(AppointmentSummaryCard))
        .map((c) => c.appointment.id)
        .toSet();

    final upcoming = shownIds();
    expect(upcoming, isNotEmpty);

    await tester.tap(find.text('Past'));
    await tester.pumpAndSettle();

    final past = shownIds();
    expect(past, isNotEmpty);
    // The two tabs are different appointments, not the same list twice.
    expect(past.intersection(upcoming), isEmpty);
  });

  testWidgets('astrologer list offers every astrologer in the region', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(
      app(const AstrologerPickerPage(), region: Region.india),
    );
    await tester.pumpAndSettle();

    expect(find.text('Choose who to book with'), findsOneWidget);
    // India seeds two astrologers; the old flow could only ever reach the
    // first one.
    expect(find.text('Pandit Rajesh Sharma'), findsOneWidget);
    expect(find.text('Acharya Meera Iyer'), findsOneWidget);
    // Each card says whether they are free now and what the cheapest sitting
    // costs — Pandit Rajesh is offline, Acharya Meera is online.
    expect(find.text('Book later'), findsOneWidget);
    expect(find.text('Online now'), findsOneWidget);
    expect(find.text('₹750'), findsOneWidget);
    expect(find.text('₹540'), findsOneWidget);
  });

  testWidgets('the picker renders in Nepali + dark theme', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(
      app(
        const AstrologerPickerPage(),
        locale: const Locale('ne'),
        dark: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('डा. उत्तम उपाध्याय न्यौपाने (ज्योतिष)'), findsOneWidget);
    expect(find.text('कोसँग बुक गर्ने छान्नुहोस्'), findsOneWidget);
  });

  testWidgets('the wizard offers every sitting, priced from their rates', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(
      app(BookAppointmentPage(astrologer: featuredAstrologer)),
    );
    await tester.pumpAndSettle();

    // Rs. 20 / 35 / 50 a minute, for half an hour each. The catalogue of
    // gemstones and named readings is gone: an astrologer sells their time.
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    // Each option says how long it is, and the field says where the total
    // came from — a bare "Rs. 600" beside a profile advertising Rs. 20/min is
    // the same fact told two ways with nothing joining them.
    expect(find.textContaining('Chat · 30 min (Rs. 600)'), findsWidgets);
    expect(find.textContaining('Voice call · 30 min (Rs. 1,050)'), findsWidgets);
    expect(find.textContaining('Video call · 30 min (Rs. 1,500)'), findsWidgets);
    expect(find.textContaining('Rs. 20/min × 30 min'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('details page shows status, sections and actions', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(app(const AppointmentDetailsPage(id: 'apt-1001')));
    await tester.pumpAndSettle();
    expect(find.text('Chat Appointment'), findsOneWidget);
    expect(find.text('Booked'), findsOneWidget);
    expect(find.text('Rs. 600'), findsOneWidget);
    expect(find.text('Reschedule'), findsOneWidget);
    await tester.tap(find.text('Payment'));
    await tester.pumpAndSettle();
    expect(find.text('Total'), findsOneWidget);
  });

  testWidgets('book page walks steps and books via mock source', (
    tester,
  ) async {
    phone(tester);
    final source =
        GetIt.I<AppointmentDataSource>() as MockAppointmentDataSource;
    final before = (await source.fetchAppointments()).length;
    await tester.pumpWidget(
      app(BookAppointmentPage(astrologer: featuredAstrologer)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Basic Info'), findsOneWidget);
    // Pick the first available slot on the day the wizard actually opened on.
    // Asking for "tomorrow" made this test fail every Friday: the astrologer
    // keeps no weekend hours, so tomorrow's grid was empty — the same trap the
    // wizard itself used to fall into.
    final free = await _firstFreeSlot(source, featuredAstrologerId);
    final label =
        '${free.hour % 12 == 0 ? 12 : free.hour % 12}:00 ${free.hour < 12 ? 'AM' : 'PM'}';
    final list = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(find.text(label), 100, scrollable: list);
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Next'), 100, scrollable: list);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Full Name', findRichText: true),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextFormField).at(0), 'Ram Thapa');
    await tester.enterText(find.byType(TextFormField).at(2), '9800000000');
    await tester.scrollUntilVisible(find.text('Next'), 100, scrollable: list);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Confirm Booking'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Confirm Booking'),
      100,
      scrollable: list,
    );
    await tester.tap(find.text('Confirm Booking'));
    await tester.pumpAndSettle();
    final after = await source.fetchAppointments();
    expect(after.length, before + 1);
    expect(after.first.customerName, 'Ram Thapa');
    expect(after.first.status, AppointmentStatus.booked);
  });

  group('India region', () {
    testWidgets('my appointments dates the list with the Saka calendar', (
      tester,
    ) async {
      phone(tester);
      await tester.pumpWidget(
        app(const MyAppointmentsPage(), region: Region.india),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppointmentSummaryCard), findsWidgets);
      expect(find.textContaining('CHAT APPOINTMENT'), findsWidgets);
      final saka = const SakaCalendar().fromGregorian(
        DateTime.now().add(const Duration(days: 4)),
      );
      final month = const SakaCalendar().monthName(
        saka.month,
        languageCode: 'en',
      );
      expect(
        find.textContaining('$month ${saka.day}, ${saka.year} |'),
        findsWidgets,
      );
    });

    testWidgets('booking flow uses Saka/A.D toggle, IST and UPI / card rails', (
      tester,
    ) async {
      phone(tester);
      await tester.pumpWidget(
        app(
          BookAppointmentPage(astrologer: indiaFeaturedAstrologer),
          region: Region.india,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Saka'), findsOneWidget);
      expect(find.text('A.D'), findsOneWidget);
      expect(find.text('B.S.'), findsNothing);
      expect(find.textContaining('₹750'), findsWidgets);
      final list = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.textContaining('IST ('),
        100,
        scrollable: list,
      );
      expect(find.textContaining('IST ('), findsOneWidget);
      expect(find.textContaining('NST'), findsNothing);
      // Calendar defaults to the Saka month header.
      final saka = const SakaCalendar().fromGregorian(
        DateTime.now().add(const Duration(days: 1)),
      );
      final month = const SakaCalendar().monthName(
        saka.month,
        languageCode: 'en',
      );
      expect(find.text('$month, ${saka.year}'), findsOneWidget);
      expect(find.byType(BookingCalendar), findsOneWidget);
      // Pick a slot → details → payment.
      final source =
          GetIt.I<AppointmentDataSource>() as MockAppointmentDataSource;
      final free = await _firstFreeSlot(source, indiaFeaturedAstrologerId);
      final label =
          '${free.hour % 12 == 0 ? 12 : free.hour % 12}:00 ${free.hour < 12 ? 'AM' : 'PM'}';
      await tester.scrollUntilVisible(find.text(label), 100, scrollable: list);
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('Next'), 100, scrollable: list);
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      // Phone prefix and default country come from the region config.
      expect(find.text('+91'), findsOneWidget);
      expect(find.text('India'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField).at(0), 'Rahul Verma');
      await tester.enterText(find.byType(TextFormField).at(2), '9876543210');
      await tester.scrollUntilVisible(find.text('Next'), 100, scrollable: list);
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('UPI: sanathan@upi'), findsOneWidget);
      expect(find.text('Debit / Credit card'), findsOneWidget);
      expect(find.text('Net banking'), findsOneWidget);
      expect(find.textContaining('eSewa'), findsNothing);
      expect(find.textContaining('Khalti'), findsNothing);
      expect(find.text('₹750'), findsWidgets);
    });

    testWidgets('details page in Hindi renders Devanagari + Saka + ₹', (
      tester,
    ) async {
      phone(tester);
      await tester.pumpWidget(
        app(
          const AppointmentDetailsPage(id: 'apt-in-1001'),
          locale: const Locale('hi'),
          region: Region.india,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('अपॉइंटमेंट विवरण'), findsOneWidget);
      expect(find.text('चैट अपॉइंटमेंट'), findsOneWidget);
      expect(find.text('बुक किया गया'), findsOneWidget);
      expect(find.text('₹७५०'), findsOneWidget);
      expect(find.text('समय बदलें'), findsOneWidget);
      // Basic info: Saka era label + IST + Devanagari date line.
      expect(find.text('तारीख (शक | ई.)'), findsOneWidget);
      expect(find.text('IST'), findsOneWidget);
      final saka = const SakaCalendar().fromGregorian(
        DateTime.now().add(const Duration(days: 4)),
      );
      final month = const SakaCalendar().monthName(
        saka.month,
        languageCode: 'hi',
      );
      expect(find.textContaining('$month '), findsOneWidget);
      // Payment section – UPI label in Hindi strings.
      await tester.tap(find.text('भुगतान'));
      await tester.pumpAndSettle();
      expect(find.text('कुल'), findsOneWidget);
      expect(find.text('UPI: sanathan@upi'), findsOneWidget);
    });
  });
}

/// The first bookable slot in the astrologer's published fortnight, and the
/// day it falls on — so a test never has to guess whether a given date is one
/// the astrologer works.
Future<TimeSlot> _firstFreeSlot(
  MockAppointmentDataSource source,
  String astrologerId,
) async {
  final calendar = await source.fetchAstrologerSlots(astrologerId);
  final free = calendar.firstWhere((s) => s.available);
  final slots = await source.fetchTimeSlots(astrologerId, free.day);
  return slots.firstWhere((s) => s.available).toEntity();
}
