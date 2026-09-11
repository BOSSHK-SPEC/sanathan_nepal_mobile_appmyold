import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/billing/spending_account.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/kundli_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/reports/reports_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/reports/reports_routes.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  final sl = GetIt.instance;

  setUp(() {
    sl
      ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
      ..registerLazySingleton<RegionResolver>(
        () => const FixedRegionResolver(Region.nepal),
      )
      // A funded wallet, so the pay bar is exercised rather than the
      // top-up fallback.
      ..registerLazySingleton<SpendingAccount>(
        () => const NoopSpendingAccount(balance: 50000),
      );
    registerKundliFeature(sl);
    registerReportsFeature(sl);
  });
  tearDown(sl.reset);

  Widget app(String location) => SessionScope(
    session: const AppSession(
      userId: 'u1',
      isAuthenticated: true,
      roles: {AppRole.seeker},
    ),
    child: RegionScope(
      region: Region.nepal,
      child: MaterialApp.router(
        theme: AppTheme.light(),
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: GoRouter(
          initialLocation: location,
          routes: [
            ...reportsRoutes,
            GoRoute(
              path: AppRoutes.home,
              builder: (_, _) => const Scaffold(body: Text('HOME')),
            ),
          ],
        ),
      ),
    ),
  );

  group('ReportsCataloguePage', () {
    testWidgets('lists the products with their page counts', (tester) async {
      await tester.pumpWidget(app(AppRoutes.reports));
      await tester.pumpAndSettle();

      expect(find.text('Complete life report'), findsOneWidget);
      expect(find.text('Marriage matching report'), findsOneWidget);
      expect(find.text('48 pages'), findsOneWidget);
    });

    testWidgets('a discounted product shows the saving', (tester) async {
      await tester.pumpWidget(app(AppRoutes.reports));
      await tester.pumpAndSettle();
      expect(find.textContaining('% off'), findsWidgets);
    });
  });

  group('ReportDetailsPage', () {
    testWidgets('shows the contents and the pay bar', (tester) async {
      await tester.pumpWidget(app(AppRoutes.reportDetailsPath('report-life')));
      await tester.pumpAndSettle();

      expect(find.text('What is inside'), findsOneWidget);
      expect(find.text('Pay and generate'), findsOneWidget);
      expect(find.text('Wallet balance'), findsOneWidget);
    });

    testWidgets('with no birth profile saved it points at the form', (
      tester,
    ) async {
      await tester.pumpWidget(app(AppRoutes.reportDetailsPath('report-life')));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('No birth details saved'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Add a birth profile'), findsOneWidget);
    });
  });

  group('MyReportsPage', () {
    testWidgets('empty until something is bought', (tester) async {
      await tester.pumpWidget(app(AppRoutes.myReports));
      await tester.pumpAndSettle();
      expect(find.text('No reports yet'), findsOneWidget);
      expect(find.text('Browse reports'), findsOneWidget);
    });
  });
}
