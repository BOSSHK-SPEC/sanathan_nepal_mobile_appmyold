import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_notification.dart';
import '../repositories/notification_repository.dart';

/// Loads the notification inbox (newest first).
class GetNotifications implements NoParamsUseCase<List<AppNotification>> {
  const GetNotifications(this._repo);
  final NotificationRepository _repo;

  @override
  Future<Result<List<AppNotification>>> call() => _repo.getNotifications();
}
