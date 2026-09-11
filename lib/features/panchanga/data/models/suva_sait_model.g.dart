// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suva_sait_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuvaSaitModel _$SuvaSaitModelFromJson(Map<String, dynamic> json) =>
    _SuvaSaitModel(
      id: json['id'] as String,
      titleNe: json['title_ne'] as String? ?? '',
      titleEn: json['title_en'] as String? ?? '',
      dates:
          (json['dates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      noteNe: json['note_ne'] as String? ?? '',
      noteEn: json['note_en'] as String? ?? '',
    );

Map<String, dynamic> _$SuvaSaitModelToJson(_SuvaSaitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_ne': instance.titleNe,
      'title_en': instance.titleEn,
      'dates': instance.dates.map((e) => e.toIso8601String()).toList(),
      'note_ne': instance.noteNe,
      'note_en': instance.noteEn,
    };
