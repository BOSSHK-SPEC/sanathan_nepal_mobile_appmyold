import '../../../../core/utils/result.dart';
import '../entities/app_notification.dart';
import '../entities/notification_settings.dart';

/// Contract for the notification inbox and the user's notification settings.
abstract interface class NotificationRepository {
  /// Newest first.
  Future<Result<List<AppNotification>>> getNotifications();
  Future<Result<AppNotification>> markAsRead(String id);
  Future<Result<void>> markAllAsRead();
  Future<Result<NotificationSettings>> getSettings();
  Future<Result<void>> saveSettings(NotificationSettings settings);
}
