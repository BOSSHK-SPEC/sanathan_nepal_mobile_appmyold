import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/wallet/wallet_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/wallet/wallet_routes.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  final sl = GetIt.instance;

  void register(Region region) {
    sl
      ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
      ..registerLazySingleton<RegionResolver>(
        () => FixedRegionResolver(region),
      );
    registerWalletFeature(sl);
  }

  setUp(() => register(Region.nepal));
  tearDown(sl.reset);

  Widget app({
    String initialLocation = AppRoutes.wallet,
    Region region = Region.nepal,
    Locale locale = const Locale('en'),
    AppSession session = const AppSession(
      userId: 'u1',
      isAuthenticated: true,
      roles: {AppRole.seeker},
    ),
    ThemeData? theme,
  }) => SessionScope(
    session: session,
    child: RegionScope(
      region: region,
      child: MaterialApp.router(
        theme: theme ?? AppTheme.light(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: GoRouter(
          initialLocation: initialLocation,
          routes: [
            ...walletRoutes,
            GoRoute(
              path: AppRoutes.home,
              builder: (_, _) => const Scaffold(body: Text('HOME')),
            ),
          ],
        ),
      ),
    ),
  );

  group('WalletPage', () {
    testWidgets('shows the balance and recent activity', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      expect(find.text('Available balance'), findsOneWidget);
      expect(find.text('Recent activity'), findsOneWidget);
      expect(find.text('Add money'), findsWidgets);
    });

    testWidgets('surfaces bonus credit separately from real credit', (
      tester,
    ) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      expect(find.text('Bonus credit'), findsOneWidget);
      expect(
        find.text('Spendable on consultations, not withdrawable'),
        findsOneWidget,
      );
    });

    testWidgets('renders in Nepali and in the dark theme', (tester) async {
      await tester.pumpWidget(
        app(locale: const Locale('ne'), theme: AppTheme.dark()),
      );
      await tester.pumpAndSettle();
      expect(find.text('उपलब्ध ब्यालेन्स'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a signed-out session is redirected away', (tester) async {
      await tester.pumpWidget(app(session: AppSession.guest));
      await tester.pumpAndSettle();
      expect(find.text('HOME'), findsOneWidget);
      expect(find.text('Available balance'), findsNothing);
    });
  });

  group('TopUpPage', () {
    testWidgets('step 1 offers tiers; Continue unlocks step 2', (tester) async {
      await tester.pumpWidget(app(initialLocation: AppRoutes.walletTopUp));
      await tester.pumpAndSettle();

      expect(find.text('Choose an amount'), findsWidgets);
      // The popular tier is pre-selected, so Continue is already live.
      expect(find.text('Popular'), findsOneWidget);

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('How would you like to pay?'), findsOneWidget);
      expect(find.text('eSewa'), findsOneWidget);
      expect(find.text('Khalti'), findsOneWidget);
      // Cash cannot fund a wallet.
      expect(find.text('Cash'), findsNothing);
    });

    testWidgets('India offers UPI, not eSewa', (tester) async {
      await sl.reset();
      register(Region.india);
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.walletTopUp, region: Region.india),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('UPI'), findsOneWidget);
      expect(find.text('eSewa'), findsNothing);
    });

    testWidgets('Pay now stays disabled until a method is chosen', (
      tester,
    ) async {
      await tester.pumpWidget(app(initialLocation: AppRoutes.walletTopUp));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Tapping with no method selected must not navigate anywhere.
      await tester.tap(find.text('Pay now'));
      await tester.pumpAndSettle();
      expect(find.text('How would you like to pay?'), findsOneWidget);

      await tester.tap(find.text('eSewa'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pay now'));
      // Not pumpAndSettle: the status screen polls on a periodic timer and
      // never reaches a settled frame while it is confirming.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump();

      expect(find.text('Confirming your payment'), findsOneWidget);

      // Leave via the close action so the status page — and its poll timer —
      // is disposed the way it would be in the app.
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();
      expect(find.text('Available balance'), findsOneWidget);
    });
  });

  group('TransactionsPage', () {
    testWidgets('groups entries and totals money in and out', (tester) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.walletTransactions),
      );
      await tester.pumpAndSettle();

      // Each label appears twice: once as a filter chip, once as a stat.
      expect(find.text('Money in'), findsNWidgets(2));
      expect(find.text('Money out'), findsNWidgets(2));
      expect(find.text('Consultation'), findsWidgets);
    });

    testWidgets('the direction filter narrows to credits only', (tester) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.walletTransactions),
      );
      await tester.pumpAndSettle();

      // "Money in" appears twice; the filter chip is first in the tree, and
      // it sits in a horizontal scroller so it may start off-screen.
      final chip = find.text('Money in').first;
      await tester.ensureVisible(chip);
      await tester.pumpAndSettle();
      await tester.tap(chip);
      await tester.pumpAndSettle();

      expect(find.text('Consultation'), findsNothing);
      expect(find.text('Money added'), findsWidgets);
    });
  });

  group('RefundRequestPage', () {
    testWidgets('Other requires details before submitting', (tester) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.walletRefundPath('tx-seed-3')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Something else'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Submit request'));
      await tester.pumpAndSettle();
      // Still on the form — nothing was submitted.
      expect(find.text('Reason'), findsOneWidget);

      await tester.enterText(
        find.byType(TextFormField).last,
        'The astrologer never joined',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Submit request'));
      await tester.pumpAndSettle();

      // Deep-linked with nothing beneath, so it exits to the wallet rather
      // than leaving the user on a submitted form.
      expect(find.text('Reason'), findsNothing);
      expect(find.text('Available balance'), findsOneWidget);
    });
  });
}
