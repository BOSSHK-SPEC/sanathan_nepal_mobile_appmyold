import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/daily_forecast.dart';
import '../../domain/entities/weather_condition.dart';

part 'daily_forecast_model.freezed.dart';
part 'daily_forecast_model.g.dart';

/// Wire/persistence shape of [DailyForecast].
@freezed
abstract class DailyForecastModel with _$DailyForecastModel {
  const DailyForecastModel._();

  const factory DailyForecastModel({
    required DateTime date,
    @Default(0) double maxTemperature,
    @Default(0) double minTemperature,
    @JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy)
    @Default(WeatherCondition.partlyCloudy)
    WeatherCondition condition,
    required DateTime sunrise,
    required DateTime sunset,
  }) = _DailyForecastModel;

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastModelFromJson(json);

  factory DailyForecastModel.fromEntity(DailyForecast e) => DailyForecastModel(
    date: e.date,
    maxTemperature: e.maxTemperature,
    minTemperature: e.minTemperature,
    condition: e.condition,
    sunrise: e.sunrise,
    sunset: e.sunset,
  );

  DailyForecast toEntity() => DailyForecast(
    date: date,
    maxTemperature: maxTemperature,
    minTemperature: minTemperature,
    condition: condition,
    sunrise: sunrise,
    sunset: sunset,
  );
}
