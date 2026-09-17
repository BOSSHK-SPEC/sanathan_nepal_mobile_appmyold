import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/call/call_session.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/utils/localized_text.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/astrologer_session.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/entities/session_summary.dart';
import '../../domain/usecases/consultation_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'astrologer_session_cubit.freezed.dart';
part 'astrologer_session_state.dart';

/// The astrologer's side of a live session.
///
/// Reads and writes the same [Consultation] as the seeker's cubit, so the
/// elapsed time on both screens is derived from one `startedAt` and can
/// never disagree about what is being charged.
class AstrologerSessionCubit extends AppCubit<AstrologerSessionState> {
  AstrologerSessionCubit({
    required String consultationId,
    required GetConsultation getConsultation,
    required GetMessages getMessages,
    required SendAsAstrologer send,
    required EndConsultation endConsultation,
    required SaveSessionNotes saveNotes,
    required GetCallCredentials getCallCredentials,
    required CallSession callSession,
  }) : _id = consultationId,
       _get = getConsultation,
       _getMessages = getMessages,
       _send = send,
       _end = endConsultation,
       _saveNotes = saveNotes,
       _getCallCredentials = getCallCredentials,
       _call = callSession,
       super(const AstrologerSessionState()) {
    _callStates = _call.onState.listen((connection) {
      if (!isClosed) emit(state.copyWith(callState: connection));
    });
  }

  final String _id;
  final GetConsultation _get;
  final GetMessages _getMessages;
  final SendAsAstrologer _send;
  final EndConsultation _end;
  final SaveSessionNotes _saveNotes;
  final GetCallCredentials _getCallCredentials;
  final CallSession _call;

  StreamSubscription<CallConnectionState>? _callStates;
  bool _joining = false;

  static const Duration tickInterval = Duration(seconds: 1);
  static const Duration pollInterval = Duration(seconds: 3);

  Timer? _ticker;
  Timer? _poller;

  Future<void> load() async {
    emit(state.copyWith(session: state.session.toLoading()));
    final result = await _get(_id);
    emit(
      state.copyWith(
        session: result.fold(state.session.toFailed, LoadState.loaded),
      ),
    );
    await _refreshMessages();
    await _joinCallIfNeeded();
    _start();
  }

  // --- The call itself ---------------------------------------------------

  /// Joins the same room as the seeker, from the other side.
  ///
  /// The astrologer arrives here having just accepted, so the session is
  /// already live and the meter already running: a screen that showed controls
  /// without carrying audio would be charging their client for silence.
  Future<void> _joinCallIfNeeded() async {
    final session = state.consultation;
    if (session == null || session.channel == ConsultChannel.chat) return;
    if (_joining || state.isCallLive) return;

    _joining = true;
    emit(
      state.copyWith(
        callState: CallConnectionState.connecting,
        callError: null,
      ),
    );

    final result = await _getCallCredentials(_id);
    if (isClosed) {
      _joining = false;
      return;
    }

    await result.fold(
      (failure) async => emit(
        state.copyWith(
          callState: CallConnectionState.failed,
          callError: failure.message,
        ),
      ),
      (credentials) async {
        try {
          await _call.connect(
            url: credentials.url,
            token: credentials.token,
            video: session.channel == ConsultChannel.video,
          );
          if (isClosed) return;
          await _call.setMuted(state.muted);
          if (session.channel == ConsultChannel.video) {
            await _call.setCameraEnabled(state.cameraOn);
          }
        } on CallException catch (error) {
          if (!isClosed) {
            emit(
              state.copyWith(
                callState: CallConnectionState.failed,
                callError: error.message,
              ),
            );
          }
        }
      },
    );
    _joining = false;
  }

  /// The live media room, for the video view to attach renderers to.
  Object? get mediaRoom => _call.mediaRoom;

  /// Retries a join that failed — a permission granted after the fact, or a
  /// network that came back.
  Future<void> retryCall() async {
    if (state.isCallLive) return;
    await _joinCallIfNeeded();
  }

  Future<void> _leaveCall() async {
    _joining = false;
    await _call.disconnect();
  }

  void _start() {
    _ticker?.cancel();
    _poller?.cancel();
    _ticker = Timer.periodic(tickInterval, (_) {
      if (isClosed || !state.isActive) return;
      emit(state.copyWith(tick: state.tick + 1));
    });
    _poller = Timer.periodic(pollInterval, (_) => _refreshMessages());
  }

  void _stop() {
    _ticker?.cancel();
    _poller?.cancel();
    _ticker = null;
    _poller = null;
  }

