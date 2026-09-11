import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_weather.dart';
import '../../domain/entities/weather_condition.dart';

part 'current_weather_model.freezed.dart';
part 'current_weather_model.g.dart';

/// Wire/persistence shape of [CurrentWeather].
@freezed
abstract class CurrentWeatherModel with _$CurrentWeatherModel {
  const CurrentWeatherModel._();

  const factory CurrentWeatherModel({
    required DateTime time,
    @Default(0) double temperature,
    @JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy)
    @Default(WeatherCondition.partlyCloudy)
    WeatherCondition condition,
    @Default(0) int humidity,
    @Default(0) double windSpeed,
    @Default(true) bool isDay,
    @Default(0) int precipitationProbability,
  }) = _CurrentWeatherModel;

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherModelFromJson(json);

  factory CurrentWeatherModel.fromEntity(CurrentWeather e) =>
      CurrentWeatherModel(
        time: e.time,
        temperature: e.temperature,
        condition: e.condition,
        humidity: e.humidity,
        windSpeed: e.windSpeed,
        isDay: e.isDay,
        precipitationProbability: e.precipitationProbability,
      );

  CurrentWeather toEntity() => CurrentWeather(
    time: time,
    temperature: temperature,
    condition: condition,
    humidity: humidity,
    windSpeed: windSpeed,
    isDay: isDay,
    precipitationProbability: precipitationProbability,
  );
}
