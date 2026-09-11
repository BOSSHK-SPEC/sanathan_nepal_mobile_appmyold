import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/usecases/consultation_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'live_session_cubit.freezed.dart';
part 'live_session_state.dart';

/// Drives a live consultation from the queue through to the end.
///
/// One cubit serves the queue, chat and call screens because they are three
/// views of the same session — splitting them would mean three clocks that
/// could disagree about when billing started.
///
/// Two timers, deliberately: a fast one that only re-renders the meter, and
/// a slower one that talks to the data source. Polling once a second would
/// be wasteful; ticking the meter once every few seconds would look broken.
class LiveSessionCubit extends AppCubit<LiveSessionState> {
  LiveSessionCubit({
    required String consultationId,
    required GetConsultation getConsultation,
    required RefreshConsultation refreshConsultation,
    required GetMessages getMessages,
    required SendMessage sendMessage,
    required EndConsultation endConsultation,
    required CancelConsultation cancelConsultation,
    required GetSpendableBalance getBalance,
  }) : _id = consultationId,
       _get = getConsultation,
       _refresh = refreshConsultation,
       _getMessages = getMessages,
       _send = sendMessage,
       _end = endConsultation,
       _cancel = cancelConsultation,
       _getBalance = getBalance,
       super(const LiveSessionState());

  final String _id;
  final GetConsultation _get;
  final RefreshConsultation _refresh;
  final GetMessages _getMessages;
  final SendMessage _send;
  final EndConsultation _end;
  final CancelConsultation _cancel;
  final GetSpendableBalance _getBalance;

  static const Duration tickInterval = Duration(seconds: 1);
  static const Duration pollInterval = Duration(seconds: 3);

  /// Warn once the remaining balance buys fewer than this many minutes.
  static const int lowBalanceMinutes = 2;

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
    await _loadBalance();
    await _pollOnce();
    _start();
  }

  void _start() {
    _ticker?.cancel();
    _poller?.cancel();
    // The meter is derived from timestamps, so the tick only needs to force
    // a rebuild — it carries no state of its own.
    _ticker = Timer.periodic(tickInterval, (_) {
      if (isClosed) return;
      if (state.consultation?.status == ConsultationStatus.active) {
        emit(state.copyWith(tick: state.tick + 1));
      }
    });
    _poller = Timer.periodic(pollInterval, (_) => _pollOnce());
  }

  void _stop() {
    _ticker?.cancel();
    _poller?.cancel();
    _ticker = null;
    _poller = null;
  }

  Future<void> _pollOnce() async {
    if (isClosed) return;
    final result = await _refresh(_id);
    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(state.copyWith(session: state.session.toFailed(failure))),
      (session) => emit(state.copyWith(session: LoadState.loaded(session))),
    );

    if (state.consultation?.status.isOver ?? false) {
      _stop();
      return;
    }
    if (state.consultation?.status == ConsultationStatus.active) {
      await _loadMessages();
    }
  }

  Future<void> _loadMessages() async {
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

  Future<void> _loadBalance() async {
    final result = await _getBalance();
    if (isClosed) return;
    emit(state.copyWith(balance: result.valueOrNull ?? state.balance));
  }

  /// Retries the message fetch after a failure, without waiting for the next
  /// poll — the poller would recover on its own, but a person looking at an
  /// error expects the button to do something now.
  Future<void> refreshNow() => _loadMessages();

  void setDraft(String draft) => emit(state.copyWith(draft: draft));

  /// Optimistic send: the bubble appears immediately with a "sending" tick
  /// and is replaced by the stored message, or marked failed.
  Future<void> send() async {
    final text = state.draft.trim();
    if (text.isEmpty || !state.canSend) return;

    final pending = ChatMessage(
      id: 'pending-${DateTime.now().microsecondsSinceEpoch}',
      consultationId: _id,
      sender: ChatSender.seeker,
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

  // --- Call controls (local UI state; no media stack yet) ---------------

  void toggleMute() => emit(state.copyWith(muted: !state.muted));

  void toggleSpeaker() => emit(state.copyWith(speakerOn: !state.speakerOn));

  void toggleCamera() => emit(state.copyWith(cameraOn: !state.cameraOn));

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

  Future<Consultation?> cancel() async {
    final result = await _cancel(_id);
    return result.fold((_) => null, (session) {
      _stop();
      emit(state.copyWith(session: LoadState.loaded(session)));
      return session;
    });
  }

  @override
  Future<void> close() {
    _stop();
    return super.close();
  }
}
