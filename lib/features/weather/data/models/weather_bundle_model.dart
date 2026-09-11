import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/geo_location.dart';
import '../../domain/entities/weather_bundle.dart';
import '../../domain/entities/weather_condition.dart';
import 'current_weather_model.dart';
import 'daily_forecast_model.dart';
import 'geo_location_model.dart';
import 'hourly_forecast_model.dart';
import 'open_meteo_forecast_model.dart';

part 'weather_bundle_model.freezed.dart';
part 'weather_bundle_model.g.dart';

/// Wire/persistence shape of [WeatherBundle]; built from the Open-Meteo
/// response with [WeatherBundleModel.fromOpenMeteo].
@freezed
abstract class WeatherBundleModel with _$WeatherBundleModel {
  const WeatherBundleModel._();

  const factory WeatherBundleModel({
    required GeoLocationModel location,
    required CurrentWeatherModel current,
    @Default([]) List<HourlyForecastModel> hourly,
    @Default([]) List<DailyForecastModel> daily,
    @Default(false) bool isFallback,
  }) = _WeatherBundleModel;

  factory WeatherBundleModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherBundleModelFromJson(json);

  factory WeatherBundleModel.fromEntity(WeatherBundle e) => WeatherBundleModel(
    location: GeoLocationModel.fromEntity(e.location),
    current: CurrentWeatherModel.fromEntity(e.current),
    hourly: [for (final h in e.hourly) HourlyForecastModel.fromEntity(h)],
    daily: [for (final d in e.daily) DailyForecastModel.fromEntity(d)],
    isFallback: e.isFallback,
  );

  /// Parses the raw Open-Meteo `/forecast` JSON for [location].
  factory WeatherBundleModel.fromOpenMeteo(
    Map<String, dynamic> json, {
    required GeoLocation location,
  }) {
    final raw = OpenMeteoForecastModel.fromJson(json);
    final daily = _parseDaily(raw.daily);
    final hourly = _parseHourly(raw.hourly, daily);
    final current = _parseCurrent(raw.current, daily, hourly);
    return WeatherBundleModel(
      location: GeoLocationModel.fromEntity(location),
      current: current,
      hourly: hourly,
      daily: daily,
    );
  }

  WeatherBundle toEntity() => WeatherBundle(
    location: location.toEntity(),
    current: current.toEntity(),
    hourly: [for (final h in hourly) h.toEntity()],
    daily: [for (final d in daily) d.toEntity()],
    isFallback: isFallback,
  );

  static CurrentWeatherModel _parseCurrent(
    OpenMeteoCurrentModel c,
    List<DailyForecastModel> daily,
    List<HourlyForecastModel> hourly,
  ) {
    final time = _date(c.time) ?? DateTime.now();
    final hour = hourly.where((h) => !h.time.isBefore(time)).firstOrNull;
    return CurrentWeatherModel(
      time: time,
      temperature: c.temperature2m ?? 0,
      condition: WeatherCondition.fromWmo(c.weatherCode ?? 0),
      humidity: c.relativeHumidity2m ?? 0,
      windSpeed: c.windSpeed10m ?? 0,
      isDay: _isDay(time, daily),
      precipitationProbability: hour?.precipitationProbability ?? 0,
    );
  }

  static List<HourlyForecastModel> _parseHourly(
    OpenMeteoHourlyModel h,
    List<DailyForecastModel> daily,
  ) => List.generate(h.time.length, (i) {
    final time = _date(h.time[i]) ?? DateTime.now();
    return HourlyForecastModel(
      time: time,
      temperature: h.temperature2m.elementAtOrNull(i) ?? 0,
      condition: WeatherCondition.fromWmo(
        h.weatherCode.elementAtOrNull(i) ?? 0,
      ),
      precipitationProbability:
          h.precipitationProbability.elementAtOrNull(i) ?? 0,
      isDay: _isDay(time, daily),
    );
  }, growable: false);

  static List<DailyForecastModel> _parseDaily(OpenMeteoDailyModel d) =>
      List.generate(d.time.length, (i) {
        final date = _date(d.time[i]) ?? DateTime.now();
        return DailyForecastModel(
          date: date,
          maxTemperature: d.temperature2mMax.elementAtOrNull(i) ?? 0,
          minTemperature: d.temperature2mMin.elementAtOrNull(i) ?? 0,
          condition: WeatherCondition.fromWmo(
            d.weatherCode.elementAtOrNull(i) ?? 0,
          ),
          sunrise:
              _date(d.sunrise.elementAtOrNull(i)) ??
              DateTime(date.year, date.month, date.day, 6),
          sunset:
              _date(d.sunset.elementAtOrNull(i)) ??
              DateTime(date.year, date.month, date.day, 18),
        );
      }, growable: false);

  static bool _isDay(DateTime time, List<DailyForecastModel> daily) {
    for (final day in daily) {
      if (day.date.year == time.year &&
          day.date.month == time.month &&
          day.date.day == time.day) {
        return !time.isBefore(day.sunrise) && time.isBefore(day.sunset);
      }
    }
    return time.hour >= 6 && time.hour < 18;
  }

  static DateTime? _date(String? v) => v == null ? null : DateTime.tryParse(v);
}
