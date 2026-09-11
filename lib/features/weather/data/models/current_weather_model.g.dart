// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentWeatherModel _$CurrentWeatherModelFromJson(Map<String, dynamic> json) =>
    _CurrentWeatherModel(
      time: DateTime.parse(json['time'] as String),
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0,
      condition:
          $enumDecodeNullable(
            _$WeatherConditionEnumMap,
            json['condition'],
            unknownValue: WeatherCondition.partlyCloudy,
          ) ??
          WeatherCondition.partlyCloudy,
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0,
      isDay: json['is_day'] as bool? ?? true,
      precipitationProbability:
          (json['precipitation_probability'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CurrentWeatherModelToJson(
  _CurrentWeatherModel instance,
) => <String, dynamic>{
  'time': instance.time.toIso8601String(),
  'temperature': instance.temperature,
  'condition': _$WeatherConditionEnumMap[instance.condition]!,
  'humidity': instance.humidity,
  'wind_speed': instance.windSpeed,
  'is_day': instance.isDay,
  'precipitation_probability': instance.precipitationProbability,
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
