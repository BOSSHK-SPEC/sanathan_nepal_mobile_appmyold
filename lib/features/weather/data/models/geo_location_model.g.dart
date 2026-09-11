// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeoLocationModel _$GeoLocationModelFromJson(Map<String, dynamic> json) =>
    _GeoLocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      name: json['name'] as String? ?? '',
      nameNe: json['name_ne'] as String?,
      nameHi: json['name_hi'] as String?,
    );

Map<String, dynamic> _$GeoLocationModelToJson(_GeoLocationModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'name_ne': ?instance.nameNe,
      'name_hi': ?instance.nameHi,
    };
