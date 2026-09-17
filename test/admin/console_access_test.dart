import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/admin/domain/entities/admin_session.dart';
import 'package:sanathan_nepal_mobile_app/admin/router/admin_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/permission.dart';

/// The console decides what to render from the roles in the token, so these
/// tests are about what staff are *not* shown. A regression here does not
/// break a screen — it quietly offers a finance reviewer a payout button they
/// will be 403'd on, or worse, offers a seeker the console at all.
void main() {
  AdminSession sessionFor(Set<AppRole> roles) =>
      AdminSession(userId: 'u1', roles: roles);

  group('AdminSession', () {
    test('a seeker is not staff', () {
      expect(sessionFor({AppRole.seeker}).isStaff, isFalse);
    });

    test('an astrologer is not staff either', () {
      // Holding a professional role is not the same as holding a staff one —
      // an astrologer must never reach the moderation queue.
      expect(sessionFor({AppRole.astrologer}).isStaff, isFalse);
    });

    for (final role in [
      AppRole.moderator,
      AppRole.finance,
      AppRole.support,
      AppRole.superAdmin,
    ]) {
      test('${role.name} is staff', () {
        expect(sessionFor({role}).isStaff, isTrue);
      });
    }

    test('permissions are the union of every role held', () {
      final session = sessionFor({AppRole.moderator, AppRole.finance});

      expect(session.can(Permission.moderateContent), isTrue);
      expect(session.can(Permission.runPayouts), isTrue);
      // Neither role grants it, so the union must not either.
      expect(session.can(Permission.manageFeatureFlags), isFalse);
    });

    test('falls back to the phone number when there is no display name', () {
      expect(
        sessionFor({AppRole.support}).copyWith(phone: '+9779812345678').label,
        '+9779812345678',
      );
    });
  });

  group('console navigation', () {
    test('a moderator is offered only what they hold', () {
      final destinations = ConsoleDestination.permittedFor(
        sessionFor({AppRole.moderator}).permissions,
      );
      final paths = destinations.map((d) => d.path).toSet();

      expect(paths, contains(AdminRoutes.moderation));
      expect(paths, contains(AdminRoutes.businesses));
      expect(paths, contains(AdminRoutes.applications));
      expect(paths, contains(AdminRoutes.audit));
      // A moderator has no finance permissions at all.
      expect(paths, isNot(contains(AdminRoutes.payouts)));
      expect(paths, isNot(contains(AdminRoutes.overview)));
    });

    test('finance sees money, not moderation', () {
      final paths = ConsoleDestination.permittedFor(
        sessionFor({AppRole.finance}).permissions,
      ).map((d) => d.path).toSet();

      expect(paths, contains(AdminRoutes.payouts));
      expect(paths, contains(AdminRoutes.overview));
      expect(paths, isNot(contains(AdminRoutes.moderation)));
      expect(paths, isNot(contains(AdminRoutes.flags)));
    });

    test('superAdmin sees everything', () {
      expect(
        ConsoleDestination.permittedFor(
          sessionFor({AppRole.superAdmin}).permissions,
        ).length,
        ConsoleDestination.all.length,
      );
    });

    test('a seeker is offered nothing', () {
      // The router sends them away before this matters, but if that guard ever
      // regresses the shell must still render an empty rail, not the console.
      expect(
        ConsoleDestination.permittedFor(
          sessionFor({AppRole.seeker}).permissions,
        ),
        isEmpty,
      );
    });
  });
}
