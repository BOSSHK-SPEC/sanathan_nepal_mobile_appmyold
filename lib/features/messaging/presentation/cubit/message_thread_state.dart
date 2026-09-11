part of 'message_thread_cubit.dart';

@freezed
abstract class MessageThreadState with _$MessageThreadState {
  const MessageThreadState._();

  const factory MessageThreadState({
    /// Null until the first message creates the conversation.
    String? threadId,
    @Default(LoadState<MessageThread>.idle()) LoadState<MessageThread> thread,
    @Default(LoadState<List<BusinessMessage>>.idle())
    LoadState<List<BusinessMessage>> messages,
    @Default('') String draft,
    @Default(false) bool sending,
    Failure? sendFailure,
  }) = _MessageThreadState;

  List<BusinessMessage> get chat => messages.dataOrNull ?? const [];

  bool get isSending => sending;

  /// Which side the viewer writes as. Defaults to the customer, which is what
  /// a shop page's "Message" button opens before any thread exists.
  MessageSide get mySide => thread.dataOrNull?.side ?? MessageSide.customer;

  bool get canSend => draft.trim().isNotEmpty && !sending;

  /// A message from the other side that has arrived but not been stamped read.
  bool get hasIncomingUnread => (thread.dataOrNull?.unreadCount ?? 0) > 0;

  /// Nothing has been said yet, so the screen shows a prompt rather than an
  /// empty scroll view.
  bool get isEmpty => chat.isEmpty && !messages.isLoading;
}
