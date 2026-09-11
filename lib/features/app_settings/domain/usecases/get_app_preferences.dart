import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_preferences.dart';
import '../repositories/app_preferences_repository.dart';

class GetAppPreferences implements NoParamsUseCase<AppPreferences> {
  const GetAppPreferences(this._repo);
  final AppPreferencesRepository _repo;

  @override
  Future<Result<AppPreferences>> call() => _repo.load();
}
