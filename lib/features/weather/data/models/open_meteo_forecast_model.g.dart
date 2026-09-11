// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_meteo_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpenMeteoForecastModel _$OpenMeteoForecastModelFromJson(
  Map<String, dynamic> json,
) => _OpenMeteoForecastModel(
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  timezone: json['timezone'] as String?,
  current: json['current'] == null
      ? const OpenMeteoCurrentModel()
      : OpenMeteoCurrentModel.fromJson(json['current'] as Map<String, dynamic>),
  hourly: json['hourly'] == null
      ? const OpenMeteoHourlyModel()
      : OpenMeteoHourlyModel.fromJson(json['hourly'] as Map<String, dynamic>),
  daily: json['daily'] == null
      ? const OpenMeteoDailyModel()
      : OpenMeteoDailyModel.fromJson(json['daily'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OpenMeteoForecastModelToJson(
  _OpenMeteoForecastModel instance,
) => <String, dynamic>{
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'timezone': ?instance.timezone,
  'current': instance.current.toJson(),
  'hourly': instance.hourly.toJson(),
  'daily': instance.daily.toJson(),
};

_OpenMeteoCurrentModel _$OpenMeteoCurrentModelFromJson(
  Map<String, dynamic> json,
) => _OpenMeteoCurrentModel(
  time: json['time'] as String?,
  temperature2m: (json['temperature_2m'] as num?)?.toDouble(),
  weatherCode: (json['weather_code'] as num?)?.toInt(),
  relativeHumidity2m: (json['relative_humidity_2m'] as num?)?.toInt(),
  windSpeed10m: (json['wind_speed_10m'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OpenMeteoCurrentModelToJson(
  _OpenMeteoCurrentModel instance,
) => <String, dynamic>{
  'time': ?instance.time,
  'temperature_2m': ?instance.temperature2m,
  'weather_code': ?instance.weatherCode,
  'relative_humidity_2m': ?instance.relativeHumidity2m,
  'wind_speed_10m': ?instance.windSpeed10m,
};

_OpenMeteoHourlyModel _$OpenMeteoHourlyModelFromJson(
  Map<String, dynamic> json,
) => _OpenMeteoHourlyModel(
  time:
      (json['time'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  temperature2m:
      (json['temperature_2m'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toDouble())
          .toList() ??
      const [],
  precipitationProbability:
      (json['precipitation_probability'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList() ??
      const [],
  weatherCode:
      (json['weather_code'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$OpenMeteoHourlyModelToJson(
  _OpenMeteoHourlyModel instance,
) => <String, dynamic>{
  'time': instance.time,
  'temperature_2m': instance.temperature2m,
  'precipitation_probability': instance.precipitationProbability,
  'weather_code': instance.weatherCode,
};

_OpenMeteoDailyModel _$OpenMeteoDailyModelFromJson(
  Map<String, dynamic> json,
) => _OpenMeteoDailyModel(
  time:
      (json['time'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  temperature2mMax:
      (json['temperature_2m_max'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toDouble())
          .toList() ??
      const [],
  temperature2mMin:
      (json['temperature_2m_min'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toDouble())
          .toList() ??
      const [],
  weatherCode:
      (json['weather_code'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList() ??
      const [],
  sunrise:
      (json['sunrise'] as List<dynamic>?)?.map((e) => e as String?).toList() ??
      const [],
  sunset:
      (json['sunset'] as List<dynamic>?)?.map((e) => e as String?).toList() ??
      const [],
);

Map<String, dynamic> _$OpenMeteoDailyModelToJson(
  _OpenMeteoDailyModel instance,
) => <String, dynamic>{
  'time': instance.time,
  'temperature_2m_max': instance.temperature2mMax,
  'temperature_2m_min': instance.temperature2mMin,
  'weather_code': instance.weatherCode,
  'sunrise': instance.sunrise,
  'sunset': instance.sunset,
};
