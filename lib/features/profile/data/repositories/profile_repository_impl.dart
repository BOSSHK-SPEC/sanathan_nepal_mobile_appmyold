import '../../../../core/auth/auth_session_manager.dart';
import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/favourite_product.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/api_profile_data_sources.dart';
import '../datasources/mock_favourites_data_source.dart';
import '../datasources/profile_local_data_source.dart';
import '../models/user_profile_model.dart';

/// The signed-in user's profile.
///
/// The server owns it and [_local] is a cache, not a second source of truth.
/// The cache exists for two reasons: the account screen renders on the first
/// frame instead of flashing empty, and route guards read the user's roles
/// *synchronously* — an async read there would mean deciding whether to show
/// the admin screens before knowing whether they are allowed.
///
/// Every successful fetch writes through, so the cached copy is the last thing
/// the server actually said rather than anything the device made up.
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required ProfileLocalDataSource local,
    required FavouritesDataSource favourites,
    ApiProfileDataSource? remote,
    AuthSessionManager? session,
  }) : _local = local,
       _favourites = favourites,
       _remote = remote,
       _session = session;

  final ProfileLocalDataSource _local;
  final FavouritesDataSource _favourites;

  /// Null in the mock build, where the cache is the whole story.
  final ApiProfileDataSource? _remote;

  /// Null in the mock build; otherwise the owner of the tokens, so signing out
  /// actually ends the session rather than just hiding it.
  final AuthSessionManager? _session;

  @override
  Future<Result<UserProfile>> getProfile() => guard(() async {
    final remote = _remote;
    if (remote == null) return _local.read().toEntity();

    try {
      final fresh = await remote.read();
      await _local.write(fresh);
      return fresh.toEntity();
    } on Object {
      // Offline, or the server is having a bad minute. A cached profile is
      // still this user's profile, so showing it beats an error screen — but
      // only if we actually have one; an empty cache must surface the failure
      // rather than render a blank stranger.
      final cached = _local.read();
      if (cached.id.isEmpty) rethrow;
      return cached.toEntity();
    }
  });

  @override
  Future<Result<UserProfile>> updateProfile(UserProfile profile) =>
      guard(() async {
        final model = UserProfileModel.fromEntity(profile);
        final remote = _remote;
        if (remote == null) {
          await _local.write(model);
          return model.toEntity();
        }

        // Saved server-side first: the cache must never hold an edit the
        // server rejected, or the user sees a change that silently is not
        // there on their other device.
        final saved = await remote.update(model);
        await _local.write(saved);
        return saved.toEntity();
      });

  @override
  Future<Result<List<FavouriteProduct>>> getFavourites() =>
      guard(_favourites.getFavourites);

  @override
  Future<Result<void>> logout() => guard(() async {
    // Revoking server-side is what actually ends the session; the local
    // clean-up below only stops this device from using it. Best-effort,
    // because a user who taps sign out must end up signed out on this device
    // even if the network is down.
    try {
      await _remote?.logout();
    } on Object {
      // Ignored deliberately — see above.
    }
    await _endLocalSession(SignOutReason.userInitiated);
  });

  @override
  Future<Result<void>> deleteAccount() => guard(() async {
    // Not best-effort: if the server did not accept the deletion, the account
    // still exists, and quietly signing out would tell the user otherwise.
    await _remote?.deleteAccount();
    await _endLocalSession(SignOutReason.userInitiated);
  });

  /// Drops everything this device knows about the user.
  ///
  /// The cached profile goes too: leaving it would show the previous user's
  /// name, phone and roles to whoever signs in next on this device.
  Future<void> _endLocalSession(SignOutReason reason) async {
    await _local.clear();
    await _local.clearSession();
    await _session?.signOut(reason);
  }
}
