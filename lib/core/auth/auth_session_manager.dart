import 'dart:async';

import 'package:flutter/foundation.dart';

import 'token_store.dart';

/// How a session ended, so the UI can say something useful.
enum SignOutReason {
  /// The user tapped sign out.
  userInitiated,

  /// The refresh token expired or was rejected — sign in again.
  sessionExpired,

  /// The server revoked the whole session family (a replayed refresh token).
  sessionRevoked,
}

/// Holds the tokens for the running app and coordinates refresh.
///
/// The access token is kept in memory only; the refresh token is persisted in
/// the keychain. Nothing else in the app reads either directly — the auth
/// interceptor asks this class, and everything else asks the interceptor by
/// simply making a request.
class AuthSessionManager {
  AuthSessionManager(this._store);

  final TokenStore _store;

  String? _accessToken;
  String? _refreshToken;

  final StreamController<SignOutReason> _signOutController =
      StreamController<SignOutReason>.broadcast();

  /// Emits when the session ends for any reason. The router listens and sends
  /// the user back to onboarding.
  Stream<SignOutReason> get onSignOut => _signOutController.stream;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  bool get hasSession => _refreshToken != null;

  /// Loads the persisted refresh token. Call once at startup, before runApp.
  Future<void> restore() async {
    _refreshToken = await _store.readRefreshToken();
  }

  Future<void> adopt({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await _store.writeRefreshToken(refreshToken);
  }

  /// Replaces the pair after a refresh. The refresh token rotates on every
  /// use, so the new one must be persisted or the next refresh fails.
  Future<void> rotate({
    required String accessToken,
    required String refreshToken,
  }) => adopt(accessToken: accessToken, refreshToken: refreshToken);

  Future<void> signOut(SignOutReason reason) async {
    _accessToken = null;
    _refreshToken = null;
    await _store.clear();
    if (!_signOutController.isClosed) _signOutController.add(reason);
  }

  @visibleForTesting
  void setAccessTokenForTest(String? token) => _accessToken = token;

  Future<void> dispose() => _signOutController.close();
}
