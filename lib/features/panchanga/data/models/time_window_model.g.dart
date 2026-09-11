// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_window_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeWindowModel _$TimeWindowModelFromJson(Map<String, dynamic> json) =>
    _TimeWindowModel(
      kind:
          $enumDecodeNullable(
            _$TimeWindowKindEnumMap,
            json['kind'],
            unknownValue: TimeWindowKind.choghadiya,
          ) ??
          TimeWindowKind.choghadiya,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      nameNe: json['name_ne'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      quality:
          $enumDecodeNullable(
            _$ChoghadiyaQualityEnumMap,
            json['quality'],
            unknownValue: ChoghadiyaQuality.neutral,
          ) ??
          ChoghadiyaQuality.neutral,
    );

Map<String, dynamic> _$TimeWindowModelToJson(_TimeWindowModel instance) =>
    <String, dynamic>{
      'kind': _$TimeWindowKindEnumMap[instance.kind]!,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'name_ne': instance.nameNe,
      'name_en': instance.nameEn,
      'quality': _$ChoghadiyaQualityEnumMap[instance.quality]!,
    };

const _$TimeWindowKindEnumMap = {
  TimeWindowKind.rahuKaal: 'rahuKaal',
  TimeWindowKind.yamaganda: 'yamaganda',
  TimeWindowKind.gulikaKaal: 'gulikaKaal',
  TimeWindowKind.abhijit: 'abhijit',
  TimeWindowKind.choghadiya: 'choghadiya',
};

const _$ChoghadiyaQualityEnumMap = {
  ChoghadiyaQuality.good: 'good',
  ChoghadiyaQuality.neutral: 'neutral',
  ChoghadiyaQuality.bad: 'bad',
};
