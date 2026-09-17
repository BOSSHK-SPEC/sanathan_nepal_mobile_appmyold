import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../storage/key_value_store.dart';

/// Tells the server which device to notify.
///
/// The server keys a device on `(user, token)`, so registering the same token
/// twice is harmless — but it is still a request, and the token rarely
/// changes, so the last one sent is remembered and a repeat is skipped. What is
/// *not* skipped is a change of language: the server picks the notification's
/// language from the device row, and a phone switched to Nepali that never
/// re-registered would keep being notified in English.
class PushDeviceRegistrar {
  PushDeviceRegistrar({
    required ApiClient client,
    required KeyValueStore store,
    required String Function() languageCode,
    String? appVersion,
    String? platformName,
  }) : _client = client,
       _store = store,
       _languageCode = languageCode,
       _appVersion = appVersion,
       _platformName = platformName;

  final ApiClient _client;
  final KeyValueStore _store;
  final String Function() _languageCode;
  final String? _appVersion;
  final String? _platformName;

  /// What was last accepted by the server, as `token|locale`.
  static const String storageKey = 'push.registeredDevice';

  /// Registers [token] unless the identical registration was already accepted.
  ///
  /// Returns true when the server has this device's current token and
  /// language. Never throws: failing to register costs notifications, not the
  /// sign-in that triggered it — and the next launch tries again.
  Future<bool> register(String token, {bool force = false}) async {
    if (token.isEmpty) return false;
    final fingerprint = '$token|${_languageCode()}';
    if (!force && _store.getString(storageKey) == fingerprint) return true;

    try {
      await _client.post<dynamic>(
        ApiEndpoints.authDevices,
        data: {
          'platform': _platform,
          'pushToken': token,
          'locale': _locale,
          if (_appVersion != null) 'appVersion': _appVersion,
        },
      );
      await _store.setString(storageKey, fingerprint);
      return true;
    } catch (error) {
      debugPrint('[push] could not register this device: $error');
      return false;
    }
  }

  /// Forgets the local record of what was registered.
  ///
  /// Called on sign-out, together with dropping the token itself: the next
  /// person to sign in on this phone gets a fresh token, and must not inherit
  /// a "already registered" marker that would stop it being sent.
  Future<void> forget() => _store.remove(storageKey);

  String get _platform {
    final name = _platformName;
    if (name != null) return name;
    if (kIsWeb) return 'web';
    return Platform.isIOS ? 'ios' : 'android';
  }

  /// The server accepts `en`, `ne` or `hi` only; anything else is English.
  String get _locale {
    final code = _languageCode();
    return const {'en', 'ne', 'hi'}.contains(code) ? code : 'en';
  }
}
