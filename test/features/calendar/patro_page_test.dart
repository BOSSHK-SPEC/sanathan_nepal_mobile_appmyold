import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/calendar_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/pages/patro_page.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/calendar_day_cell.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/calendar_view_toggle.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/date_detail_sheet.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/month_calendar_view.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// Region of the fake resolver – switched per test.
Region _region = Region.nepal;

class _TestResolver implements RegionResolver {
  const _TestResolver();
  @override
  Region get region => _region;
  @override
  RegionConfig get config => _region.config;
}

Widget _wrap(
  Widget child, {
  Locale locale = const Locale('ne'),
  Region region = Region.nepal,
}) {
  _region = region;
  return RegionScope(
    region: region,
    child: MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: child,
    ),
  );
}

void main() {
  setUpAll(() {
    GetIt.instance.registerLazySingleton<RegionResolver>(_TestResolver.new);
    registerCalendarFeature(GetIt.instance);
  });
  tearDownAll(GetIt.instance.reset);

  testWidgets('PatroPage renders grid, ads and reacts to day tap', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(const PatroPage()));
    await tester.pumpAndSettle();

    expect(find.text('पात्रो'), findsOneWidget);
    expect(find.byType(CalendarDayCell), findsNWidgets(42));
    expect(find.text('PATRO PAGE ADS'), findsNWidgets(2));
    expect(find.text('आ'), findsOneWidget);
    expect(find.text('वि.सं.'), findsOneWidget);
    expect(find.text('ई.सं.'), findsOneWidget);

    // Tap a mid-grid cell → date popup.
    await tester.tap(find.byType(CalendarDayCell).at(20));
    await tester.pumpAndSettle();
    expect(find.byType(DateDetailSheet), findsOneWidget);
    expect(find.text('पञ्चाङ्ग'), findsOneWidget);
  });

  testWidgets('MonthCalendarView compact embeds standalone (English)', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const Scaffold(
          body: SizedBox(
            width: 260,
            child: MonthCalendarView(compact: true, showViewToggle: true),
          ),
        ),
        locale: const Locale('en'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CalendarDayCell), findsNWidgets(42));
    expect(find.text('B.S.'), findsOneWidget);
    expect(find.text('A.D.'), findsOneWidget);
    // Toggle to AD view.
    await tester.tap(find.text('A.D.'));
    await tester.pumpAndSettle();
    expect(find.text('Sun'), findsOneWidget);
  });

  testWidgets('India: PatroPage opens in Gregorian view with Saka toggle', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      _wrap(
        const PatroPage(),
        locale: const Locale('en'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CalendarDayCell), findsNWidgets(42));
    expect(find.text('Saka'), findsOneWidget);
    expect(find.text('A.D.'), findsOneWidget);
    // Gregorian month title ("August, 2026" style) + Saka/Vikram subtitle.
    final now = DateTime.now();
    final gregorianTitle = find.textContaining(', ${now.year}');
    expect(gregorianTitle, findsWidgets);
    expect(find.textContaining('Vikram Samvat'), findsOneWidget);
    expect(find.textContaining('Saka ·'), findsOneWidget);

    // Switch to the Saka calendar.
    await tester.tap(find.text('Saka'));
    await tester.pumpAndSettle();
    final toggle = tester.widget<CalendarViewToggle>(
      find.byType(CalendarViewToggle),
    );
    expect(toggle.mode.name, 'traditional');
    expect(find.byType(CalendarDayCell), findsNWidgets(42));
  });

  testWidgets('India / Hindi: strings and weekday header are Hindi', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      _wrap(
        const PatroPage(),
        locale: const Locale('hi'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('पंचांग कैलेंडर'), findsOneWidget);
    expect(find.text('रवि'), findsOneWidget);
    expect(find.text('शक'), findsOneWidget);
    expect(find.text('ई.सं.'), findsOneWidget);
    expect(find.text('कार्यक्रम'), findsOneWidget);
  });
}
