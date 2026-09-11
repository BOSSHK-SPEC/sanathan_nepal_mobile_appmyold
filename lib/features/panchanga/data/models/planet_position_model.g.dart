// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanetPositionModel _$PlanetPositionModelFromJson(Map<String, dynamic> json) =>
    _PlanetPositionModel(
      nameNe: json['name_ne'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );

Map<String, dynamic> _$PlanetPositionModelToJson(
  _PlanetPositionModel instance,
) => <String, dynamic>{
  'name_ne': instance.nameNe,
  'name_en': instance.nameEn,
  'value': instance.value,
};
