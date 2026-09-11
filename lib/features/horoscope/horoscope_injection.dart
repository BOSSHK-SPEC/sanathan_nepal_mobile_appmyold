import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import 'data/datasources/horoscope_data_source.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_horoscope_data_source.dart';
import 'data/datasources/mock_horoscope_data_source.dart';
import 'data/repositories/horoscope_repository_impl.dart';
import 'domain/repositories/horoscope_repository.dart';
import 'domain/usecases/get_all_predictions.dart';
import 'domain/usecases/get_prediction.dart';
import 'presentation/cubit/horoscope_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `horoscope`.
void registerHoroscopeFeature(GetIt sl) {
  sl
    ..registerLazySingleton<HoroscopeDataSource>(
      () => selectDataSource(
        mock: () => MockHoroscopeDataSource(resolver: sl<RegionResolver>()),
        live: () => ApiHoroscopeDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<HoroscopeRepository>(
      () => HoroscopeRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetPrediction(sl()))
    ..registerLazySingleton(() => GetAllPredictions(sl()))
    ..registerFactory(() => HoroscopeCubit(getAllPredictions: sl()));
}
