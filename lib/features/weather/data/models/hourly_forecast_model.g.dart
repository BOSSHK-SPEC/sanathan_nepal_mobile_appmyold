// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HourlyForecastModel _$HourlyForecastModelFromJson(Map<String, dynamic> json) =>
    _HourlyForecastModel(
      time: DateTime.parse(json['time'] as String),
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0,
      condition:
          $enumDecodeNullable(
            _$WeatherConditionEnumMap,
            json['condition'],
            unknownValue: WeatherCondition.partlyCloudy,
          ) ??
          WeatherCondition.partlyCloudy,
      precipitationProbability:
          (json['precipitation_probability'] as num?)?.toInt() ?? 0,
      isDay: json['is_day'] as bool? ?? true,
    );

Map<String, dynamic> _$HourlyForecastModelToJson(
  _HourlyForecastModel instance,
) => <String, dynamic>{
  'time': instance.time.toIso8601String(),
  'temperature': instance.temperature,
  'condition': _$WeatherConditionEnumMap[instance.condition]!,
  'precipitation_probability': instance.precipitationProbability,
  'is_day': instance.isDay,
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
