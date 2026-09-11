import '../models/app_notification_model.dart';

/// I/O contract for the notification inbox.
abstract interface class NotificationsDataSource {
  Future<List<AppNotificationModel>> fetchAll();
  Future<AppNotificationModel> markRead(String id);
  Future<void> markAllRead();
}
