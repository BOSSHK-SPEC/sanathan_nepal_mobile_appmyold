// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyForecastModel _$DailyForecastModelFromJson(Map<String, dynamic> json) =>
    _DailyForecastModel(
      date: DateTime.parse(json['date'] as String),
      maxTemperature: (json['max_temperature'] as num?)?.toDouble() ?? 0,
      minTemperature: (json['min_temperature'] as num?)?.toDouble() ?? 0,
      condition:
          $enumDecodeNullable(
            _$WeatherConditionEnumMap,
            json['condition'],
            unknownValue: WeatherCondition.partlyCloudy,
          ) ??
          WeatherCondition.partlyCloudy,
      sunrise: DateTime.parse(json['sunrise'] as String),
      sunset: DateTime.parse(json['sunset'] as String),
    );

Map<String, dynamic> _$DailyForecastModelToJson(_DailyForecastModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'max_temperature': instance.maxTemperature,
      'min_temperature': instance.minTemperature,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.mainlyClear: 'mainlyClear',
  WeatherCondition.partlyCloudy: 'partlyCloudy',
  WeatherCondition.overcast: 'overcast',
  WeatherCondition.fog: 'fog',
  WeatherCondition.drizzle: 'drizzle',
  WeatherCondition.rain: 'rain',
  WeatherCondition.heavyRain: 'heavyRain',
  WeatherCondition.showers: 'showers',
  WeatherCondition.snow: 'snow',
  WeatherCondition.thunderstorm: 'thunderstorm',
};
