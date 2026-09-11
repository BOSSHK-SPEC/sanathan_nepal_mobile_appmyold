import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/notification_repository.dart';

/// Marks every notification as read.
class MarkAllNotificationsRead implements NoParamsUseCase<void> {
  const MarkAllNotificationsRead(this._repo);
  final NotificationRepository _repo;

  @override
  Future<Result<void>> call() => _repo.markAllAsRead();
}
