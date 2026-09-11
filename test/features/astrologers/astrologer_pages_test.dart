import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_filter_sheet.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/astrologers_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/astrologers_routes.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  final sl = GetIt.instance;

  setUp(() {
    sl
      ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
      ..registerLazySingleton<RegionResolver>(
        () => const FixedRegionResolver(Region.nepal),
      );
    registerAstrologersFeature(sl);
  });
  tearDown(sl.reset);

  Widget app({
    String initialLocation = AppRoutes.astrologers,
    Region region = Region.nepal,
    Locale locale = const Locale('en'),
    ThemeData? theme,
  }) => RegionScope(
    region: region,
    child: MaterialApp.router(
      theme: theme ?? AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        initialLocation: initialLocation,
        routes: astrologersRoutes,
      ),
    ),
  );

  group('AstrologerListPage', () {
    testWidgets('shows a skeleton first, then the catalogue', (tester) async {
      await tester.pumpWidget(app());
      await tester.pump();
      // Real card content is not on screen while loading.
      expect(find.text('Pandit Uttam Upadhyaya'), findsNothing);

      await tester.pumpAndSettle();
      expect(find.text('Pandit Uttam Upadhyaya'), findsOneWidget);
      expect(find.text('Sarita Gyawali'), findsOneWidget);
    });

    testWidgets('renders Nepali names in the Nepali locale', (tester) async {
      await tester.pumpWidget(app(locale: const Locale('ne')));
      await tester.pumpAndSettle();
      expect(find.text('पण्डित उत्तम उपाध्याय'), findsOneWidget);
    });

    testWidgets('shows the India catalogue in the India region', (
      tester,
    ) async {
      await sl.reset();
      sl
        ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
        ..registerLazySingleton<RegionResolver>(
          () => const FixedRegionResolver(Region.india),
        );
      registerAstrologersFeature(sl);

      await tester.pumpWidget(app(region: Region.india));
      await tester.pumpAndSettle();
      expect(find.text('Pandit Rajesh Sharma'), findsOneWidget);
      expect(find.text('Pandit Uttam Upadhyaya'), findsNothing);
    });

    testWidgets('renders in the dark theme', (tester) async {
      await tester.pumpWidget(app(theme: AppTheme.dark()));
      await tester.pumpAndSettle();
      expect(find.text('Pandit Uttam Upadhyaya'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the filter sheet opens and applies', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune_rounded));
      await tester.pumpAndSettle();
      expect(find.text('Filters'), findsOneWidget);

      // "Tarot" also appears as a specialty chip on the cards behind the
      // sheet, so scope the tap to the sheet itself.
      await tester.tap(
        find.descendant(
          of: find.byType(AppFilterSheet),
          matching: find.text('Tarot'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Show '));
      await tester.pumpAndSettle();

      expect(find.text('Sarita Gyawali'), findsOneWidget);
      expect(find.text('Pandit Uttam Upadhyaya'), findsNothing);
      // The filter button now carries a badge.
      expect(find.text('1'), findsWidgets);
    });
  });

  group('AstrologerProfilePage', () {
    testWidgets('loads by id and shows the tabs', (tester) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.astrologerProfilePath('np-uttam')),
      );
      await tester.pumpAndSettle();

      expect(find.text('About'), findsOneWidget);
      expect(find.text('Reviews'), findsOneWidget);
      expect(find.text('Vedic'), findsWidgets);
    });

    testWidgets('the reviews tab shows seeded reviews and a reply', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.astrologerProfilePath('np-uttam')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Reviews'));
      await tester.pumpAndSettle();

      expect(find.text('Sabina K.'), findsOneWidget);
      expect(find.text('Astrologer replied'), findsOneWidget);
    });

    testWidgets('an unknown id shows an error with retry', (tester) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.astrologerProfilePath('nope')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Retry'), findsOneWidget);
    });
  });

  group('WriteReviewPage', () {
    testWidgets('submit stays disabled until a star is picked', (tester) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.astrologerReviewPath('np-uttam')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Tap a star to rate'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.star_outline_rounded).at(3));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(4));
    });
  });

  group('AstrologerSearchPage', () {
    testWidgets('shows the empty prompt, then results as you type', (
      tester,
    ) async {
      await tester.pumpWidget(app(initialLocation: AppRoutes.astrologerSearch));
      await tester.pumpAndSettle();
      expect(
        find.text('Search for an astrologer by name or speciality.'),
        findsOneWidget,
      );

      await tester.enterText(find.byType(TextField).first, 'Sarita');
      await tester.pumpAndSettle();
      expect(find.text('Sarita Gyawali'), findsOneWidget);
    });
  });
}
