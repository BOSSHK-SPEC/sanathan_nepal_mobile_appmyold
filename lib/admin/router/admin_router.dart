import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../auth/cubit/admin_auth_cubit.dart';
import '../features/applications/applications_page.dart';
import '../features/audit/audit_page.dart';
import '../features/businesses/businesses_page.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/flags/flags_page.dart';
import '../features/moderation/moderation_page.dart';
import '../features/payouts/payouts_page.dart';
import '../landing/landing_page.dart';
import '../shell/admin_shell.dart';
import 'admin_routes.dart';

/// The console's router, with authorization as a redirect rather than a check
/// inside each page.
///
/// Doing it here means an unauthenticated deep link to `/console/payouts` —
/// pasted, bookmarked, or restored by the browser on reload — never builds the
/// page at all. A guard inside the page would render its scaffold first and
/// fire its first request before deciding it should not exist.
abstract final class AdminRouter {
  static GoRouter create(AdminAuthCubit auth) {
    return GoRouter(
      initialLocation: AdminRoutes.landing,
      // Rebuilds the redirect whenever sign-in state changes, so signing in
      // moves the user without the login panel having to know where to send
      // them, and signing out ejects every open console tab.
      refreshListenable: _CubitListenable(auth.stream),
      redirect: (context, state) {
        final path = state.uri.path;
        final inConsole = path.startsWith(AdminRoutes.console);
        final session = auth.state.user;

        // Still restoring a stored session: hold at the landing page rather
        // than bouncing someone out of a console they are entitled to.
        if (auth.state.session.isLoading) {
          return inConsole ? AdminRoutes.landing : null;
        }

        if (!inConsole) return null;

        // Not signed in, or signed in as somebody who does not belong here.
        // Both land on the public page, which explains the second case.
        if (session == null || !session.isStaff) return AdminRoutes.landing;

        // `/console` is an alias for "wherever this person can actually go".
        // A moderator has no finance permission, so sending everyone to the
        // overview would greet half the staff with an error.
        if (path == AdminRoutes.console) {
          final permitted = ConsoleDestination.permittedFor(session.permissions);
          return permitted.isEmpty
              ? AdminRoutes.landing
              : permitted.first.path;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: AdminRoutes.landing,
          builder: (context, state) => const LandingPage(),
        ),
        ShellRoute(
          builder: (context, state, child) =>
              AdminShell(location: state.uri.path, child: child),
          routes: [
            GoRoute(
              path: AdminRoutes.console,
              redirect: (_, _) => AdminRoutes.overview,
            ),
            GoRoute(
              path: AdminRoutes.overview,
              builder: (context, state) => const DashboardPage(),
            ),
            GoRoute(
              path: AdminRoutes.applications,
              builder: (context, state) => const ApplicationsPage(),
            ),
            GoRoute(
              path: AdminRoutes.businesses,
              builder: (context, state) => const BusinessesPage(),
            ),
            GoRoute(
              path: AdminRoutes.moderation,
              builder: (context, state) => const ModerationPage(),
            ),
            GoRoute(
              path: AdminRoutes.payouts,
              builder: (context, state) => const PayoutsPage(),
            ),
            GoRoute(
              path: AdminRoutes.flags,
              builder: (context, state) => const FlagsPage(),
            ),
            GoRoute(
              path: AdminRoutes.audit,
              builder: (context, state) => const AuditPage(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const LandingPage(),
    );
  }
}

/// Bridges a cubit's stream onto the [Listenable] go_router wants.
class _CubitListenable extends ChangeNotifier {
  _CubitListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
