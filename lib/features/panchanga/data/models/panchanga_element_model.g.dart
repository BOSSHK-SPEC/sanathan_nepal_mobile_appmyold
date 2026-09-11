// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panchanga_element_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PanchangaElementModel _$PanchangaElementModelFromJson(
  Map<String, dynamic> json,
) => _PanchangaElementModel(
  nameNe: json['name_ne'] as String? ?? '',
  nameEn: json['name_en'] as String? ?? '',
  endsAt: DateTime.parse(json['ends_at'] as String),
  nextNe: json['next_ne'] as String? ?? '',
  nextEn: json['next_en'] as String? ?? '',
  ghatiPala: json['ghati_pala'] as String? ?? '',
  bhukta: (json['bhukta'] as num?)?.toDouble() ?? 0,
  bhogya: (json['bhogya'] as num?)?.toDouble() ?? 0,
  spashta: (json['spashta'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$PanchangaElementModelToJson(
  _PanchangaElementModel instance,
) => <String, dynamic>{
  'name_ne': instance.nameNe,
  'name_en': instance.nameEn,
  'ends_at': instance.endsAt.toIso8601String(),
  'next_ne': instance.nextNe,
  'next_en': instance.nextEn,
  'ghati_pala': instance.ghatiPala,
  'bhukta': instance.bhukta,
  'bhogya': instance.bhogya,
  'spashta': instance.spashta,
};
