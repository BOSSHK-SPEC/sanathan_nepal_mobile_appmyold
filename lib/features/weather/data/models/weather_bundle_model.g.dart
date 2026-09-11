// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_bundle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherBundleModel _$WeatherBundleModelFromJson(
  Map<String, dynamic> json,
) => _WeatherBundleModel(
  location: GeoLocationModel.fromJson(json['location'] as Map<String, dynamic>),
  current: CurrentWeatherModel.fromJson(
    json['current'] as Map<String, dynamic>,
  ),
  hourly:
      (json['hourly'] as List<dynamic>?)
          ?.map((e) => HourlyForecastModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  daily:
      (json['daily'] as List<dynamic>?)
          ?.map((e) => DailyForecastModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isFallback: json['is_fallback'] as bool? ?? false,
);

Map<String, dynamic> _$WeatherBundleModelToJson(_WeatherBundleModel instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'current': instance.current.toJson(),
      'hourly': instance.hourly.map((e) => e.toJson()).toList(),
      'daily': instance.daily.map((e) => e.toJson()).toList(),
      'is_fallback': instance.isFallback,
    };
