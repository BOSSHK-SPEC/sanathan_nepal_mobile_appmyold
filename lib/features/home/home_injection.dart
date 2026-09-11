import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_metal_rates_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import 'data/datasources/metal_rates_data_source.dart';
import 'data/repositories/metal_rates_repository_impl.dart';
import 'domain/repositories/metal_rates_repository.dart';
import 'domain/usecases/get_metal_rates.dart';
import 'presentation/cubit/home_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `home`.
///
/// Needs the `RegionResolver` from `app_settings` (bullion market/unit).
void registerHomeFeature(GetIt sl) {
  sl
    ..registerLazySingleton<MetalRatesDataSource>(
      () => selectDataSource(
        mock: () => MockMetalRatesDataSource(sl<RegionResolver>()),
        live: () =>
            ApiMetalRatesDataSource(sl<ApiClient>(), sl<RegionResolver>()),
      ),
    )
    ..registerLazySingleton<MetalRatesRepository>(
      () => MetalRatesRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetMetalRates(sl()))
    ..registerFactory(() => HomeCubit(getMetalRates: sl()));
}
