/// Re-reads who the signed-in user is from the server.
///
/// The session is built from a cached profile so the first frame is instant,
/// and permissions are derived from that cache. A cache is only as true as its
/// last refresh, though: an approval granted, a role withdrawn, or a different
/// account signing in on the same phone all change the answer. This is the one
/// way features ask for the server's answer instead of trusting the cache.
///
/// Implemented by the profile feature (which owns the cache) and consumed
/// through core, the same inversion as [SessionRefresher].
abstract interface class SessionSync {
  /// Fetches the account from the server and reloads the session.
  ///
  /// Never throws. Offline, the cached account — still this user's — stays.
  Future<void> syncFromServer();

  /// Called right after a sign-in. If the cached profile belongs to someone
  /// else, it is dropped *before* anything reads it, then the new account is
  /// fetched.
  Future<void> adoptSignedInUser(String userId);
}

/// Syncs nothing. For tests and previews.
class NoopSessionSync implements SessionSync {
  const NoopSessionSync();

  @override
  Future<void> syncFromServer() async {}

  @override
  Future<void> adoptSignedInUser(String userId) async {}
}
