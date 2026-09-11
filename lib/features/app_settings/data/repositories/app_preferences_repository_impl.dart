import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../datasources/app_preferences_local_data_source.dart';
import '../models/app_preferences_model.dart';

class AppPreferencesRepositoryImpl implements AppPreferencesRepository {
  AppPreferencesRepositoryImpl(this._local);
  final AppPreferencesLocalDataSource _local;

  @override
  Future<Result<AppPreferences>> load() =>
      guard(() => _local.read().toEntity());

  @override
  Future<Result<void>> save(AppPreferences prefs) =>
      guard(() => _local.write(AppPreferencesModel.fromEntity(prefs)));
}
