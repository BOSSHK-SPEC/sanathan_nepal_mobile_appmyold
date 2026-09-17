import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/call/call_session.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/localized_text.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/call_credentials.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/chat_message.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/consultation.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/repositories/consultation_repository.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/usecases/consultation_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/presentation/cubit/live_session_cubit.dart';

class _MockRepository extends Mock implements ConsultationRepository {}

/// Records what the media stack was asked to do, and can refuse to connect.
class _FakeCallSession implements CallSession {
  _FakeCallSession({this.throwOnConnect});

  final CallException? throwOnConnect;
  final List<String> calls = [];
  final _states = StreamController<CallConnectionState>.broadcast();

  String? connectedUrl;
  String? connectedToken;
  bool? connectedWithVideo;
  bool? lastMuted;
  bool? lastCamera;
  bool? lastSpeaker;
  CallConnectionState _state = CallConnectionState.idle;

  @override
  CallConnectionState get state => _state;

  @override
  Stream<CallConnectionState> get onState => _states.stream;

  @override
  Object? get mediaRoom => null;

  @override
  Future<void> connect({
    required String url,
    required String token,
    required bool video,
  }) async {
    calls.add('connect');
    final failure = throwOnConnect;
    if (failure != null) throw failure;
    connectedUrl = url;
    connectedToken = token;
    connectedWithVideo = video;
    _state = CallConnectionState.connected;
    _states.add(_state);
  }

  @override
  Future<void> setMuted(bool muted) async {
    calls.add('setMuted:$muted');
    lastMuted = muted;
  }

  @override
  Future<void> setCameraEnabled(bool enabled) async {
    calls.add('setCamera:$enabled');
    lastCamera = enabled;
  }

  @override
  Future<void> setSpeakerOn(bool speakerOn) async {
    calls.add('setSpeaker:$speakerOn');
    lastSpeaker = speakerOn;
  }

  @override
  Future<void> disconnect() async {
    calls.add('disconnect');
    _state = CallConnectionState.disconnected;
  }

  Future<void> dispose() => _states.close();
}

Consultation session({
  required ConsultChannel channel,
  ConsultationStatus status = ConsultationStatus.active,
}) => Consultation(
  id: 'c1',
  astrologerId: 'a1',
  astrologerName: LocalizedText.same('Guru Sharma'),
  channel: channel,
  status: status,
  ratePerMinute: 25,
  createdAt: DateTime(2026, 9, 13),
  startedAt: status == ConsultationStatus.active ? DateTime(2026, 9, 13) : null,
);

const credentials = CallCredentials(
  url: 'wss://calls.example.com',
  token: 'join-token',
  room: 'consult-c1',
  identity: 'u1',
);

