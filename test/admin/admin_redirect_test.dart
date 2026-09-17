import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/admin/auth/cubit/admin_auth_cubit.dart';
import 'package:sanathan_nepal_mobile_app/admin/domain/entities/admin_session.dart';
import 'package:sanathan_nepal_mobile_app/admin/router/admin_router.dart';
import 'package:sanathan_nepal_mobile_app/admin/router/admin_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';

/// The console's front door since `/` became the static landing site. These
/// pin who ends up where — and that no combination of session and URL can
/// send the browser round in circles.
void main() {
  const signedOut = AdminAuthState();
  const restoring = AdminAuthState(session: LoadState.loading());

  AdminAuthState signedInAs(Set<AppRole> roles) => AdminAuthState(
    session: LoadState.loaded(AdminSession(userId: 'u1', roles: roles)),
  );

  String? go(String location, AdminAuthState auth) =>
      AdminRouter.redirectFor(Uri.parse(location), auth);

  String firstPermitted(Set<AppRole> roles) => ConsoleDestination.permittedFor(
    AdminSession(userId: 'u1', roles: roles).permissions,
  ).first.path;

  String signInFrom(String path) =>
      Uri(path: AdminRoutes.signIn, queryParameters: {'from': path}).toString();

  group('the bare domain', () {
    test('is sign-in inside the app, whoever is asking', () {
      for (final auth in [
        signedOut,
        restoring,
        signedInAs({AppRole.superAdmin}),
      ]) {
        expect(go('/', auth), AdminRoutes.signIn);
      }
    });
  });

  group('signed out', () {
    test('a console deep link goes to sign-in and remembers the page', () {
      expect(
        go(AdminRoutes.payouts, signedOut),
        signInFrom(AdminRoutes.payouts),
      );
    });

    test('the /console alias goes to plain sign-in', () {
      expect(go(AdminRoutes.console, signedOut), AdminRoutes.signIn);
    });

    test('sign-in itself stays put', () {
      expect(go(AdminRoutes.signIn, signedOut), isNull);
    });

    test('a look-alike path is not treated as the console', () {
      expect(go('/consoles', signedOut), isNull);
    });
  });

  group('while a stored session is restoring', () {
    test('a refresh on a console page waits at sign-in, remembering it', () {
      expect(go(AdminRoutes.audit, restoring), signInFrom(AdminRoutes.audit));
    });

    test('sign-in does not move', () {
      expect(go(signInFrom(AdminRoutes.audit), restoring), isNull);
    });
  });

  group('staff on sign-in', () {
    test('return to the page they came from', () {
      expect(
        go(signInFrom(AdminRoutes.moderation), signedInAs({AppRole.moderator})),
        AdminRoutes.moderation,
      );
    });

    test('go to their first section when they may not open that page', () {
      expect(
        go(signInFrom(AdminRoutes.payouts), signedInAs({AppRole.moderator})),
        firstPermitted({AppRole.moderator}),
      );
    });

    for (final hostile in [
      'https://evil.example/',
      '//evil.example',
      '/sign-in',
      'javascript:alert(1)',
    ]) {
      test('ignore a `from` of $hostile', () {
        expect(
          go(signInFrom(hostile), signedInAs({AppRole.finance})),
          firstPermitted({AppRole.finance}),
        );
      });
    }
  });

  group('inside the console', () {
    test('/console resolves to the first section this person holds', () {
      expect(
        go(AdminRoutes.console, signedInAs({AppRole.finance})),
        firstPermitted({AppRole.finance}),
      );
    });

    test('a section outside their permissions sends them to one inside', () {
      expect(
        go(AdminRoutes.payouts, signedInAs({AppRole.moderator})),
        firstPermitted({AppRole.moderator}),
      );
    });

    test('a permitted section renders', () {
      expect(go(AdminRoutes.payouts, signedInAs({AppRole.finance})), isNull);
    });

    test('a signed-in seeker is sent to sign-in, which explains why', () {
      expect(
        go(AdminRoutes.audit, signedInAs({AppRole.seeker})),
        signInFrom(AdminRoutes.audit),
      );
      expect(
        go(signInFrom(AdminRoutes.audit), signedInAs({AppRole.seeker})),
        isNull,
      );
    });
  });

  test('no session and no URL can loop', () {
    final states = <String, AdminAuthState>{
      'signed out': signedOut,
      'restoring': restoring,
      for (final role in AppRole.values) role.name: signedInAs({role}),
    };
    final starts = [
      '/',
      AdminRoutes.signIn,
      AdminRoutes.console,
      '${AdminRoutes.console}/nowhere',
      for (final d in ConsoleDestination.all) ...[d.path, signInFrom(d.path)],
    ];

    for (final MapEntry(key: who, value: auth) in states.entries) {
      for (final start in starts) {
        final visited = <String>[start];
        var next = go(start, auth);
        while (next != null) {
          expect(
            visited,
            isNot(contains(next)),
            reason: '$who loops: ${[...visited, next].join(' → ')}',
          );
          expect(
            visited.length,
            lessThan(4),
            reason: '$who takes too many hops from $start',
          );
          visited.add(next);
          next = go(next, auth);
        }
      }
    }
  });
}
