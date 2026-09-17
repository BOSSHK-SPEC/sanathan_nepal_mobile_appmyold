import 'dart:async';

/// Where a live call is, from the app's point of view.
enum CallConnectionState {
  idle,
  connecting,

  /// Media is flowing. Only now is there a call.
  connected,

  /// The network dropped and the stack is re-establishing. Audio is gone but
  /// the session is not over — shown, not treated as a failure.
  reconnecting,
  disconnected,
  failed,
}

/// Why a call could not start, in terms the UI can act on.
enum CallFailure {
  /// The user refused the microphone (or camera). Nothing to retry until they
  /// change it in settings.
  permissionDenied,

  /// The server, the token or the network. Retryable.
  connection,
}

class CallException implements Exception {
  const CallException(this.failure, this.message);
  final CallFailure failure;
  final String message;

  @override
  String toString() => 'CallException($failure): $message';
}

/// The media half of a consultation: microphone, camera, speaker, and the
/// connection carrying them.
///
/// An interface so the cubit can be tested without a media stack, and so a
/// build with no calls (the demo, a widget test) is a different implementation
/// rather than a pile of conditionals.
abstract interface class CallSession {
  /// Joins [url] with [token]. Asks for the microphone — and the camera when
  /// [video] — before connecting, and throws [CallException] if refused.
  Future<void> connect({
    required String url,
    required String token,
    required bool video,
  });

  Future<void> setMuted(bool muted);
  Future<void> setCameraEnabled(bool enabled);
  Future<void> setSpeakerOn(bool speakerOn);

  /// Leaves the room and releases the microphone and camera.
  Future<void> disconnect();

  Stream<CallConnectionState> get onState;
  CallConnectionState get state;

  /// The underlying room object, for the video renderer to attach to.
  ///
  /// Deliberately untyped: `core` does not depend on a media SDK, and the one
  /// widget that draws video knows what to cast it to.
  Object? get mediaRoom;
}

/// Carries nothing. Used in tests, in the demo build, and wherever calls are
/// switched off — every control works, and the state never leaves [idle].
class NoopCallSession implements CallSession {
  @override
  CallConnectionState get state => CallConnectionState.idle;

  @override
  Stream<CallConnectionState> get onState =>
      const Stream<CallConnectionState>.empty();

  @override
  Object? get mediaRoom => null;

  @override
  Future<void> connect({
    required String url,
    required String token,
    required bool video,
  }) async {}

  @override
  Future<void> setMuted(bool muted) async {}

  @override
  Future<void> setCameraEnabled(bool enabled) async {}

  @override
  Future<void> setSpeakerOn(bool speakerOn) async {}

  @override
  Future<void> disconnect() async {}
}
