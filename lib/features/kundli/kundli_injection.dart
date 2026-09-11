import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_resolver.dart';
import 'data/datasources/api_kundli_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../core/storage/key_value_store.dart';
import 'data/datasources/ephemeris.dart';
import 'data/datasources/kundli_data_source.dart';
import 'data/datasources/local_kundli_data_source.dart';
import 'data/repositories/kundli_repository_impl.dart';
import 'domain/repositories/kundli_repository.dart';
import 'domain/usecases/kundli_usecases.dart';
import 'presentation/cubit/chart_cubit.dart';
import 'presentation/cubit/chart_form_cubit.dart';
import 'presentation/cubit/gun_milan_cubit.dart';
import 'presentation/cubit/saved_charts_cubit.dart';

/// Registers data sources, repositories, use cases and cubits for `kundli`.
///
/// [Ephemeris] is registered separately so swapping the deterministic
/// stand-in for a real ephemeris is a one-line change here.
void registerKundliFeature(GetIt sl) {
  sl
    ..registerLazySingleton<Ephemeris>(DeterministicEphemeris.new)
    ..registerLazySingleton<KundliDataSource>(
      () => selectDataSource(
        // The on-device ephemeris stays the offline/test implementation; the
        // server owns the maths that paid reports are billed on.
        mock: () => LocalKundliDataSource(sl<KeyValueStore>(), sl<Ephemeris>()),
        live: () => ApiKundliDataSource(sl<ApiClient>(), sl<RegionResolver>()),
      ),
    )
    ..registerLazySingleton<KundliRepository>(() => KundliRepositoryImpl(sl()))
    ..registerLazySingleton(() => GetBirthProfiles(sl()))
    ..registerLazySingleton(() => SaveBirthProfile(sl()))
    ..registerLazySingleton(() => DeleteBirthProfile(sl()))
    ..registerLazySingleton(() => GetKundliChart(sl()))
    ..registerLazySingleton(() => GetDashas(sl()))
    ..registerLazySingleton(() => GetDoshas(sl()))
    ..registerLazySingleton(() => MatchKundlis(sl()))
    ..registerFactory(
      () => SavedChartsCubit(getProfiles: sl(), deleteProfile: sl()),
    )
    ..registerFactory(() => ChartFormCubit(saveProfile: sl()))
    ..registerFactory(
      () => GunMilanCubit(getProfiles: sl(), matchKundlis: sl()),
    )
    ..registerFactoryParam<ChartCubit, String, void>(
      (profileId, _) => ChartCubit(
        profileId: profileId,
        getChart: sl(),
        getDashas: sl(),
        getDoshas: sl(),
      ),
    );
}
