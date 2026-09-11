import 'package:flutter/widgets.dart';

import 'app_role.dart';
import 'app_session.dart';
import 'permission.dart';

/// Makes the active [AppSession] available to the widget tree.
///
/// Provided once at the app root. Widgets ask `context.can(...)` rather than
/// inspecting roles, so a capability can move between roles without touching
/// any screen.
class SessionScope extends InheritedWidget {
  const SessionScope({required this.session, required super.child, super.key});

  final AppSession session;

  static AppSession of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SessionScope>()?.session ??
      AppSession.guest;

  /// Non-listening lookup, for callbacks and route redirects.
  static AppSession read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<SessionScope>()?.session ??
      AppSession.guest;

  @override
  bool updateShouldNotify(SessionScope oldWidget) =>
      oldWidget.session != session;
}

extension SessionContextX on BuildContext {
  /// The active session (listens for changes).
  AppSession get session => SessionScope.of(this);

  /// Whether the current user holds [permission].
  ///
  /// UI gating only — never the authorization boundary itself.
  bool can(Permission permission) => SessionScope.of(this).can(permission);

  bool canAny(Iterable<Permission> permissions) =>
      SessionScope.of(this).canAny(permissions);

  bool hasRole(AppRole role) => SessionScope.of(this).hasRole(role);

  bool get isSignedIn => SessionScope.of(this).isAuthenticated;
}
