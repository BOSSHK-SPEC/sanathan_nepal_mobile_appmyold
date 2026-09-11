import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/notification_settings.dart';
import '../repositories/notification_repository.dart';

/// Persists notification settings.
class SaveNotificationSettings implements UseCase<void, NotificationSettings> {
  const SaveNotificationSettings(this._repo);
  final NotificationRepository _repo;

  @override
  Future<Result<void>> call(NotificationSettings params) =>
      _repo.saveSettings(params);
}
