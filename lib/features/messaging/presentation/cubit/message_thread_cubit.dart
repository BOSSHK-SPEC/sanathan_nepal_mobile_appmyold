import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/business_message.dart';
import '../../domain/entities/message_thread.dart';
import '../../domain/usecases/messaging_usecases.dart';

part 'message_thread_cubit.freezed.dart';
part 'message_thread_state.dart';

/// One conversation.
///
/// Opened either on an existing thread or on a business the user has not
/// written to yet — the second case is the "Message" button on a shop, where
/// the thread is created by the first message rather than by opening a screen.
/// Opening a screen must not put an empty conversation in a shop's inbox.
class MessageThreadCubit extends AppCubit<MessageThreadState> {
  MessageThreadCubit({
    required GetMessageThread getThread,
    required GetThreadWithBusiness getThreadWithBusiness,
    required GetThreadMessages getMessages,
    required MessageBusiness messageBusiness,
    required ReplyToThread reply,
    required MarkThreadRead markRead,
    String? threadId,
    String? businessId,
  }) : _getThread = getThread,
       _getThreadWithBusiness = getThreadWithBusiness,
       _getMessages = getMessages,
       _messageBusiness = messageBusiness,
       _reply = reply,
       _markRead = markRead,
       _businessId = businessId,
       super(MessageThreadState(threadId: threadId));

  final GetMessageThread _getThread;
  final GetThreadWithBusiness _getThreadWithBusiness;
  final GetThreadMessages _getMessages;
  final MessageBusiness _messageBusiness;
  final ReplyToThread _reply;
  final MarkThreadRead _markRead;
  final String? _businessId;

  /// Slower than the live consultation chat on purpose: a shop replies in
  /// hours, not seconds, and polling this like a billed session would burn
  /// battery for nothing.
  static const Duration pollInterval = Duration(seconds: 12);

  Timer? _poller;

  Future<void> load() async {
    emit(state.copyWith(thread: state.thread.toLoading()));

    final resolved = state.threadId != null
        ? await _getThread(state.threadId!)
        : null;

    if (resolved != null) {
      emit(
        state.copyWith(
          thread: resolved.fold(state.thread.toFailed, LoadState.loaded),
        ),
      );
    } else if (_businessId != null) {
      final existing = await _getThreadWithBusiness(_businessId);
      existing.fold(
        (failure) =>
            emit(state.copyWith(thread: state.thread.toFailed(failure))),
        (thread) => emit(
          state.copyWith(
            // No thread yet is the normal first visit, not a failure: the
            // screen opens on an empty conversation with a working composer.
            thread: thread == null
                ? const LoadState<MessageThread>.idle()
                : LoadState.loaded(thread),
            threadId: thread?.id,
          ),
        ),
      );
    }

    if (state.threadId == null) {
      emit(state.copyWith(messages: const LoadState.loaded([])));
      return;
    }
    await _loadMessages();
    await _markThreadRead();
    _startPolling();
  }

  void _startPolling() {
    _poller?.cancel();
    _poller = Timer.periodic(pollInterval, (_) => _refresh());
  }

  Future<void> _refresh() async {
    if (state.threadId == null || state.isSending) return;
    await _loadMessages();
    // Reading the screen is what marks a conversation read, so a reply that
    // lands while it is open must not leave the badge stuck at one.
    if (state.hasIncomingUnread) await _markThreadRead();
  }

  Future<void> _loadMessages() async {
    final id = state.threadId;
    if (id == null) return;
    final result = await _getMessages(id);
    result.fold(
      (failure) {
        // Keep the transcript on screen: a dropped poll is not a reason to
        // replace a readable conversation with an error page.
        if (state.messages.dataOrNull == null) {
          emit(state.copyWith(messages: state.messages.toFailed(failure)));
        }
      },
      (messages) =>
          emit(state.copyWith(messages: LoadState.loaded(_merge(messages)))),
    );
  }

