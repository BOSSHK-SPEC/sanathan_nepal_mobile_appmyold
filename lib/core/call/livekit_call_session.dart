import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';

import 'call_session.dart';

/// A live call, carried by LiveKit.
///
/// Permissions are requested *before* connecting, not after: joining a room
/// with no microphone produces a call where one side is inaudible and neither
/// party can tell why — while the meter runs.
class LiveKitCallSession implements CallSession {
  LiveKitCallSession();

  final StreamController<CallConnectionState> _states =
      StreamController<CallConnectionState>.broadcast();

  Room? _room;
  EventsListener<RoomEvent>? _events;
  CallConnectionState _state = CallConnectionState.idle;

  @override
  CallConnectionState get state => _state;

  @override
  Stream<CallConnectionState> get onState => _states.stream;

  @override
  Object? get mediaRoom => _room;

  @override
  Future<void> connect({
    required String url,
    required String token,
    required bool video,
  }) async {
    // A second connect on the same session must not leave the first room
    // running in the background, still publishing this phone's microphone.
    await disconnect();
    await _requestPermissions(video: video);

    _emit(CallConnectionState.connecting);
    final room = Room(
      roomOptions: const RoomOptions(
        // Adaptive stream and dynacast cut what is sent to what is actually
        // being displayed — on a mobile connection that is the difference
        // between a call and a slideshow.
        adaptiveStream: true,
        dynacast: true,
        defaultVideoPublishOptions: VideoPublishOptions(
          videoEncoding: VideoEncoding(maxBitrate: 600 * 1000, maxFramerate: 24),
        ),
      ),
    );
    _room = room;

    _events = room.createListener()
      ..on<RoomDisconnectedEvent>((_) => _emit(CallConnectionState.disconnected))
      ..on<RoomReconnectingEvent>((_) => _emit(CallConnectionState.reconnecting))
      ..on<RoomReconnectedEvent>((_) => _emit(CallConnectionState.connected));

    try {
      await room.connect(url, token);
      await room.localParticipant?.setMicrophoneEnabled(true);
      if (video) await room.localParticipant?.setCameraEnabled(true);
      // A video call belongs on the speaker; a voice call starts at the ear,
      // where someone holding the phone to their head expects it.
      //
      // "Preferred", not forced: a wired or Bluetooth headset still wins, so
      // plugging in headphones mid-call does not blast the room instead.
      await AudioManager.instance.setSpeakerOutputPreferred(video);
      _emit(CallConnectionState.connected);
    } catch (error, stack) {
      debugPrint('[call] could not connect: $error');
      debugPrintStack(stackTrace: stack);
      await disconnect();
      _emit(CallConnectionState.failed);
      throw const CallException(
        CallFailure.connection,
        'Could not connect the call. Check your connection and try again.',
      );
    }
  }

  @override
  Future<void> setMuted(bool muted) async {
    await _room?.localParticipant?.setMicrophoneEnabled(!muted);
  }

  @override
  Future<void> setCameraEnabled(bool enabled) async {
    await _room?.localParticipant?.setCameraEnabled(enabled);
  }

  @override
  Future<void> setSpeakerOn(bool speakerOn) async {
    await AudioManager.instance.setSpeakerOutputPreferred(speakerOn);
  }

  @override
  Future<void> disconnect() async {
    final room = _room;
    _room = null;
    await _events?.dispose();
    _events = null;
    if (room == null) return;
    try {
      await room.disconnect();
    } catch (error) {
      debugPrint('[call] disconnect failed: $error');
    }
    // Always dispose: a room left undisposed keeps the microphone — and on
    // some devices the camera light — on after the call screen is gone.
    await room.dispose();
    _emit(CallConnectionState.disconnected);
  }

  Future<void> _requestPermissions({required bool video}) async {
    final wanted = <Permission>[
      Permission.microphone,
      if (video) Permission.camera,
    ];
    final results = await wanted.request();
    final refused = results.entries
        .where((entry) => !entry.value.isGranted)
        .map((entry) => entry.key == Permission.camera ? 'camera' : 'microphone')
        .toList();

    if (refused.isEmpty) return;
    throw CallException(
      CallFailure.permissionDenied,
      'Allow ${refused.join(' and ')} access to join the call.',
    );
  }

  void _emit(CallConnectionState state) {
    _state = state;
    if (!_states.isClosed) _states.add(state);
  }

  Future<void> dispose() async {
    await disconnect();
    await _states.close();
  }
}