void main() {
  late _MockRepository repo;
  late _FakeCallSession call;

  LiveSessionCubit cubitFor(
    Consultation consultation, {
    _FakeCallSession? callSession,
    Result<CallCredentials> credentialsResult = const Result.success(
      credentials,
    ),
  }) {
    call = callSession ?? _FakeCallSession();
    when(() => repo.get(any())).thenAnswer((_) async => Result.success(consultation));
    when(() => repo.refresh(any())).thenAnswer((_) async => Result.success(consultation));
    when(() => repo.messages(any())).thenAnswer(
      (_) async => const Result<List<ChatMessage>>.success(<ChatMessage>[]),
    );
    when(repo.spendableBalance).thenAnswer((_) async => const Result.success(5000.0));
    when(() => repo.callCredentials(any())).thenAnswer((_) async => credentialsResult);

    return LiveSessionCubit(
      consultationId: 'c1',
      getConsultation: GetConsultation(repo),
      refreshConsultation: RefreshConsultation(repo),
      getMessages: GetMessages(repo),
      sendMessage: SendMessage(repo),
      endConsultation: EndConsultation(repo),
      cancelConsultation: CancelConsultation(repo),
      getBalance: GetSpendableBalance(repo),
      getCallCredentials: GetCallCredentials(repo),
      callSession: call,
    );
  }

  setUp(() => repo = _MockRepository());
  tearDown(() => call.dispose());

  test('joins the room once the session is live', () async {
    final cubit = cubitFor(session(channel: ConsultChannel.video));

    await cubit.load();

    expect(call.connectedUrl, 'wss://calls.example.com');
    expect(call.connectedToken, 'join-token');
    // A video session publishes video; the token the server issues enforces
    // the same thing, so the two can never disagree.
    expect(call.connectedWithVideo, isTrue);
    expect(cubit.state.isCallLive, isTrue);
    await cubit.close();
  });

  test('a voice session joins without video', () async {
    final cubit = cubitFor(session(channel: ConsultChannel.voice));

    await cubit.load();

    expect(call.connectedWithVideo, isFalse);
    await cubit.close();
  });

  test('a chat session never opens a microphone', () async {
    final cubit = cubitFor(session(channel: ConsultChannel.chat));

    await cubit.load();

    expect(call.calls, isNot(contains('connect')));
    expect(cubit.state.callState, CallConnectionState.idle);
    await cubit.close();
  });

  test('does not join before the astrologer accepts', () async {
    final cubit = cubitFor(
      session(channel: ConsultChannel.video, status: ConsultationStatus.queued),
    );

    await cubit.load();

    // There is no room until the session is active — and nobody is being
    // charged yet either.
    expect(call.calls, isNot(contains('connect')));
    await cubit.close();
  });

  test('joins once, even across several polls', () async {
    final cubit = cubitFor(session(channel: ConsultChannel.voice));

    await cubit.load();
    await cubit.load();

    expect(call.calls.where((c) => c == 'connect'), hasLength(1));
    await cubit.close();
  });

  test('a refused microphone is explained, not retried silently', () async {
    final cubit = cubitFor(
      session(channel: ConsultChannel.voice),
      callSession: _FakeCallSession(
        throwOnConnect: const CallException(
          CallFailure.permissionDenied,
          'Allow microphone access to join the call.',
        ),
      ),
    );

    await cubit.load();

    expect(cubit.state.hasCallFailed, isTrue);
    expect(cubit.state.callError, contains('microphone'));
    await cubit.close();
  });

  test('a server that cannot issue a token says why', () async {
    final cubit = cubitFor(
      session(channel: ConsultChannel.voice),
      credentialsResult: const Result<CallCredentials>.failure(
        ValidationFailure('Voice and video calls are not available yet.'),
      ),
    );

    await cubit.load();

    expect(cubit.state.hasCallFailed, isTrue);
    expect(cubit.state.callError, 'Voice and video calls are not available yet.');
    // Nothing was dialled, so nothing has to be torn down.
    expect(call.calls, isNot(contains('connect')));
    await cubit.close();
  });

  test('the controls drive the media stack, not just the icons', () async {
    final cubit = cubitFor(session(channel: ConsultChannel.video));
    await cubit.load();

    await cubit.toggleMute();
    await cubit.toggleCamera();
    await cubit.toggleSpeaker();

    expect(call.lastMuted, isTrue);
    expect(call.lastCamera, isFalse);
    expect(call.lastSpeaker, isFalse);
    expect(cubit.state.muted, isTrue);
    await cubit.close();
  });

  test('leaving the screen releases the microphone', () async {
    final cubit = cubitFor(session(channel: ConsultChannel.video));
    await cubit.load();

    await cubit.close();

    // A call screen that is gone but still publishing is both a privacy
    // problem and a bill nobody is watching.
    expect(call.calls, contains('disconnect'));
  });

  test('ending the session leaves the room', () async {
    final consultation = session(channel: ConsultChannel.voice);
    final cubit = cubitFor(consultation);
    when(() => repo.end(any())).thenAnswer(
      (_) async => Result.success(
        consultation.copyWith(status: ConsultationStatus.completed),
      ),
    );
    await cubit.load();

    await cubit.end();

    expect(call.calls, contains('disconnect'));
    await cubit.close();
  });
}
