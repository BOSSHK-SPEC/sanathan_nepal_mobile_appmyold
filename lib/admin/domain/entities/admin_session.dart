import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/session/app_role.dart';
import '../../../core/session/permission.dart';

part 'admin_session.freezed.dart';

/// Who is signed into the console, and what they may do.
///
/// The permission set is derived from the roles in the access token, using the
/// same [Permission.ofRole] table the mobile app uses — one source of truth
/// rather than a second, drifting copy for staff screens.
///
/// This is a **UI hint only**. It decides which nav items render and which
/// buttons are enabled; the server re-authorizes every single call against the
/// token. A tampered client sees more menu entries and gets 403 on all of them.
@freezed
abstract class AdminSession with _$AdminSession {
  const AdminSession._();

  const factory AdminSession({
    required String userId,
    required Set<AppRole> roles,
    @Default('') String region,
    String? displayName,
    String? phone,
  }) = _AdminSession;

  /// Everything these roles grant, unioned.
  Set<Permission> get permissions => {
    for (final role in roles) ...Permission.ofRole(role),
  };

  bool can(Permission permission) => permissions.contains(permission);

  /// Whether this account belongs in the console at all.
  ///
  /// A seeker with a valid token is correctly signed in and still has no
  /// business here — the console refuses them at the door rather than showing
  /// an empty shell whose every panel 403s.
  bool get isStaff => roles.any((role) => role.isStaff);

  /// What to greet them with when the profile has no name yet.
  String get label => displayName?.trim().isNotEmpty ?? false
      ? displayName!.trim()
      : (phone ?? 'Staff');
}
