import 'dart:async';

import 'push_payload.dart';

/// Delivery of notifications to this device.
///
/// An interface so the app depends on "there is a push service" rather than on
/// Firebase: tests use [NoopPushService], and a build with no Firebase
/// configuration runs the same code paths with nothing to deliver through.
abstract interface class PushService {
  /// Initialises the transport and asks for permission if it has not been
  /// asked before.
  ///
  /// Returns false when push is unavailable — no configuration, permission
  /// refused, or a platform that does not support it. Never throws: a
  /// notification problem must not stop the app from starting.
  Future<bool> start();

  /// This device's registration token, or null when there is none.
  Future<String?> token();

  /// Fires when the transport issues a new token. The old one stops working,
  /// so the new one has to reach the server or the device goes quiet.
  Stream<String> get onTokenRefresh;

  /// Notifications the user tapped, including one that launched the app.
  Stream<PushPayload> get onOpened;

  /// Drops this device's token.
  ///
  /// Called on sign-out: the next person to use the phone must not receive
  /// the previous user's messages.
  Future<void> deleteToken();
}

/// Delivers nothing. Used in tests, and wherever push is switched off.
class NoopPushService implements PushService {
  const NoopPushService();

  @override
  Future<bool> start() async => false;

  @override
  Future<String?> token() async => null;

  @override
  Stream<String> get onTokenRefresh => const Stream<String>.empty();

  @override
  Stream<PushPayload> get onOpened => const Stream<PushPayload>.empty();

  @override
  Future<void> deleteToken() async {}
}
