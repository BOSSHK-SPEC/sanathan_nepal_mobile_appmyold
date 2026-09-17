import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session.dart';

void main() {
  group('Permission mapping', () {
    test('a seeker can book and buy but cannot moderate', () {
      const session = AppSession(roles: {AppRole.seeker});
      expect(session.can(Permission.bookConsultation), isTrue);
      expect(session.can(Permission.purchaseProducts), isTrue);
      expect(session.can(Permission.moderateContent), isFalse);
      expect(session.can(Permission.viewAstrologerConsole), isFalse);
    });

    test('roles union rather than override', () {
      const session = AppSession(roles: {AppRole.seeker, AppRole.astrologer});
      expect(session.can(Permission.bookConsultation), isTrue);
      expect(session.can(Permission.viewAstrologerConsole), isTrue);
      expect(session.can(Permission.manageAvailability), isTrue);
      // Selling time does not grant selling goods.
      expect(session.can(Permission.manageProducts), isFalse);
    });

    test(
      'superAdmin holds every permission except the astrologer workspace',
      () {
        // The astrologer console acts on the caller's *own* astrologer profile.
        // An admin is not an astrologer by being an admin, and that console must
        // stay shut until an application is approved — so staff get everything
        // administrative, and the workspace only through the astrologer role.
        const session = AppSession(roles: {AppRole.superAdmin});
        for (final p in Permission.values) {
          expect(
            session.can(p),
            !Permission.astrologerWorkspace.contains(p),
            reason: '$p',
          );
        }
      },
    );

    test('staff roles are scoped, not omnipotent', () {
      const finance = AppSession(roles: {AppRole.finance});
      expect(finance.can(Permission.runPayouts), isTrue);
      expect(finance.can(Permission.moderateContent), isFalse);
      expect(finance.can(Permission.manageStaff), isFalse);

      const moderator = AppSession(roles: {AppRole.moderator});
      expect(moderator.can(Permission.approveBusiness), isTrue);
      expect(moderator.can(Permission.runPayouts), isFalse);
    });

    test('guest holds nothing', () {
      expect(AppSession.guest.permissions, isEmpty);
      expect(AppSession.guest.isAuthenticated, isFalse);
      expect(AppSession.guest.can(Permission.bookConsultation), isFalse);
    });

    test('canAll and canAny', () {
      const session = AppSession(roles: {AppRole.seeker});
      expect(
        session.canAll([Permission.bookConsultation, Permission.manageWallet]),
        isTrue,
      );
      expect(
        session.canAll([Permission.bookConsultation, Permission.runPayouts]),
        isFalse,
      );
      expect(
        session.canAny([Permission.runPayouts, Permission.manageWallet]),
        isTrue,
      );
    });
  });

  group('Active role', () {
    test('falls back to the first switchable role when unset', () {
      const session = AppSession(roles: {AppRole.seeker, AppRole.astrologer});
      expect(session.effectiveRole, AppRole.seeker);
      expect(session.canSwitchRole, isTrue);
    });

    test('ignores an active role the user no longer holds', () {
      const session = AppSession(
        roles: {AppRole.seeker},
        activeRole: AppRole.astrologer,
      );
      expect(session.effectiveRole, AppRole.seeker);
    });

    test('staff-only roles are not switchable UI contexts', () {
      const session = AppSession(roles: {AppRole.seeker, AppRole.finance});
      expect(session.switchableRoles, [AppRole.seeker]);
      expect(session.canSwitchRole, isFalse);
      expect(session.isStaff, isTrue);
    });
  });

  group('RouteGuard', () {
    Future<String?> redirectFor(
      WidgetTester tester,
      AppSession session,
      GoRouterRedirect guard,
    ) async {
      String? captured;
      var evaluated = false;
      await tester.pumpWidget(
        SessionScope(
          session: session,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: '/guarded',
              routes: [
                GoRoute(
                  path: '/guarded',
                  redirect: (context, state) {
                    evaluated = true;
                    captured = guard(context, state) as String?;
                    return captured;
                  },
                  builder: (_, _) => const Scaffold(body: Text('GUARDED')),
                ),
                GoRoute(
                  path: '/fallback',
                  builder: (_, _) => const Scaffold(body: Text('FALLBACK')),
                ),
                GoRoute(
                  path: '/signin',
                  builder: (_, _) => const Scaffold(body: Text('SIGNIN')),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(evaluated, isTrue);
      return captured;
    }

    testWidgets('require lets a permitted session through', (tester) async {
      final redirect = await redirectFor(
        tester,
        const AppSession(roles: {AppRole.moderator}),
        RouteGuard.require(Permission.approveBusiness, fallback: '/fallback'),
      );
      expect(redirect, isNull);
      expect(find.text('GUARDED'), findsOneWidget);
    });

    testWidgets('require redirects a session without the permission', (
      tester,
    ) async {
      final redirect = await redirectFor(
        tester,
        const AppSession(roles: {AppRole.seeker}),
        RouteGuard.require(Permission.approveBusiness, fallback: '/fallback'),
      );
      expect(redirect, '/fallback');
      expect(find.text('FALLBACK'), findsOneWidget);
    });

    testWidgets('requireAuth carries the original location as ?from', (
      tester,
    ) async {
      final redirect = await redirectFor(
        tester,
        AppSession.guest,
        RouteGuard.requireAuth(signInPath: '/signin'),
      );
      expect(redirect, startsWith('/signin?from='));
      expect(redirect, contains('guarded'));
    });

    testWidgets('requireAuth passes an authenticated session', (tester) async {
      final redirect = await redirectFor(
        tester,
        const AppSession(userId: 'u1', isAuthenticated: true),
        RouteGuard.requireAuth(signInPath: '/signin'),
      );
      expect(redirect, isNull);
    });

    testWidgets('all returns the first redirect produced', (tester) async {
      final redirect = await redirectFor(
        tester,
        AppSession.guest,
        RouteGuard.all([
          RouteGuard.requireAuth(signInPath: '/signin'),
          RouteGuard.require(Permission.approveBusiness, fallback: '/fallback'),
        ]),
      );
      expect(redirect, startsWith('/signin'));
    });
  });

  group('SessionScope', () {
    testWidgets('defaults to guest when no scope is present', (tester) async {
      late AppSession seen;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              seen = context.session;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(seen, AppSession.guest);
    });

    testWidgets('context.can reads the provided session', (tester) async {
      late bool canBook;
      late bool canModerate;
      await tester.pumpWidget(
        SessionScope(
          session: const AppSession(roles: {AppRole.seeker}),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                canBook = context.can(Permission.bookConsultation);
                canModerate = context.can(Permission.moderateContent);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(canBook, isTrue);
      expect(canModerate, isFalse);
    });
  });
}
