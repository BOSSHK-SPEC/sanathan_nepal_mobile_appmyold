import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/events/data_changes.dart';
import 'package:sanathan_nepal_mobile_app/app/di/injection.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/calendar_view_toggle.dart';
import 'package:sanathan_nepal_mobile_app/features/home/presentation/pages/home_page.dart';
import 'package:sanathan_nepal_mobile_app/features/home/presentation/widgets/today_summary_column.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _app({required Region region, required Locale locale}) {
  final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (_, _) => const HomePage())],
  );
  return RegionScope(
    region: region,
    child: MaterialApp.router(
      theme: AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();
  });

  test('the real app wires the change signal and the session', () {
    // Screens take both as optional, so a feature can be tested on its own.
    // Without them the app still runs — silently: orders placed elsewhere
    // stop appearing under Profile › Activities, and buyers get a 403 from
    // the marketplace. This is where their absence fails loudly instead.
    expect(sl.isRegistered<DataChanges>(), isTrue);
    expect(sl.isRegistered<SessionResolver>(), isTrue);
  });

  testWidgets('HomePage renders header + all sections without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await sl<AppSettingsCubit>().setRegion(Region.nepal);
    await tester.pumpWidget(
      _app(region: Region.nepal, locale: const Locale('ne')),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('गृहपृष्ठ'), findsOneWidget);
    // Nepal: B.S./A.D. toggle, NST clock, रु. bullion.
    expect(find.text('वि.सं.'), findsOneWidget);
    expect(find.textContaining('NST'), findsOneWidget);
    expect(find.textContaining('रु.'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HomePage (India, English) renders Gregorian-first header', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await sl<AppSettingsCubit>().setRegion(Region.india);
    addTearDown(() => sl<AppSettingsCubit>().setRegion(Region.nepal));
    await tester.pumpWidget(
      _app(region: Region.india, locale: const Locale('en')),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Home'), findsOneWidget);
    expect(find.byType(TodaySummaryColumn), findsOneWidget);
    // Gregorian month title + Saka secondary date, IST clock, ₹ per 10 g.
    final now = DateTime.now();
    expect(find.textContaining(', ${now.year}'), findsWidgets);
    expect(find.textContaining('Saka'), findsWidgets);
    expect(find.textContaining('IST'), findsOneWidget);
    expect(find.textContaining('₹'), findsWidgets);
    expect(find.text('/10 g'), findsOneWidget);
    // Toggle offers Saka / A.D. and opens in Gregorian mode.
    final toggle = tester.widget<CalendarViewToggle>(
      find.byType(CalendarViewToggle),
    );
    expect(toggle.mode.name, 'gregorian');
    expect(find.text('Saka'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('switching the calendar converts the dates beside it too', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await sl<AppSettingsCubit>().setRegion(Region.india);
    addTearDown(() => sl<AppSettingsCubit>().setRegion(Region.nepal));
    await tester.pumpWidget(
      _app(region: Region.india, locale: const Locale('en')),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));

    final now = DateTime.now();
    TodaySummaryColumn column() =>
        tester.widget<TodaySummaryColumn>(find.byType(TodaySummaryColumn));

    // India opens Gregorian-first: today's Gregorian day leads the column and
    // the Saka date sits underneath it.
    expect(column().mode.name, 'gregorian');
    expect(find.text('${now.day}'), findsWidgets);

    // Switch to Saka — the same control that converts the grid.
    await tester.tap(find.text('Saka').first);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    // The column followed. It used to read the *region's* default rather than
    // the live mode, so the grid converted and these dates did not — the two
    // halves of one header disagreeing about today.
    expect(column().mode.name, 'traditional');
    expect(tester.takeException(), isNull);
  });
}
