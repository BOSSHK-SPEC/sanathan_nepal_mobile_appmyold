import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_notification.dart';
import '../repositories/notification_repository.dart';

/// Marks a single notification as read.
class MarkNotificationRead implements UseCase<AppNotification, String> {
  const MarkNotificationRead(this._repo);
  final NotificationRepository _repo;

  @override
  Future<Result<AppNotification>> call(String params) =>
      _repo.markAsRead(params);
}
