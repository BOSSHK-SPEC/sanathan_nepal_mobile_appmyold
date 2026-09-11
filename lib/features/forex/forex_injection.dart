import 'package:get_it/get_it.dart';

import '../../app/di/injection.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_all.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/api_forex_data_source.dart';
import 'data/datasources/forex_local_data_source.dart';
import 'data/datasources/forex_remote_data_source.dart';
import 'data/datasources/frankfurter_forex_remote_data_source.dart';
import 'data/datasources/mock_forex_data_source.dart';
import 'data/datasources/regional_forex_data_source.dart';
import 'data/repositories/forex_repository_impl.dart';
import 'domain/repositories/forex_repository.dart';
import 'domain/usecases/convert_currency.dart';
import 'domain/usecases/get_latest_rates.dart';
import 'domain/usecases/get_rate_history.dart';
import 'domain/usecases/manage_favourite_currencies.dart';
import 'presentation/cubit/forex_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `forex`.
///
/// The live source is our backend, which normalises both regions' rate tables;
/// the region-aware public APIs (Nepal → NRB, India → Frankfurter/ECB, chosen
/// at call time through [RegionResolver]) are the fallback, and the
/// deterministic mock backs both under test.
void registerForexFeature(GetIt sl) {
  sl
    ..registerLazySingleton<MockForexDataSource>(
      () => MockForexDataSource(sl<RegionResolver>()),
    )
    ..registerLazySingleton<NrbForexRemoteDataSource>(
      () => NrbForexRemoteDataSource(
        sl<ApiClient>(instanceName: ApiClients.nrbForex),
      ),
    )
    ..registerLazySingleton<FrankfurterForexRemoteDataSource>(
      // Absolute URLs – uses the default (un-based) client.
      () => FrankfurterForexRemoteDataSource(sl<ApiClient>()),
    )
    ..registerLazySingleton<RegionalForexDataSource>(
      () => RegionalForexDataSource(
        resolver: sl<RegionResolver>(),
        nepal: sl<NrbForexRemoteDataSource>(),
        india: sl<FrankfurterForexRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<ForexRemoteDataSource>(
      () => selectDataSource(
        mock: () => sl<MockForexDataSource>(),
        live: () => ApiForexDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<ForexLocalDataSource>(
      () => ForexLocalDataSourceImpl(sl<KeyValueStore>(), sl<RegionResolver>()),
    )
    ..registerLazySingleton<ForexRepository>(
      () => ForexRepositoryImpl(
        remote: sl<ForexRemoteDataSource>(),
        // Two independent live sources: if our API is unreachable the rates
        // still come from the central bank directly, and only if that fails
        // too does the deterministic seed take over.
        fallback: selectDataSource(
          mock: () => sl<MockForexDataSource>(),
          live: () => sl<RegionalForexDataSource>(),
        ),
        local: sl<ForexLocalDataSource>(),
      ),
    )
    ..registerLazySingleton(() => GetLatestRates(sl()))
    ..registerLazySingleton(() => GetRateHistory(sl()))
    ..registerLazySingleton(ConvertCurrency.new)
    ..registerLazySingleton(() => GetFavouriteCurrencies(sl()))
    ..registerLazySingleton(() => SaveFavouriteCurrencies(sl()))
    ..registerFactory(
      () => ForexCubit(
        getLatestRates: sl(),
        getRateHistory: sl(),
        convertCurrency: sl(),
        getFavourites: sl(),
        saveFavourites: sl(),
        resolver: sl<RegionResolver>(),
      ),
    );
}
