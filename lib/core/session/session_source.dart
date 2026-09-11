import 'app_session.dart';

/// Supplies the current [AppSession] to `SessionCubit`.
///
/// The contract lives in core so the session feature depends on nothing;
/// the profile feature owns the implementation and registers it in GetIt —
/// the same inversion `RegionResolver` uses.
abstract interface class SessionSource {
  /// Resolves the signed-in user into a session, or [AppSession.guest].
  Future<AppSession> load();
}
