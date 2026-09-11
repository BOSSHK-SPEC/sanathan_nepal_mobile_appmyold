import '../../../../core/utils/result.dart';
import '../entities/notification_prefs.dart';

/// Persistence contract for onboarding notification preferences.
abstract interface class NotificationPrefsRepository {
  Future<Result<NotificationPrefs>> load();
  Future<Result<void>> save(NotificationPrefs prefs);
}
