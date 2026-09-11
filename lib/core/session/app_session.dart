import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_role.dart';
import 'permission.dart';

part 'app_session.freezed.dart';

/// Who is using the app right now, and what they are allowed to do.
///
/// Held by `SessionCubit`, exposed to the widget tree through `SessionScope`
/// and to the data layer through `SessionResolver`. Features never read the
/// cubit directly — the same rule the region system follows.
@freezed
abstract class AppSession with _$AppSession {
  const AppSession._();

  const factory AppSession({
    String? userId,
    @Default('') String name,
    String? avatarUrl,

    /// Every role this account holds. A user can be several at once.
    @Default({AppRole.seeker}) Set<AppRole> roles,

    /// Which role's UI is being shown. Null means the default for [roles].
    AppRole? activeRole,
    @Default(false) bool isAuthenticated,
  }) = _AppSession;

  /// Signed-out session: browsing is allowed, nothing else is.
  static const AppSession guest = AppSession(roles: {});

  /// Resolved union of everything [roles] grants.
  Set<Permission> get permissions => Permission.ofRoles(roles);

  bool can(Permission permission) => permissions.contains(permission);

  bool canAll(Iterable<Permission> required) =>
      required.every(permissions.contains);

  bool canAny(Iterable<Permission> required) =>
      required.any(permissions.contains);

  bool hasRole(AppRole role) => roles.contains(role);

  bool get isStaff => roles.any((r) => r.isStaff);

  /// Roles the user can switch the UI between; only meaningful when more
  /// than one is present.
  List<AppRole> get switchableRoles =>
      roles.where((r) => r.isSwitchable).toList()
        ..sort((a, b) => a.index.compareTo(b.index));

  /// [activeRole] if still held, otherwise the first switchable role, and
  /// [AppRole.seeker] as the floor.
  AppRole get effectiveRole {
    if (activeRole != null && roles.contains(activeRole)) return activeRole!;
    final switchable = switchableRoles;
    return switchable.isEmpty ? AppRole.seeker : switchable.first;
  }

  bool get canSwitchRole => switchableRoles.length > 1;
}
