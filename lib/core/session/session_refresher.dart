/// Asks the app to re-read the session after something changed the account.
///
/// The write-side counterpart to [SessionResolver], and the same inversion:
/// a feature that promotes someone — an approved astrologer, an approved
/// business — can make the app notice without importing `SessionCubit`.
///
/// It exists because permissions are derived from the *cached* profile. The
/// server grants a role the moment a reviewer approves; until something
/// reloads the session, the app still believes the old set, and the user is
/// shown a screen that contradicts the decision they were just told about.
abstract interface class SessionRefresher {
  Future<void> refresh();
}

/// Refreshes nothing. For tests and previews.
class NoopSessionRefresher implements SessionRefresher {
  const NoopSessionRefresher();

  @override
  Future<void> refresh() async {}
}
