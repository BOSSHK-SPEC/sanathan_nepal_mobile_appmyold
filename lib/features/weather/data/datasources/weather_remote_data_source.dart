import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/geo_location.dart';
import '../models/weather_bundle_model.dart';

/// I/O contract for forecast data. Implemented by the Open-Meteo client and
/// by [MockWeatherDataSource].
abstract interface class WeatherDataSource {
  Future<WeatherBundleModel> fetchForecast(GeoLocation location);
}

/// Open-Meteo implementation (`https://api.open-meteo.com/v1/forecast`).
class OpenMeteoWeatherDataSource implements WeatherDataSource {
  const OpenMeteoWeatherDataSource(this._client);
  final ApiClient _client;

  static const String _path = '/forecast';

  @override
  Future<WeatherBundleModel> fetchForecast(GeoLocation location) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        _path,
        query: <String, dynamic>{
          'latitude': location.latitude,
          'longitude': location.longitude,
          'current':
              'temperature_2m,weather_code,relative_humidity_2m,wind_speed_10m',
          'hourly': 'temperature_2m,precipitation_probability,weather_code',
          'daily':
              'temperature_2m_max,temperature_2m_min,weather_code,sunrise,sunset',
          'timezone': 'auto',
        },
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException('Open-Meteo error', response.statusCode);
      }
      return WeatherBundleModel.fromOpenMeteo(data, location: location);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException(e.message ?? 'No internet connection');
      }
      throw ServerException(
        e.message ?? 'Server error',
        e.response?.statusCode,
      );
    }
  }
}
