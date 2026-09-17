import '../../../../core/session/session_refresher.dart';
import '../../../../core/session/session_sync.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

/// [SessionSync] backed by the profile, which is where roles are cached.
class ProfileSessionSync implements SessionSync {
  const ProfileSessionSync({
    required ProfileRepository profiles,
    required ProfileLocalDataSource local,
    required SessionRefresher refresher,
  }) : _profiles = profiles,
       _local = local,
       _refresher = refresher;

  final ProfileRepository _profiles;
  final ProfileLocalDataSource _local;
  final SessionRefresher _refresher;

  @override
  Future<void> syncFromServer() async {
    // A Result, never a throw: offline keeps the cached account.
    await _profiles.getProfile();
    await _refresher.refresh();
  }

  @override
  Future<void> adoptSignedInUser(String userId) async {
    if (_local.read().id != userId) {
      // Another account's cached profile — and its roles — must not survive
      // into this one's session, not even for the second a fetch takes. This
      // is how an approved astrologer's console could open for the next
      // person to sign in on the same phone.
      await _local.clear();
      await _refresher.refresh();
    }
    await syncFromServer();
  }
}
