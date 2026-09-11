import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_all_notifications_read.dart';
import '../../domain/usecases/mark_notification_read.dart';
import '../../../../core/state/app_cubit.dart';

part 'notifications_cubit.freezed.dart';
part 'notifications_state.dart';

/// Loads the inbox and marks notifications as read.
class NotificationsCubit extends AppCubit<NotificationsState> {
  NotificationsCubit({
    required GetNotifications getNotifications,
    required MarkNotificationRead markRead,
    required MarkAllNotificationsRead markAllRead,
  }) : _get = getNotifications,
       _markRead = markRead,
       _markAllRead = markAllRead,
       super(const NotificationsState());

  final GetNotifications _get;
  final MarkNotificationRead _markRead;
  final MarkAllNotificationsRead _markAllRead;

  Future<void> load() async {
    emit(state.copyWith(notifications: state.notifications.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        notifications: result.fold(
          state.notifications.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  Future<void> markRead(String id) async {
    final result = await _markRead(id);
    emit(
      state.copyWith(
        notifications: result.fold(
          state.notifications.toFailed,
          (updated) => LoadState.loaded(
            state.items.map((n) => n.id == id ? updated : n).toList(),
          ),
        ),
      ),
    );
  }

  Future<void> markAllRead() async {
    final result = await _markAllRead();
    emit(
      state.copyWith(
        notifications: result.fold(
          state.notifications.toFailed,
          (_) => LoadState.loaded(
            state.items.map((n) => n.copyWith(isRead: true)).toList(),
          ),
        ),
      ),
    );
  }
}
