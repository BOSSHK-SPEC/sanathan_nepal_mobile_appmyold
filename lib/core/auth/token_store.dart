import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the refresh token lives.
///
/// An interface so tests can substitute an in-memory store, and so the storage
/// backend can change without touching the session manager.
abstract interface class TokenStore {
  Future<String?> readRefreshToken();
  Future<void> writeRefreshToken(String token);
  Future<void> clear();
}

/// Keychain / Keystore backed storage.
///
/// A refresh token is a long-lived credential — thirty days of access to an
/// account and its wallet. `SharedPreferences` is plain text on disk and
/// readable on a rooted device or from an unencrypted backup, so it is the
/// wrong home for this even though it is where the rest of the app's
/// preferences live. The short-lived access token is deliberately *not*
/// persisted at all: it lives in memory and is re-minted on launch.
class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock,
            ),
          );

  final FlutterSecureStorage _storage;

  static const String _refreshKey = 'sanatan.auth.refresh_token';

  /// Every method swallows platform failures and degrades to "no session".
  ///
  /// The keychain can be unavailable for reasons that are not bugs: a corrupt
  /// entry after an OS upgrade, a restored backup from another device, or a
  /// unit-test binding with no plugin registered. None of those should crash
  /// the app on launch — the honest fallback is to treat the user as signed
  /// out and let them sign in again.
  @override
  Future<String?> readRefreshToken() async {
    try {
      return await _storage.read(key: _refreshKey);
    } on PlatformException {
      await clear();
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  @override
  Future<void> writeRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshKey, value: token);
    } on PlatformException {
      // The session still works for this run; it just will not survive a
      // restart. Failing the sign-in outright would be worse.
    } on MissingPluginException {
      // No secure storage on this platform (tests, some desktop targets).
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.delete(key: _refreshKey);
    } on PlatformException {
      // Nothing more we can do; the in-memory session is already gone.
    } on MissingPluginException {
      // Nothing to clear.
    }
  }
}

/// In-memory store for tests and previews.
class InMemoryTokenStore implements TokenStore {
  String? _token;

  @override
  Future<String?> readRefreshToken() async => _token;

  @override
  Future<void> writeRefreshToken(String token) async => _token = token;

  @override
  Future<void> clear() async => _token = null;
}
