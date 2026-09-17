import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/auth_session_manager.dart';
import '../../core/session/session_refresher.dart';
import '../../features/onboarding/domain/repositories/auth_presence.dart';
import '../di/injection.dart';
import 'app_routes.dart';

/// Keeps every screen except the way in behind a live login.
///
/// Before this, nothing did: signing out left the "onboarding completed" flag
/// set, the splash went straight to Home on the next launch, and any route
/// could be opened without a session. The gate is the router's `redirect`, so
/// it applies to every navigation — a tap, a deep link, a notification, the
/// back stack — not only to the paths someone remembered to guard.
///
/// "Signed in" means a stored login ([AuthPresence]: the refresh token live, the
/// mock's own flag in mock builds), not a cached profile: someone whose profile
/// could not be fetched at sign-in is still signed in.
class AuthGate extends ChangeNotifier {
  AuthGate({
    required bool Function() isSignedIn,
    Stream<Object?>? sessionEnded,
    Future<void> Function()? onSessionEnded,
  }) : _isSignedIn = isSignedIn,
       _onSessionEnded = onSessionEnded {
    _subscription = sessionEnded?.listen((_) async {
      await _onSessionEnded?.call();
      // Re-runs the redirect for the screen on show, so a login that expires
      // mid-use lands on the sign-in screen instead of a page that can only
      // fail from here on.
      notifyListeners();
    });
  }

  /// The gate as the app runs it.
  factory AuthGate.live() => AuthGate(
    isSignedIn: () => sl<AuthPresence>().isSignedIn,
    sessionEnded: sl<AuthSessionManager>().onSignOut,
    onSessionEnded: () => sl<SessionRefresher>().refresh(),
  );

  final bool Function() _isSignedIn;
  final Future<void> Function()? _onSessionEnded;
  StreamSubscription<Object?>? _subscription;

  /// Reachable without a login: the way in, and the policies a person is
  /// entitled to read before agreeing to them.
  static const Set<String> publicPaths = {
    AppRoutes.splash,
    AppRoutes.languageTheme,
    AppRoutes.login,
    AppRoutes.otp,
    AppRoutes.privacyPolicy,
    AppRoutes.termsConditions,
  };

  /// Where [path] should go instead, or null to let it through.
  String? redirectFor(String path) {
    if (publicPaths.contains(path) || _isSignedIn()) return null;
    return AppRoutes.login;
  }

  /// For `GoRouter.redirect`.
  String? redirect(BuildContext context, GoRouterState state) =>
      redirectFor(state.uri.path);

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }
}