  Future<void> _refreshMessages() async {
    if (isClosed) return;
    final result = await _getMessages(_id);
    if (isClosed) return;
    result.fold(
      // Previously swallowed. A failed fetch then left the list empty and the
      // screen spinning with nothing to explain it — the worst of both, since
      // the poller would have recovered on its own had anyone been told.
      // `toFailed` keeps whatever was already on screen.
      (failure) =>
          emit(state.copyWith(messages: state.messages.toFailed(failure))),
      (messages) => emit(state.copyWith(messages: LoadState.loaded(messages))),
    );
  }

  /// Retries the message fetch after a failure, without waiting for the next
  /// poll — the poller would recover on its own, but a person looking at an
  /// error expects the button to do something now.
  Future<void> refreshNow() => _refreshMessages();

  void setDraft(String draft) => emit(state.copyWith(draft: draft));

  Future<void> send() async {
    final text = state.draft.trim();
    if (text.isEmpty || !state.isActive) return;

    final pending = ChatMessage(
      id: 'pending-${DateTime.now().microsecondsSinceEpoch}',
      consultationId: _id,
      sender: ChatSender.astrologer,
      text: text,
      status: MessageStatus.sending,
      sentAt: DateTime.now(),
    );
    emit(
      state.copyWith(
        draft: '',
        messages: LoadState.loaded([...state.chat, pending]),
      ),
    );

    final result = await _send(
      SendMessageParams(consultationId: _id, text: text),
    );
    if (isClosed) return;
    result.fold(
      (_) => emit(
        state.copyWith(
          messages: LoadState.loaded([
            for (final m in state.chat)
              if (m.id == pending.id)
                m.copyWith(status: MessageStatus.failed)
              else
                m,
          ]),
        ),
      ),
      (sent) => emit(
        state.copyWith(
          messages: LoadState.loaded([
            for (final m in state.chat)
              if (m.id == pending.id) sent else m,
          ]),
        ),
      ),
    );
  }

  Future<Consultation?> end() async {
    emit(state.copyWith(ending: state.ending.toLoading()));
    final result = await _end(_id);
    return result.fold(
      (failure) {
        emit(state.copyWith(ending: state.ending.toFailed(failure)));
        return null;
      },
      (session) {
        _stop();
        unawaited(_leaveCall());
        emit(
          state.copyWith(
            ending: LoadState.loaded(session),
            session: LoadState.loaded(session),
          ),
        );
        return session;
      },
    );
  }

  // --- Call controls -----------------------------------------------------
  //
  // State first so the button responds at once, then the media stack.

  Future<void> toggleMute() async {
    final muted = !state.muted;
    emit(state.copyWith(muted: muted));
    await _call.setMuted(muted);
  }

  Future<void> toggleSpeaker() async {
    final speakerOn = !state.speakerOn;
    emit(state.copyWith(speakerOn: speakerOn));
    await _call.setSpeakerOn(speakerOn);
  }

  Future<void> toggleCamera() async {
    final cameraOn = !state.cameraOn;
    emit(state.copyWith(cameraOn: cameraOn));
    await _call.setCameraEnabled(cameraOn);
  }

  // --- Write-up ---------------------------------------------------------

  void setNotes(String notes) => emit(state.copyWith(notes: notes));

  void addRemedy(RemedyKind kind, String title, String description) => emit(
    state.copyWith(
      remedies: [
        ...state.remedies,
        Remedy(
          kind: kind,
          title: LocalizedText.same(title.trim()),
          description: LocalizedText.same(description.trim()),
        ),
      ],
    ),
  );

  void removeRemedy(int index) => emit(
    state.copyWith(
      remedies: [
        for (var i = 0; i < state.remedies.length; i++)
          if (i != index) state.remedies[i],
      ],
    ),
  );

  Future<bool> saveNotes() async {
    emit(state.copyWith(savingNotes: state.savingNotes.toLoading()));
    final result = await _saveNotes(
      SessionNotesDraft(
        consultationId: _id,
        notes: state.notes,
        remedies: state.remedies,
      ),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(savingNotes: state.savingNotes.toFailed(failure)));
        return false;
      },
      (summary) {
        emit(state.copyWith(savingNotes: LoadState.loaded(summary)));
        return true;
      },
    );
  }

  @override
  Future<void> close() async {
    _stop();
    await _callStates?.cancel();
    // The astrologer's microphone must stop with the screen, not whenever the
    // process happens to be collected.
    await _leaveCall();
    return super.close();
  }
}
