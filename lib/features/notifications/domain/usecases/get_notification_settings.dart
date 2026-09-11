import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/notification_settings.dart';
import '../repositories/notification_repository.dart';

/// Reads the persisted notification settings (defaults when none saved).
class GetNotificationSettings implements NoParamsUseCase<NotificationSettings> {
  const GetNotificationSettings(this._repo);
  final NotificationRepository _repo;

  @override
  Future<Result<NotificationSettings>> call() => _repo.getSettings();
}
