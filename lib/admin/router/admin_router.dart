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
import '../auth/sign_in_page.dart';
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
      initialLocation: AdminRoutes.signIn,
      // Rebuilds the redirect whenever sign-in state changes, so signing in
      // moves the user without the login panel having to know where to send
      // them, and signing out ejects every open console tab.
      refreshListenable: _CubitListenable(auth.stream),
      redirect: (context, state) => redirectFor(state.uri, auth.state),
      routes: [
        GoRoute(
          path: AdminRoutes.signIn,
          builder: (context, state) => const SignInPage(),
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
      errorBuilder: (context, state) => const SignInPage(),
    );
  }

  /// Where [uri] should go for someone in [auth], or null to stay.
  ///
  /// Pure, so every rule — including the ones that could loop — is pinned by
  /// `test/admin/admin_redirect_test.dart` without a browser.
  @visibleForTesting
  static String? redirectFor(Uri uri, AdminAuthState auth) {
    final path = uri.path;
    final inConsole =
        path == AdminRoutes.console ||
        path.startsWith('${AdminRoutes.console}/');
    final session = auth.user;

    // `/` belongs to the static landing site; if the app is ever served
    // there (nginx not yet updated, or a client-side go('/')), it is the
    // sign-in page's job.
    if (path == AdminRoutes.landing) return AdminRoutes.signIn;

    // Still restoring a stored session: hold at sign-in, remembering where
    // they were, rather than bouncing someone out of a page they may open.
    if (auth.session.isLoading) return inConsole ? _signInFrom(path) : null;

    final permitted = session != null && session.isStaff
        ? ConsoleDestination.permittedFor(session.permissions)
        : const <ConsoleDestination>[];

    // Staff with somewhere to go have nothing to do on the sign-in page —
    // including the moment a restored session finishes loading. They go back
    // to the page they came from if they may open it. (Staff with no
    // permitted section stay, or the console would send them back here.)
    if (path == AdminRoutes.signIn) {
      if (permitted.isEmpty) return null;
      final from = uri.queryParameters['from'];
      return permitted.any((d) => d.path == from) ? from : permitted.first.path;
    }

    if (!inConsole) return null;

    // Not signed in, or signed in as somebody who does not belong here.
    // Both land on sign-in, which explains the second case.
    if (session == null || !session.isStaff) return _signInFrom(path);
    if (permitted.isEmpty) return AdminRoutes.signIn;

    // `/console` is an alias for "wherever this person can actually go", and
    // a section they lack the permission for is not worth rendering only to
    // show a 403: a moderator opening a payouts link lands on moderation.
    final known = ConsoleDestination.all.any((d) => d.path == path);
    final allowed = permitted.any((d) => d.path == path);
    if (path == AdminRoutes.console || (known && !allowed)) {
      return permitted.first.path;
    }

    return null;
  }

  /// Sign-in that returns to [path] afterwards. Only ever a console path the
  /// router itself produced — never a URL — and re-checked against the
  /// person's permissions before it is followed, so it cannot redirect
  /// anywhere they could not already navigate.
  static String _signInFrom(String path) => path == AdminRoutes.console
      ? AdminRoutes.signIn
      : Uri(
          path: AdminRoutes.signIn,
          queryParameters: {'from': path},
        ).toString();
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
