import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/hourly_forecast.dart';
import '../../domain/entities/weather_condition.dart';

part 'hourly_forecast_model.freezed.dart';
part 'hourly_forecast_model.g.dart';

/// Wire/persistence shape of [HourlyForecast].
@freezed
abstract class HourlyForecastModel with _$HourlyForecastModel {
  const HourlyForecastModel._();

  const factory HourlyForecastModel({
    required DateTime time,
    @Default(0) double temperature,
    @JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy)
    @Default(WeatherCondition.partlyCloudy)
    WeatherCondition condition,
    @Default(0) int precipitationProbability,
    @Default(true) bool isDay,
  }) = _HourlyForecastModel;

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastModelFromJson(json);

  factory HourlyForecastModel.fromEntity(HourlyForecast e) =>
      HourlyForecastModel(
        time: e.time,
        temperature: e.temperature,
        condition: e.condition,
        precipitationProbability: e.precipitationProbability,
        isDay: e.isDay,
      );

  HourlyForecast toEntity() => HourlyForecast(
    time: time,
    temperature: temperature,
    condition: condition,
    precipitationProbability: precipitationProbability,
    isDay: isDay,
  );
}
