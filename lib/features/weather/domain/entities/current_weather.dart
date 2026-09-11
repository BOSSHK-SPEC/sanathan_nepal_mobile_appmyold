import 'package:freezed_annotation/freezed_annotation.dart';

import 'weather_condition.dart';

part 'current_weather.freezed.dart';

/// Present conditions at the requested location.
@freezed
abstract class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    required DateTime time,

    /// Air temperature in °C.
    required double temperature,
    required WeatherCondition condition,

    /// Relative humidity in percent (0–100).
    required int humidity,

    /// Wind speed in km/h.
    required double windSpeed,
    required bool isDay,

    /// Chance of precipitation in percent for the current hour.
    @Default(0) int precipitationProbability,
  }) = _CurrentWeather;
}
