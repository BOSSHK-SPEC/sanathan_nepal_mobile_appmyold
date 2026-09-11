import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/geo_location.dart';
import '../../domain/entities/weather_bundle.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

/// Tries the remote (Open-Meteo) source first and silently falls back to the
/// mock source when the network is unavailable, so the UI always has data.
class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({
    required WeatherDataSource remote,
    required WeatherDataSource fallback,
  }) : _remote = remote,
       _fallback = fallback;

  final WeatherDataSource _remote;
  final WeatherDataSource _fallback;

  @override
  Future<Result<WeatherBundle>> getForecast(GeoLocation location) =>
      guard(() async {
        try {
          return (await _remote.fetchForecast(location)).toEntity();
        } catch (_) {
          final mock = await _fallback.fetchForecast(location);
          return mock.toEntity().copyWith(isFallback: true);
        }
      });
}
