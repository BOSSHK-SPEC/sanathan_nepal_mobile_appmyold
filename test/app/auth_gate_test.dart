import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/app/router/auth_gate.dart';

/// After signing out, restarting the app opened Home for nobody. The gate is
/// what now stands between a signed-out person and every screen but the way in.
void main() {
  group('the rule', () {
    test('a signed-out person reaches only the way in', () {
      final gate = AuthGate(isSignedIn: () => false);
      for (final path in AuthGate.publicPaths) {
        expect(gate.redirectFor(path), isNull, reason: path);
      }
      for (final path in [
        AppRoutes.home,
        AppRoutes.profile,
        '/wallet',
        '/astrologers/x',
      ]) {
        expect(gate.redirectFor(path), AppRoutes.login, reason: path);
      }
    });

    test('a signed-in person goes wherever they asked', () {
      final gate = AuthGate(isSignedIn: () => true);
      expect(gate.redirectFor(AppRoutes.home), isNull);
      expect(gate.redirectFor(AppRoutes.login), isNull);
    });

    test('the details steps of onboarding need a login too', () {
      final gate = AuthGate(isSignedIn: () => false);
      expect(gate.redirectFor(AppRoutes.detailsInput), AppRoutes.login);
      expect(
        gate.redirectFor(AppRoutes.notificationSettingsOnboarding),
        AppRoutes.login,
      );
    });
  });

  group('on the router', () {
    // Built inside each test body, not in setUp: setUp runs outside the widget
    // test's fake clock, so a stream created there delivers its events on the
    // real event loop — which never turns while the test pumps frames, and the
    // gate would never hear the session end.
    Future<({AuthGate gate, StreamController<Object?> ended, List<int> resets})>
    start(
      WidgetTester tester, {
      required bool Function() signedIn,
      required String at,
    }) async {
      final ended = StreamController<Object?>.broadcast();
      final resets = <int>[];
      final gate = AuthGate(
        isSignedIn: signedIn,
        sessionEnded: ended.stream,
        onSessionEnded: () async => resets.add(1),
      );
      addTearDown(() async {
        gate.dispose();
        await ended.close();
      });
      final router = GoRouter(
        initialLocation: at,
        redirect: gate.redirect,
        refreshListenable: gate,
        routes: [
          GoRoute(
            path: AppRoutes.login,
            builder: (_, _) => const Text('LOGIN'),
          ),
          GoRoute(path: AppRoutes.home, builder: (_, _) => const Text('HOME')),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      return (gate: gate, ended: ended, resets: resets);
    }

    testWidgets('opening Home while signed out lands on sign-in', (
      tester,
    ) async {
      await start(tester, signedIn: () => false, at: AppRoutes.home);
      expect(find.text('LOGIN'), findsOneWidget);
      expect(find.text('HOME'), findsNothing);
    });

    testWidgets('a session that ends mid-use moves the screen to sign-in', (
      tester,
    ) async {
      var signedIn = true;
      final run = await start(
        tester,
        signedIn: () => signedIn,
        at: AppRoutes.home,
      );
      expect(find.text('HOME'), findsOneWidget);

      // The refresh token expired, or the user signed out elsewhere.
      signedIn = false;
      run.ended.add(null);
      await tester.pumpAndSettle();

      expect(find.text('LOGIN'), findsOneWidget);
      expect(find.text('HOME'), findsNothing);
      expect(
        run.resets,
        hasLength(1),
        reason: "the old account's session must be cleared",
      );
    });
  });
}
