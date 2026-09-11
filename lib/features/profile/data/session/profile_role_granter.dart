import '../../../../core/session/app_role.dart';
import '../../../../core/session/role_granter.dart';
import '../../domain/entities/user_profile.dart';
import '../datasources/profile_local_data_source.dart';

/// Writes a granted role onto the stored profile.
///
/// Adds to the profile's role set rather than replacing it: an astrologer
/// who also runs a shop, or a staff member who consults, must not lose one
/// role by gaining another.
class ProfileRoleGranter implements RoleGranter {
  const ProfileRoleGranter(this._profiles);

  final ProfileLocalDataSource _profiles;

  @override
  Future<void> grant(AppRole role) async {
    final target = _persistedFor(role);
    if (target == null) return;
    final current = _profiles.read();
    if (current.roles.contains(target)) return;
    await _profiles.write(current.copyWith(roles: {...current.roles, target}));
  }

  @override
  Future<void> revoke(AppRole role) async {
    final target = _persistedFor(role);
    if (target == null) return;
    final current = _profiles.read();
    if (!current.roles.contains(target)) return;
    final remaining = {...current.roles}..remove(target);
    await _profiles.write(
      // Never leave an account with no role at all.
      current.copyWith(roles: remaining.isEmpty ? {UserRole.user} : remaining),
    );
  }

  /// Staff roles have no representation on the profile record — they are
  /// assigned server-side and are not something the app grants itself.
  UserRole? _persistedFor(AppRole role) => switch (role) {
    AppRole.astrologer => UserRole.astrologer,
    AppRole.merchant => UserRole.seller,
    _ => null,
  };
}
