import 'package:get_it/get_it.dart';

import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_resolver.dart';
import '../../core/storage/bounded_json_cache.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/api_panchanga_data_source.dart';
import 'data/datasources/mock_panchanga_data_source.dart';
import 'data/datasources/panchanga_data_source.dart';
import 'data/repositories/panchanga_repository_impl.dart';
import 'domain/repositories/panchanga_repository.dart';
import 'domain/usecases/get_panchanga.dart';
import 'domain/usecases/get_suva_saits.dart';
import 'presentation/cubit/panchanga_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `panchanga`.
void registerPanchangaFeature(GetIt sl) {
  sl
    // The on-device estimate: the base the server's calculation is laid over,
    // and what shows (marked approximate) when a day was never fetched.
    ..registerLazySingleton<MockPanchangaDataSource>(
      () => MockPanchangaDataSource(resolver: sl<RegionResolver>()),
    )
    ..registerLazySingleton<PanchangaDataSource>(
      () => selectDataSource(
        mock: () => sl<MockPanchangaDataSource>(),
        live: () => ApiPanchangaDataSource(
          client: sl<ApiClient>(),
          local: sl<MockPanchangaDataSource>(),
          cache: BoundedJsonCache(
            sl<KeyValueStore>(),
            namespace: 'panchanga.day.v1',
          ),
          resolver: sl<RegionResolver>(),
        ),
      ),
    )
    ..registerLazySingleton<PanchangaRepository>(
      () => PanchangaRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetPanchanga(sl()))
    ..registerLazySingleton(() => GetSuvaSaits(sl()))
    ..registerFactory(
      () => PanchangaCubit(
        getPanchanga: sl(),
        getSuvaSaits: sl(),
        resolver: sl<RegionResolver>(),
      ),
    );
}
