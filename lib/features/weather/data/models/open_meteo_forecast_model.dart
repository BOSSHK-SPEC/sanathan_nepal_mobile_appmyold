import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_meteo_forecast_model.freezed.dart';
part 'open_meteo_forecast_model.g.dart';

/// Raw Open-Meteo `/forecast` response (only the blocks/variables the app
/// requests). Field names follow the real API keys via [JsonKey].
///
/// Expected query:
/// `current=temperature_2m,weather_code,relative_humidity_2m,wind_speed_10m`
/// `hourly=temperature_2m,precipitation_probability,weather_code`
/// `daily=temperature_2m_max,temperature_2m_min,weather_code,sunrise,sunset`
@freezed
abstract class OpenMeteoForecastModel with _$OpenMeteoForecastModel {
  const factory OpenMeteoForecastModel({
    double? latitude,
    double? longitude,
    String? timezone,
    @Default(OpenMeteoCurrentModel()) OpenMeteoCurrentModel current,
    @Default(OpenMeteoHourlyModel()) OpenMeteoHourlyModel hourly,
    @Default(OpenMeteoDailyModel()) OpenMeteoDailyModel daily,
  }) = _OpenMeteoForecastModel;

  factory OpenMeteoForecastModel.fromJson(Map<String, dynamic> json) =>
      _$OpenMeteoForecastModelFromJson(json);
}

/// `current` block: scalar values for the current hour.
@freezed
abstract class OpenMeteoCurrentModel with _$OpenMeteoCurrentModel {
  const factory OpenMeteoCurrentModel({
    /// ISO-8601 local time without offset, e.g. `2024-03-01T10:00`.
    String? time,
    @JsonKey(name: 'temperature_2m') double? temperature2m,
    @JsonKey(name: 'weather_code') int? weatherCode,
    @JsonKey(name: 'relative_humidity_2m') int? relativeHumidity2m,
    @JsonKey(name: 'wind_speed_10m') double? windSpeed10m,
  }) = _OpenMeteoCurrentModel;

  factory OpenMeteoCurrentModel.fromJson(Map<String, dynamic> json) =>
      _$OpenMeteoCurrentModelFromJson(json);
}

/// `hourly` block: parallel arrays indexed by [time].
@freezed
abstract class OpenMeteoHourlyModel with _$OpenMeteoHourlyModel {
  const factory OpenMeteoHourlyModel({
    @Default([]) List<String> time,
    @JsonKey(name: 'temperature_2m') @Default([]) List<double?> temperature2m,
    @JsonKey(name: 'precipitation_probability')
    @Default([])
    List<int?> precipitationProbability,
    @JsonKey(name: 'weather_code') @Default([]) List<int?> weatherCode,
  }) = _OpenMeteoHourlyModel;

  factory OpenMeteoHourlyModel.fromJson(Map<String, dynamic> json) =>
      _$OpenMeteoHourlyModelFromJson(json);
}

/// `daily` block: parallel arrays indexed by [time] (dates).
@freezed
abstract class OpenMeteoDailyModel with _$OpenMeteoDailyModel {
  const factory OpenMeteoDailyModel({
    @Default([]) List<String> time,
    @JsonKey(name: 'temperature_2m_max')
    @Default([])
    List<double?> temperature2mMax,
    @JsonKey(name: 'temperature_2m_min')
    @Default([])
    List<double?> temperature2mMin,
    @JsonKey(name: 'weather_code') @Default([]) List<int?> weatherCode,
    @Default([]) List<String?> sunrise,
    @Default([]) List<String?> sunset,
  }) = _OpenMeteoDailyModel;

  factory OpenMeteoDailyModel.fromJson(Map<String, dynamic> json) =>
      _$OpenMeteoDailyModelFromJson(json);
}
