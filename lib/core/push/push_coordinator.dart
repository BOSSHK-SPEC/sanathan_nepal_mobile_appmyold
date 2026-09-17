import 'dart:async';

import 'package:flutter/foundation.dart';

import '../auth/auth_session_manager.dart';
import 'push_device_registrar.dart';
import 'push_payload.dart';
import 'push_service.dart';

/// Joins the three halves of push: the transport, the server registration and
/// what happens when someone taps a notification.
///
/// Owned by the composition root and started once, after the first frame.
/// Nothing else in the app knows that Firebase exists.
class PushCoordinator {
  PushCoordinator({
    required PushService service,
    required PushDeviceRegistrar registrar,
    required AuthSessionManager session,
    required void Function(String route) openRoute,
  }) : _service = service,
       _registrar = registrar,
       _session = session,
       _openRoute = openRoute;

  final PushService _service;
  final PushDeviceRegistrar _registrar;
  final AuthSessionManager _session;
  final void Function(String route) _openRoute;

  final List<StreamSubscription<Object?>> _subscriptions = [];
  bool _started = false;

  /// Starts delivery for a signed-in user.
  ///
  /// Safe to call when signed out or when push is unavailable: it simply does
  /// nothing, and can be called again after the next sign-in.
  Future<void> start() async {
    if (!_started) {
      if (!await _service.start()) return;
      _started = true;

      // A tap is handled whether it happened just now or launched the app.
      _subscriptions.add(_service.onOpened.listen(_handleTap));
      // A rotated token that never reaches the server silently stops every
      // future notification, so this is not optional bookkeeping.
      _subscriptions.add(
        _service.onTokenRefresh.listen(
          (token) => unawaited(_registrar.register(token, force: true)),
        ),
      );
      _subscriptions.add(_session.onSignOut.listen((_) => unawaited(stop())));
    }

    // Runs on every call, not only the first: this is also what a sign-in
    // calls, and the account that owns the registration has just changed.
    await registerCurrentToken();
  }

  /// Sends this device's token to the server. Call after a sign-in, too: the
  /// token belongs to the device, but the registration belongs to the account.
  Future<void> registerCurrentToken() async {
    if (!_session.hasSession) return;
    final token = await _service.token();
    if (token == null) return;
    await _registrar.register(token, force: true);
  }

  /// Stops delivery to this device and forgets the registration.
  Future<void> stop() async {
    await _service.deleteToken();
    await _registrar.forget();
  }

  void _handleTap(PushPayload payload) {
    final route = payload.route;
    if (route == null) {
      debugPrint('[push] notification tapped with no route: ${payload.kind}');
      return;
    }
    _openRoute(route);
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
  }
}
