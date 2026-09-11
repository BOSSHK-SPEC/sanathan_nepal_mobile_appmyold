import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/forex_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/mock_forex_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/repositories/forex_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/convert_currency.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/get_latest_rates.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/get_rate_history.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/manage_favourite_currencies.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/presentation/cubit/forex_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/presentation/pages/forex_page.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/presentation/widgets/forex_section.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

ForexCubit _cubit({Region region = Region.nepal}) {
  final resolver = FixedRegionResolver(region);
  final mock = MockForexDataSource(resolver);
  final repo = ForexRepositoryImpl(
    remote: mock,
    fallback: mock,
    local: ForexLocalDataSourceImpl(InMemoryKeyValueStore(), resolver),
    clock: () => DateTime(2024, 3, 7),
  );
  return ForexCubit(
    getLatestRates: GetLatestRates(repo),
    getRateHistory: GetRateHistory(repo),
    convertCurrency: const ConvertCurrency(),
    getFavourites: GetFavouriteCurrencies(repo),
    saveFavourites: SaveFavouriteCurrencies(repo),
    resolver: resolver,
  );
}

Widget _app(
  Widget home, {
  Locale locale = const Locale('en'),
  Region region = Region.nepal,
}) => RegionScope(
  region: region,
  child: MaterialApp(
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

void main() {
  testWidgets('ForexView renders trend, converter and rates table', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(BlocProvider.value(value: cubit..load(), child: const ForexView())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Foreign Exchange'), findsOneWidget);
    expect(find.text('USD TO NRS - TREND'), findsOneWidget);
    expect(find.text('Currency conversion'), findsOneWidget);
    expect(find.text('U.S. Dollar'), findsWidgets);
    expect(find.text('Indian Rupee (100)'), findsOneWidget);
    expect(find.text('Buying'), findsOneWidget);
    expect(find.text('Selling'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ForexView shows Nepali labels and Devanagari digits', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const ForexView()),
        locale: const Locale('ne'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('विदेशी विनिमय'), findsOneWidget);
    expect(find.text('मुद्रा रूपान्तरण'), findsOneWidget);
    expect(find.text('भारतीय रुपैयाँ (१००)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ForexView in India quotes against INR (English)', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit(region: Region.india);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const ForexView()),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('USD TO INR - TREND'), findsOneWidget);
    expect(find.text('USD TO NRS - TREND'), findsNothing);
    // Converter target defaults to the local currency (unit 1).
    expect(find.text('Indian Rupee'), findsWidgets);
    expect(find.text('Indian Rupee (100)'), findsNothing);
    // Gulf currencies are not in the ECB catalogue.
    expect(find.text('UAE Dirham'), findsNothing);
    expect(find.text('New Zealand Dollar'), findsOneWidget);
    expect(find.text('₹'), findsOneWidget); // chart axis symbol
    expect(find.textContaining('Frankfurter'), findsOneWidget);
    expect(cubit.state.favourites, ['USD', 'GBP', 'EUR']);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ForexView in India shows Hindi labels and Devanagari digits', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit(region: Region.india);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const ForexView()),
        region: Region.india,
        locale: const Locale('hi'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('विदेशी मुद्रा विनिमय'), findsOneWidget);
    expect(find.text('मुद्रा रूपांतरण'), findsOneWidget);
    expect(find.text('जापानी येन (१००)'), findsOneWidget);
    expect(find.text('अमेरिकी डॉलर'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ForexSection renders header rates and more-info link', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    var tapped = false;
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: SingleChildScrollView(
            child: ForexSection(
              cubit: cubit..load(),
              onMoreTap: () => tapped = true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('USD '), findsWidgets);
    expect(find.text('More Currency Information'), findsOneWidget);
    await tester.tap(find.text('More Currency Information'));
    expect(tapped, isTrue);
    expect(tester.takeException(), isNull);
  });
}
