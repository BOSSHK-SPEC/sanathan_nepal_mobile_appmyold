import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/notification_prefs.dart';
import '../repositories/notification_prefs_repository.dart';

/// Loads stored notification preferences (defaults when none saved).
class GetNotificationPrefs implements NoParamsUseCase<NotificationPrefs> {
  const GetNotificationPrefs(this._repo);
  final NotificationPrefsRepository _repo;

  @override
  Future<Result<NotificationPrefs>> call() => _repo.load();
}
