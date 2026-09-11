import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/calendar_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/wheel_picker.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/date_converter_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/presentation/pages/date_converter_page.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/presentation/widgets/conversion_result_section.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/presentation/widgets/converted_day_sections.dart';
import 'package:sanathan_nepal_mobile_app/features/events/events_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/widgets/events_for_date_section.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/panchanga_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/cubit/panchanga_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/widgets/panchanga_section.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/widgets/suva_sait_section.dart';
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
  ThemeData? theme,
  Locale locale = const Locale('ne'),
  Region region = Region.nepal,
}) {
  _region = region;
  return RegionScope(
    region: region,
    child: MaterialApp(
      theme: theme ?? AppTheme.light(),
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
    registerPanchangaFeature(GetIt.instance);
    registerEventsFeature(GetIt.instance);
    registerDateConverterFeature(GetIt.instance);
  });
  tearDownAll(GetIt.instance.reset);

  testWidgets('DateConverterPage converts today and shows result sections', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(const DateConverterPage()));
    await tester.pumpAndSettle();

    expect(find.text('मिति परिवर्तन'), findsOneWidget);
    expect(find.text('वि.सं. बाट ई.सं.'), findsOneWidget);
    expect(find.byType(WheelPicker), findsNWidgets(3));
    expect(find.text('परिवर्तन गर्नुहोस्'), findsOneWidget);
    expect(find.byType(ConversionResultSection), findsOneWidget);
    // Events / Suva Sait / Panchanga of the converted day (real feature
    // widgets, one shared PanchangaCubit).
    expect(find.byType(ConvertedDaySections), findsOneWidget);
    expect(find.byType(EventsForDateSection), findsOneWidget);
    expect(find.byType(SuvaSaitSection), findsOneWidget);
    expect(find.byType(PanchangaSection), findsOneWidget);
    expect(find.text('कार्यक्रमहरू'), findsOneWidget);
    expect(find.text('शुभ साइत'), findsOneWidget);
    expect(find.text('पञ्चाङ्ग'), findsWidgets);
    expect(find.text('HOME BELOW EVENT ADS'), findsOneWidget);

    // Switch direction → pickers rebuild for AD input.
    await tester.tap(find.text('ई.सं. बाट वि.सं.'));
    await tester.pumpAndSettle();
    expect(find.byType(WheelPicker), findsNWidgets(3));
    await tester.tap(find.text('परिवर्तन गर्नुहोस्'));
    await tester.pumpAndSettle();
    expect(find.byType(ConversionResultSection), findsOneWidget);
  });

  testWidgets('switching direction keeps the result half of the screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(const DateConverterPage()));
    await tester.pumpAndSettle();
    expect(find.byType(ConversionResultSection), findsOneWidget);

    // Everything below the picker renders only when a conversion exists.
    // Flipping the radio used to emit a fresh state that dropped the result,
    // so the bottom half of the screen vanished until Convert was pressed
    // again — which reads as the screen being broken.
    await tester.tap(find.text('ई.सं. बाट वि.सं.'));
    await tester.pumpAndSettle();

    expect(find.byType(ConversionResultSection), findsOneWidget);
    expect(find.byType(ConvertedDaySections), findsOneWidget);
    expect(find.text('HOME BELOW EVENT ADS'), findsOneWidget);

    // And back again.
    await tester.tap(find.text('वि.सं. बाट ई.सं.'));
    await tester.pumpAndSettle();

    expect(find.byType(ConversionResultSection), findsOneWidget);
    expect(find.byType(ConvertedDaySections), findsOneWidget);
  });

  testWidgets('DateConverterPage renders in dark / English', (tester) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      _wrap(
        const DateConverterPage(),
        theme: AppTheme.dark(),
        locale: const Locale('en'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Date Converter'), findsOneWidget);
    expect(find.text('B.S. to A.D.'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
  });

  testWidgets('India: Saka ⇄ A.D. with Vikram Samvat and Indian samvat row', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      _wrap(
        const DateConverterPage(),
        locale: const Locale('en'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Saka to A.D.'), findsOneWidget);
    expect(find.text('A.D. to Saka'), findsOneWidget);
    expect(find.byType(ConversionResultSection), findsOneWidget);
    // Result card: "<Saka month>, <year> Saka" + "Vikram Samvat NNNN".
    expect(find.textContaining('Saka'), findsWidgets);
    expect(find.textContaining('Vikram Samvat'), findsWidgets);
    // Samvat row = Vikram · Shaka · A.D. (no Nepal Sambat / B.S.).
    expect(find.text('Shaka Samvat'), findsOneWidget);
    expect(find.text('Nepal Sambat'), findsNothing);
    expect(find.text('B.S.'), findsNothing);
    // Saka wheel shows Saka month names (only visible rows are built).
    final sakaMonth = const SakaCalendar().monthName(
      const SakaCalendar().fromGregorian(DateTime.now()).month,
      languageCode: 'en',
    );
    expect(find.text(sakaMonth), findsWidgets);
  });

  testWidgets('India / Hindi strings', (tester) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      _wrap(
        const DateConverterPage(),
        locale: const Locale('hi'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('तिथि परिवर्तक'), findsOneWidget);
    expect(find.text('शक से ई.सं.'), findsOneWidget);
    expect(find.text('परिवर्तित करें'), findsOneWidget);
    expect(find.text('पंचांग'), findsOneWidget);
  });

  testWidgets('ConvertedDaySections re-targets its sections on a new date', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final a = DateTime(2026, 8, 20);
    final b = DateTime(2026, 9, 3);
    await tester.pumpWidget(
      _wrap(
        Scaffold(
          body: SingleChildScrollView(child: ConvertedDaySections(date: a)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    PanchangaCubit cubitOf() =>
        tester.widget<SuvaSaitSection>(find.byType(SuvaSaitSection)).cubit!;
    expect(cubitOf().state.date, a);
    expect(
      tester
          .widget<EventsForDateSection>(find.byType(EventsForDateSection))
          .date,
      a,
    );

    await tester.pumpWidget(
      _wrap(
        Scaffold(
          body: SingleChildScrollView(child: ConvertedDaySections(date: b)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    // Same cubit instance, re-pointed via selectDate; events section rebuilt.
    expect(cubitOf().state.date, b);
    expect(cubitOf().state.panchanga.isLoaded, isTrue);
    expect(
      tester
          .widget<EventsForDateSection>(find.byType(EventsForDateSection))
          .date,
      b,
    );
  });
}
