part of 'message_threads_cubit.dart';

@freezed
abstract class MessageThreadsState with _$MessageThreadsState {
  const MessageThreadsState._();

  const factory MessageThreadsState({
    @Default(LoadState<List<MessageThread>>.idle())
    LoadState<List<MessageThread>> threads,
    @Default(false) bool showArchived,
  }) = _MessageThreadsState;

  List<MessageThread> get items => threads.dataOrNull ?? const [];

  /// Conversations about a shop the user runs, so the inbox can group them.
  List<MessageThread> get selling => [
    for (final t in items)
      if (t.isOwnerSide) t,
  ];

  List<MessageThread> get buying => [
    for (final t in items)
      if (!t.isOwnerSide) t,
  ];

  int get unread {
    var total = 0;
    for (final t in items) {
      total += t.unreadCount;
    }
    return total;
  }
}
