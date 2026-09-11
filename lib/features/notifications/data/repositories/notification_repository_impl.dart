import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_settings_local_data_source.dart';
import '../datasources/notifications_data_source.dart';
import '../models/notification_settings_model.dart';

/// [NotificationRepository] combining the inbox source and local settings.
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required NotificationsDataSource inbox,
    required NotificationSettingsLocalDataSource settings,
  }) : _inbox = inbox,
       _settings = settings;

  final NotificationsDataSource _inbox;
  final NotificationSettingsLocalDataSource _settings;

  @override
  Future<Result<List<AppNotification>>> getNotifications() => guard(
    () async => List<AppNotification>.unmodifiable(
      (await _inbox.fetchAll()).map((n) => n.toEntity()),
    ),
  );

  @override
  Future<Result<AppNotification>> markAsRead(String id) =>
      guard(() async => (await _inbox.markRead(id)).toEntity());

  @override
  Future<Result<void>> markAllAsRead() => guard(_inbox.markAllRead);

  @override
  Future<Result<NotificationSettings>> getSettings() =>
      guard(() => _settings.read().toEntity());

  @override
  Future<Result<void>> saveSettings(NotificationSettings settings) => guard(
    () => _settings.write(NotificationSettingsModel.fromEntity(settings)),
  );
}