  /// Keeps optimistic bubbles that the server has not acknowledged yet, so a
  /// poll landing mid-send does not make a just-typed message disappear.
  List<BusinessMessage> _merge(List<BusinessMessage> fromServer) {
    final pending = [
      for (final m in state.chat)
        if (m.isPending || m.hasFailed) m,
    ];
    return [...fromServer, ...pending];
  }

  Future<void> _markThreadRead() async {
    final id = state.threadId;
    if (id == null) return;
    final result = await _markRead(id);
    result.fold(
      (_) {},
      (thread) => emit(state.copyWith(thread: LoadState.loaded(thread))),
    );
  }

  void setDraft(String draft) => emit(state.copyWith(draft: draft));

  /// Optimistic send: the bubble appears immediately with a "sending" tick and
  /// is replaced by the stored message, or marked failed and tappable to retry.
  Future<void> send({
    String subject = '',
    String contactName = '',
    String contactEmail = '',
  }) async {
    final body = state.draft.trim();
    if (body.isEmpty || state.isSending) return;

    final pending = BusinessMessage(
      id: 'pending-${DateTime.now().microsecondsSinceEpoch}',
      threadId: state.threadId ?? '',
      sender: state.mySide,
      sentAt: DateTime.now(),
      body: body,
      delivery: MessageDelivery.sending,
    );
    emit(
      state.copyWith(
        draft: '',
        sending: true,
        sendFailure: null,
        messages: LoadState.loaded([...state.chat, pending]),
      ),
    );

    final failure = state.threadId == null
        ? await _sendFirst(
            body,
            subject: subject,
            contactName: contactName,
            contactEmail: contactEmail,
          )
        : await _sendReply(body);

    if (failure != null) {
      emit(
        state.copyWith(
          sending: false,
          sendFailure: failure,
          // The text goes back in the composer so a rejected message is not
          // lost; the failed bubble stays so the reason is visible next to it.
          draft: state.draft.isEmpty ? body : state.draft,
          messages: LoadState.loaded([
            for (final m in state.chat)
              if (m.id == pending.id)
                m.copyWith(delivery: MessageDelivery.failed)
              else
                m,
          ]),
        ),
      );
      return;
    }

    emit(state.copyWith(sending: false, sendFailure: null));
    await _loadMessages();
    _startPolling();
  }

  Future<Failure?> _sendFirst(
    String body, {
    required String subject,
    required String contactName,
    required String contactEmail,
  }) async {
    final result = await _messageBusiness(
      MessageBusinessParams(
        businessId: _businessId ?? '',
        body: body,
        subject: subject,
        contactName: contactName,
        contactEmail: contactEmail,
      ),
    );
    return result.fold((failure) => failure, (thread) {
      emit(
        state.copyWith(
          thread: LoadState.loaded(thread),
          threadId: thread.id,
          // Drop the optimistic bubble: the reload below brings back the
          // stored message, and keeping both would show it twice.
          messages: LoadState.loaded([
            for (final m in state.chat)
              if (!m.isPending) m,
          ]),
        ),
      );
      return null;
    });
  }

  Future<Failure?> _sendReply(String body) async {
    final result = await _reply(
      ReplyParams(threadId: state.threadId!, body: body),
    );
    return result.fold((failure) => failure, (sent) {
      emit(
        state.copyWith(
          messages: LoadState.loaded([
            for (final m in state.chat)
              if (m.isPending) sent else m,
          ]),
        ),
      );
      return null;
    });
  }

  /// Re-sends a bubble that failed, from the composer's retry affordance.
  Future<void> retry() async {
    final failed = [
      for (final m in state.chat)
        if (m.hasFailed) m,
    ];
    if (failed.isEmpty) return;
    emit(
      state.copyWith(
        draft: failed.last.body,
        messages: LoadState.loaded([
          for (final m in state.chat)
            if (!m.hasFailed) m,
        ]),
      ),
    );
    await send();
  }

  @override
  Future<void> close() {
    _poller?.cancel();
    return super.close();
  }
}
