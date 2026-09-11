import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/app_preferences_local_data_source.dart';
import 'data/repositories/app_preferences_repository_impl.dart';
import 'data/services/app_settings_region_resolver.dart';
import 'domain/repositories/app_preferences_repository.dart';
import 'domain/usecases/get_app_preferences.dart';
import 'domain/usecases/save_app_preferences.dart';
import 'presentation/cubit/app_settings_cubit.dart';

void registerAppSettingsFeature(GetIt sl) {
  sl
    ..registerLazySingleton<AppPreferencesLocalDataSource>(
      () => AppPreferencesLocalDataSourceImpl(sl<KeyValueStore>()),
    )
    ..registerLazySingleton<AppPreferencesRepository>(
      () => AppPreferencesRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetAppPreferences(sl()))
    ..registerLazySingleton(() => SaveAppPreferences(sl()))
    ..registerLazySingleton(
      () => AppSettingsCubit(getPreferences: sl(), savePreferences: sl()),
    )
    ..registerLazySingleton<RegionResolver>(
      () => AppSettingsRegionResolver(sl<AppSettingsCubit>()),
    );
}
