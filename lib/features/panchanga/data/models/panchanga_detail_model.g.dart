// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panchanga_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PanchangaDetailModel _$PanchangaDetailModelFromJson(
  Map<String, dynamic> json,
) => _PanchangaDetailModel(
  labelNe: json['label_ne'] as String? ?? '',
  labelEn: json['label_en'] as String? ?? '',
  value: json['value'] as String? ?? '',
);

Map<String, dynamic> _$PanchangaDetailModelToJson(
  _PanchangaDetailModel instance,
) => <String, dynamic>{
  'label_ne': instance.labelNe,
  'label_en': instance.labelEn,
  'value': instance.value,
};
