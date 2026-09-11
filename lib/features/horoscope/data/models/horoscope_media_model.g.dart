// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HoroscopeMediaModel _$HoroscopeMediaModelFromJson(Map<String, dynamic> json) =>
    _HoroscopeMediaModel(
      titleNe: json['title_ne'] as String? ?? '',
      titleEn: json['title_en'] as String? ?? '',
      titleHi: json['title_hi'] as String? ?? '',
      durationSeconds: (json['duration'] as num?)?.toInt() ?? 0,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$HoroscopeMediaModelToJson(
  _HoroscopeMediaModel instance,
) => <String, dynamic>{
  'title_ne': instance.titleNe,
  'title_en': instance.titleEn,
  'title_hi': instance.titleHi,
  'duration': instance.durationSeconds,
  'url': ?instance.url,
};
