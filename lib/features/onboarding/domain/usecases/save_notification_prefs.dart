import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/notification_prefs.dart';
import '../repositories/notification_prefs_repository.dart';

/// Persists notification preferences.
class SaveNotificationPrefs implements UseCase<void, NotificationPrefs> {
  const SaveNotificationPrefs(this._repo);
  final NotificationPrefsRepository _repo;

  @override
  Future<Result<void>> call(NotificationPrefs params) => _repo.save(params);
}
