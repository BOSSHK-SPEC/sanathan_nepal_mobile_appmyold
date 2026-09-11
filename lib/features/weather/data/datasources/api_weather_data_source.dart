import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../domain/entities/geo_location.dart';
import '../../domain/entities/weather_condition.dart';
import '../models/current_weather_model.dart';
import '../models/daily_forecast_model.dart';
import '../models/geo_location_model.dart';
import '../models/hourly_forecast_model.dart';
import '../models/weather_bundle_model.dart';
import 'weather_remote_data_source.dart';

/// Forecasts as our backend serves them.
///
/// The backend fronts Open-Meteo with a short cache keyed on the rounded
/// coordinates, so a city's worth of users costs one upstream call — and the
/// upstream API key (should the provider ever require one) never ships in the
/// app bundle.
class ApiWeatherDataSource implements WeatherDataSource {
  const ApiWeatherDataSource(this._client);

  final ApiClient _client;

  @override
  Future<WeatherBundleModel> fetchForecast(GeoLocation location) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.weather,
          query: {'lat': location.latitude, 'lon': location.longitude},
        );
        final json = asJsonMap(response);
        final current = _map(json['current']);
        final fetchedAt = ApiTime.instantOr(json['fetchedAt'], DateTime.now());

        return WeatherBundleModel(
          // The name is the app's own (the user picked a city); the backend
          // only knows coordinates.
          location: GeoLocationModel.fromEntity(location),
          current: CurrentWeatherModel(
            time: fetchedAt,
            temperature: _num(current['temperatureC']),
            condition: WeatherCondition.fromWmo(_int(current['weatherCode'])),
            humidity: _int(current['humidity']),
            windSpeed: _num(current['windSpeedKph']),
            isDay: _isDay(fetchedAt),
          ),
          hourly: _list(json['hourly']).map(_hour).toList(growable: false),
          daily: _list(json['daily']).map(_day).toList(growable: false),
        );
      });

  HourlyForecastModel _hour(Map<String, dynamic> json) {
    final time = ApiTime.instant(json['time']);
    return HourlyForecastModel(
      time: time ?? DateTime.now(),
      temperature: _num(json['temperatureC']),
      condition: WeatherCondition.fromWmo(_int(json['weatherCode'])),
      isDay: _isDay(time),
    );
  }

  DailyForecastModel _day(Map<String, dynamic> json) {
    final date = ApiTime.dateOr(json['date'], DateTime.now());
    return DailyForecastModel(
      date: date,
      maxTemperature: _num(json['maxTemperatureC']),
      minTemperature: _num(json['minTemperatureC']),
      condition: WeatherCondition.fromWmo(_int(json['weatherCode'])),
      // Sunrise/sunset drive the day/night artwork, so a missing value has to
      // resolve to something ordered rather than to `date` twice.
      sunrise:
          ApiTime.instant(json['sunrise']) ??
          date.add(const Duration(hours: 6)),
      sunset:
          ApiTime.instant(json['sunset']) ??
          date.add(const Duration(hours: 18)),
    );
  }

  /// Daylight is approximated from the clock rather than from that day's
  /// sunrise: the hourly strip is drawn before the daily list is parsed, and
  /// being an hour off at the edges only changes an icon.
  static bool _isDay(DateTime? at) {
    final hour = (at ?? DateTime.now()).hour;
    return hour >= 6 && hour < 18;
  }

  static Map<String, dynamic> _map(Object? raw) =>
      raw is Map ? Map<String, dynamic>.from(raw) : const {};

  static List<Map<String, dynamic>> _list(Object? raw) => raw is List
      ? raw.whereType<Map>().map(Map<String, dynamic>.from).toList()
      : const [];

  static double _num(Object? raw) => (raw as num?)?.toDouble() ?? 0;

  static int _int(Object? raw) => (raw as num?)?.toInt() ?? 0;
}
