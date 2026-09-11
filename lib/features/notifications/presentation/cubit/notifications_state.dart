part of 'notifications_cubit.dart';

/// State of the notification inbox list.
@freezed
abstract class NotificationsState with _$NotificationsState {
  const NotificationsState._();

  const factory NotificationsState({
    @Default(LoadState.idle()) LoadState<List<AppNotification>> notifications,
  }) = _NotificationsState;

  /// Loaded (or stale) inbox items; empty while nothing has been loaded.
  List<AppNotification> get items => notifications.dataOrNull ?? const [];

  int get unreadCount => items.where((n) => !n.isRead).length;
}
