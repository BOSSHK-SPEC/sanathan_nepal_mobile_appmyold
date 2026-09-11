import '../../../../core/utils/result.dart';
import '../entities/app_preferences.dart';

abstract interface class AppPreferencesRepository {
  Future<Result<AppPreferences>> load();
  Future<Result<void>> save(AppPreferences prefs);
}
