import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_preferences.dart';
import '../repositories/app_preferences_repository.dart';

class SaveAppPreferences implements UseCase<void, AppPreferences> {
  const SaveAppPreferences(this._repo);
  final AppPreferencesRepository _repo;

  @override
  Future<Result<void>> call(AppPreferences params) => _repo.save(params);
}
