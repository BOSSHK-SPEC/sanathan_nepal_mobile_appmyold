import 'package:get_it/get_it.dart';

import '../../app/di/injection.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_all.dart';
import '../../core/config/data_source_selector.dart';
import 'data/datasources/api_weather_data_source.dart';
import 'data/datasources/mock_weather_data_source.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'data/services/geolocator_location_service.dart';
import 'data/services/mock_location_service.dart';
import 'domain/repositories/location_service.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_weather.dart';
import 'domain/usecases/get_weather_for_location.dart';
import 'presentation/cubit/weather_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `weather`.
///
/// [LocationService] is bound to the geolocator implementation with the
/// mock (region default city: Kathmandu / New Delhi) as its fallback – swap
/// the registration to `MockLocationService(resolver: …)` to run without
/// device location.
void registerWeatherFeature(GetIt sl) {
  sl
    ..registerLazySingleton<MockWeatherDataSource>(MockWeatherDataSource.new)
    ..registerLazySingleton<OpenMeteoWeatherDataSource>(
      () => OpenMeteoWeatherDataSource(
        sl<ApiClient>(instanceName: ApiClients.openMeteo),
      ),
    )
    ..registerLazySingleton<WeatherDataSource>(
      () => selectDataSource(
        mock: () => sl<MockWeatherDataSource>(),
        live: () => ApiWeatherDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
        remote: sl<WeatherDataSource>(),
        // If our API is unreachable the forecast still comes from Open-Meteo
        // directly; the seeded mock is the last resort.
        fallback: selectDataSource(
          mock: () => sl<MockWeatherDataSource>(),
          live: () => sl<OpenMeteoWeatherDataSource>(),
        ),
      ),
    )
    ..registerLazySingleton<LocationService>(
      () => GeolocatorLocationService(
        fallback: MockLocationService(resolver: sl<RegionResolver>()),
      ),
    )
    ..registerLazySingleton(
      () => GetWeather(
        repository: sl(),
        locationService: sl(),
        resolver: sl<RegionResolver>(),
      ),
    )
    ..registerLazySingleton(() => GetWeatherForLocation(sl()))
    ..registerFactory(
      () => WeatherCubit(getWeather: sl(), getWeatherForLocation: sl()),
    );
}
