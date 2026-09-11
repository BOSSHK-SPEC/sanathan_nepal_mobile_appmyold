import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_forecast.dart';
import '../../domain/entities/geo_location.dart';
import '../../domain/entities/hourly_forecast.dart';
import '../../domain/entities/weather_bundle.dart';
import '../../domain/entities/weather_condition.dart';
import '../models/weather_bundle_model.dart';
import 'weather_remote_data_source.dart';

/// Deterministic offline forecast used in tests and as a network fallback.
///
/// The seed mirrors the Figma mock: 26 °C partly cloudy, 6 % rain, 90 %
/// humidity, 19 km/h wind, hourly 29/26/24/23 … and a 7-day 13/10 forecast.
class MockWeatherDataSource implements WeatherDataSource {
  const MockWeatherDataSource({this.now});

  /// Fixed clock for tests; defaults to `DateTime.now()`.
  final DateTime? now;

  static const List<WeatherCondition> _hourlyPattern = [
    WeatherCondition.partlyCloudy,
    WeatherCondition.partlyCloudy,
    WeatherCondition.clear,
    WeatherCondition.clear,
    WeatherCondition.partlyCloudy,
    WeatherCondition.overcast,
    WeatherCondition.showers,
    WeatherCondition.rain,
  ];

  static const List<WeatherCondition> _dailyPattern = [
    WeatherCondition.partlyCloudy,
    WeatherCondition.heavyRain,
    WeatherCondition.thunderstorm,
    WeatherCondition.showers,
    WeatherCondition.showers,
    WeatherCondition.thunderstorm,
    WeatherCondition.thunderstorm,
  ];

  static const List<double> _hourlyTemps = [
    29,
    26,
    24,
    23,
    22,
    21,
    20,
    19,
    18,
    18,
    17,
    17,
    18,
    20,
    22,
    24,
    26,
    27,
    28,
    28,
    27,
    26,
    25,
    24,
  ];

  @override
  Future<WeatherBundleModel> fetchForecast(GeoLocation location) async {
    final clock = now ?? DateTime.now();
    final startHour = DateTime(clock.year, clock.month, clock.day, clock.hour);
    final today = DateTime(clock.year, clock.month, clock.day);

    final daily = List.generate(7, (i) {
      final date = today.add(Duration(days: i));
      return DailyForecast(
        date: date,
        maxTemperature: i == 0 ? 29 : 13 + (i % 3).toDouble(),
        minTemperature: i == 0 ? 17 : 10 - (i % 2).toDouble(),
        condition: _dailyPattern[i % _dailyPattern.length],
        sunrise: DateTime(date.year, date.month, date.day, 6, 26),
        sunset: DateTime(date.year, date.month, date.day, 18, 6),
      );
    });

    final hourly = List.generate(48, (i) {
      final time = startHour.add(Duration(hours: i));
      final isDay = time.hour >= 6 && time.hour < 18;
      return HourlyForecast(
        time: time,
        temperature: _hourlyTemps[i % _hourlyTemps.length],
        condition: _hourlyPattern[(i ~/ 3) % _hourlyPattern.length],
        precipitationProbability: 6 + (i * 7) % 40,
        isDay: isDay,
      );
    });

    final bundle = WeatherBundle(
      location: location,
      current: CurrentWeather(
        time: startHour,
        temperature: 26,
        condition: WeatherCondition.partlyCloudy,
        humidity: 90,
        windSpeed: 19,
        isDay: startHour.hour >= 6 && startHour.hour < 18,
        precipitationProbability: 6,
      ),
      hourly: hourly,
      daily: daily,
      isFallback: true,
    );
    return WeatherBundleModel.fromEntity(bundle);
  }
}
