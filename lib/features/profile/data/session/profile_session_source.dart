import '../../../../core/session/app_role.dart';
import '../../../../core/session/app_session.dart';
import '../../../../core/session/session_source.dart';
import '../../domain/entities/user_profile.dart';
import '../datasources/profile_local_data_source.dart';

/// Builds the runtime [AppSession] from the stored user profile.
///
/// The profile carries one primary [UserRole]; authorization needs a *set*
/// of [AppRole]s, so the mapping happens here — the single place that knows
/// how a persisted role expands into runtime capabilities.
class ProfileSessionSource implements SessionSource {
  const ProfileSessionSource(this._profiles);

  final ProfileLocalDataSource _profiles;

  @override
  Future<AppSession> load() async {
    final profile = _profiles.read();
    return AppSession(
      userId: profile.id,
      name: profile.name,
      avatarUrl: profile.avatarUrl,
      roles: rolesForAll(profile.roles),
      isAuthenticated: profile.id.isNotEmpty,
    );
  }

  /// Union of what every held role grants.
  static Set<AppRole> rolesForAll(Set<UserRole> roles) => {
    for (final role in roles) ...rolesFor(role),
  };

  /// Every signed-in user is a seeker; each held role adds to that.
  ///
  /// `admin` maps to `superAdmin` so the existing seeded demo account keeps
  /// reaching the moderation screens.
  static Set<AppRole> rolesFor(UserRole role) => switch (role) {
    UserRole.user => const {AppRole.seeker},
    UserRole.astrologer => const {AppRole.seeker, AppRole.astrologer},
    UserRole.seller => const {AppRole.seeker, AppRole.merchant},
    UserRole.admin => const {AppRole.seeker, AppRole.superAdmin},
  };
}
