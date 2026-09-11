import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../../core/utils/localized_text.dart';
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
  }) : _id = consultationId,
       _get = getConsultation,
       _getMessages = getMessages,
       _send = send,
       _end = endConsultation,
       _saveNotes = saveNotes,
       super(const AstrologerSessionState());

  final String _id;
  final GetConsultation _get;
  final GetMessages _getMessages;
  final SendAsAstrologer _send;
  final EndConsultation _end;
  final SaveSessionNotes _saveNotes;

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
    _start();
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
      (failure) => emit(state.copyWith(messages: state.messages.toFailed(failure))),
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

  // --- Call controls (local UI state; no media stack yet) ---------------

  void toggleMute() => emit(state.copyWith(muted: !state.muted));

  void toggleSpeaker() => emit(state.copyWith(speakerOn: !state.speakerOn));

  void toggleCamera() => emit(state.copyWith(cameraOn: !state.cameraOn));

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
  Future<void> close() {
    _stop();
    return super.close();
  }
}
