import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'permission.dart';
import 'session_scope.dart';

/// Declarative route guard.
///
/// Replaces per-route hand-written `redirect` closures: a route states the
/// permission it needs and where to send someone who lacks it, and the
/// registry does the rest.
///
/// ```dart
/// GoRoute(
///   path: AppRoutes.adminBusinesses,
///   redirect: RouteGuard.require(
///     Permission.approveBusiness,
///     fallback: AppRoutes.profile,
///   ),
///   builder: (_, _) => const AdminBusinessesPage(),
/// )
/// ```
///
/// This is navigation hygiene, not security: it stops a user reaching a
/// screen they cannot use. The server is what actually denies the action.
abstract final class RouteGuard {
  /// Redirects to [fallback] unless the session holds [permission].
  static GoRouterRedirect require(
    Permission permission, {
    required String fallback,
  }) => requireAny([permission], fallback: fallback);

  /// Redirects to [fallback] unless the session holds at least one of
  /// [permissions].
  static GoRouterRedirect requireAny(
    List<Permission> permissions, {
    required String fallback,
  }) {
    return (BuildContext context, GoRouterState state) {
      final session = SessionScope.read(context);
      return session.canAny(permissions) ? null : fallback;
    };
  }

  /// Redirects to [signInPath] when nobody is signed in.
  static GoRouterRedirect requireAuth({required String signInPath}) {
    return (BuildContext context, GoRouterState state) {
      final session = SessionScope.read(context);
      if (session.isAuthenticated) return null;
      return Uri(
        path: signInPath,
        queryParameters: {'from': state.uri.toString()},
      ).toString();
    };
  }

  /// Runs [guards] in order and returns the first redirect produced.
  static GoRouterRedirect all(List<GoRouterRedirect> guards) {
    return (BuildContext context, GoRouterState state) {
      for (final guard in guards) {
        final redirect = guard(context, state);
        if (redirect is String) return redirect;
      }
      return null;
    };
  }
}
