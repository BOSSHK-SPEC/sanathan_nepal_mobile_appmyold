import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_spacing.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_bar_title.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_card.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/section_header.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/datasources/mock_weather_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/services/mock_location_service.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/usecases/get_weather.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/usecases/get_weather_for_location.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/presentation/pages/weather_page.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/presentation/widgets/weather_summary_card.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

WeatherCubit _cubit({Region region = Region.nepal}) {
  final resolver = FixedRegionResolver(region);
  final mock = MockWeatherDataSource(now: DateTime(2024, 3, 1, 9));
  final repo = WeatherRepositoryImpl(remote: mock, fallback: mock);
  return WeatherCubit(
    getWeather: GetWeather(
      repository: repo,
      locationService: MockLocationService(resolver: resolver),
      resolver: resolver,
    ),
    getWeatherForLocation: GetWeatherForLocation(repo),
  );
}

Widget _app(
  Widget home, {
  Locale locale = const Locale('en'),
  Region region = Region.nepal,
  ThemeMode themeMode = ThemeMode.light,
}) => RegionScope(
  region: region,
  child: MaterialApp(
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: themeMode,
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

void main() {
  testWidgets('WeatherView renders header, hourly and daily sections', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const WeatherView()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kathmandu'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Next Forecast'), findsOneWidget);
    expect(find.text('90%'), findsWidgets);
    expect(find.text('Details'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('WeatherView shows Devanagari digits in Nepali', (tester) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const WeatherView()),
        locale: const Locale('ne'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('काठमाडौँ'), findsOneWidget);
    expect(find.text('९०%'), findsWidgets);
  });

  testWidgets('WeatherSummaryCard renders the 5-hour strip', (tester) async {
    tester.view.physicalSize = const Size(390, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: WeatherSummaryCard(cubit: cubit..load(), onTap: () {}),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Kathmandu'), findsOneWidget);
    expect(find.text('26°'), findsOneWidget);
    expect(find.textContaining('H:29°'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('WeatherView in India falls back to New Delhi', (tester) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit(region: Region.india);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const WeatherView()),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('New Delhi'), findsOneWidget);
    expect(find.text('Kathmandu'), findsNothing);
    expect(
      cubit.state.weather.dataOrNull!.location.latitude,
      closeTo(28.6139, 1e-4),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('WeatherSummaryCard in India shows Hindi + Devanagari digits', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit(region: Region.india);
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: WeatherSummaryCard(cubit: cubit..load(), onTap: () {}),
        ),
        region: Region.india,
        locale: const Locale('hi'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('नई दिल्ली'), findsOneWidget);
    expect(find.text('२६°'), findsOneWidget);
    expect(find.textContaining('आंशिक बादल'), findsOneWidget);
    expect(find.textContaining('अधिक:२९°'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the page wears the app\'s own chrome, not a profile hero', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const WeatherView()),
      ),
    );
    await tester.pumpAndSettle();

    // Data screens in this app carry an AppTopBar with a title. Weather used
    // to build a full-bleed gradient hero with a bare back arrow and no
    // title — the chrome reserved for profile screens.
    final topBar = find.byType(AppTopBar);
    expect(topBar, findsOneWidget);
    expect(
      find.descendant(of: topBar, matching: find.text('Weather')),
      findsOneWidget,
    );

    // One ListView at the standard gutter, like Forex and Panchanga; not the
    // CustomScrollView nothing else on this app uses.
    expect(find.byType(CustomScrollView), findsNothing);
    final list = tester.widget<ListView>(find.byType(ListView).first);
    expect(
      list.padding,
      const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.md,
        AppSpacing.pageGutter,
        AppSpacing.xxl,
      ),
    );
  });

  testWidgets('each section is titled once, by a SectionHeader', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const WeatherView()),
      ),
    );
    await tester.pumpAndSettle();

    for (final title in ['Today', 'Next Forecast', 'Details']) {
      // Once, not twice: the cards used to repeat the heading inside
      // themselves, so adding the section headers would have doubled them.
      expect(find.text(title), findsOneWidget, reason: title);
      expect(
        find.ancestor(
          of: find.text(title),
          matching: find.byType(SectionHeader),
        ),
        findsOneWidget,
        reason: '$title should be a SectionHeader',
      );
    }
  });

  testWidgets('the cards are AppCards, so the column reads as one surface', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const WeatherView()),
      ),
    );
    await tester.pumpAndSettle();

    // Hero, stats strip, hourly, daily, details. The stats strip used to be a
    // bare tinted box among four cards.
    expect(find.byType(AppCard), findsNWidgets(5));
  });

  testWidgets('renders in dark without overflowing', (tester) async {
    tester.view.physicalSize = const Size(360, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const WeatherView()),
        themeMode: ThemeMode.dark,
      ),
    );
    await tester.pumpAndSettle();

    // 360dp is the narrowest phone this ships to; the hero's 56pt temperature
    // and the condition text share that row.
    expect(tester.takeException(), isNull);
    expect(find.byType(AppTopBar), findsOneWidget);
  });

  // Nepali and Hindi run wider than the English this was laid out against,
  // and 360dp is an ordinary Android phone. Both the stats strip and the
  // section headers overflowed there before.

  for (final width in [320.0, 360.0, 390.0]) {
    for (final locale in [const Locale('en'), const Locale('ne')]) {
      testWidgets('fits at ${width.toInt()}dp in ${locale.languageCode}', (
        tester,
      ) async {
        tester.view.physicalSize = Size(width, 2000);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final cubit = _cubit();
        await tester.pumpWidget(
          _app(
            BlocProvider.value(
              value: cubit..load(),
              child: const WeatherView(),
            ),
            locale: locale,
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  }
}
