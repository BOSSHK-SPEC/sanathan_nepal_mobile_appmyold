import 'package:freezed_annotation/freezed_annotation.dart';

import 'weather_condition.dart';

part 'hourly_forecast.freezed.dart';

/// One hour of forecast data.
@freezed
abstract class HourlyForecast with _$HourlyForecast {
  const factory HourlyForecast({
    required DateTime time,

    /// Temperature in °C.
    required double temperature,
    required WeatherCondition condition,

    /// Chance of precipitation in percent (0–100).
    required int precipitationProbability,
    @Default(true) bool isDay,
  }) = _HourlyForecast;
}
