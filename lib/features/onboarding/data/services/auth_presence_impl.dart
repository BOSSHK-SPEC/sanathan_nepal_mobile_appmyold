import '../../../../core/auth/auth_session_manager.dart';
import '../../domain/repositories/auth_presence.dart';
import '../datasources/auth_local_data_source.dart';

/// Live: signed in while a refresh token is stored. The token is restored
/// before `runApp`, so this is already accurate when the splash asks.
class SessionAuthPresence implements AuthPresence {
  SessionAuthPresence(this._session);

  final AuthSessionManager _session;

  @override
  bool get isSignedIn => _session.hasSession;
}

/// Mock: signed in once the mock sign-in has written its session.
class LocalAuthPresence implements AuthPresence {
  LocalAuthPresence(this._local);

  final AuthLocalDataSource _local;

  @override
  bool get isSignedIn => _local.isLoggedIn;
}
