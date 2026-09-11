import 'package:freezed_annotation/freezed_annotation.dart';

import 'weather_condition.dart';

part 'daily_forecast.freezed.dart';

/// One calendar day of forecast data.
@freezed
abstract class DailyForecast with _$DailyForecast {
  const factory DailyForecast({
    required DateTime date,

    /// Daily maximum in °C.
    required double maxTemperature,

    /// Daily minimum in °C.
    required double minTemperature,
    required WeatherCondition condition,
    required DateTime sunrise,
    required DateTime sunset,
  }) = _DailyForecast;
}
