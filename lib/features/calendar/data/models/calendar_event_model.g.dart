// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarEventModel _$CalendarEventModelFromJson(Map<String, dynamic> json) =>
    _CalendarEventModel(
      id: json['id'] as String,
      date: _dateFromJson(json['date'] as String),
      titleNe: json['title_ne'] as String? ?? '',
      titleEn: json['title_en'] as String? ?? '',
      titleHi: json['title_hi'] as String? ?? '',
      descriptionNe: json['description_ne'] as String? ?? '',
      descriptionEn: json['description_en'] as String? ?? '',
      descriptionHi: json['description_hi'] as String? ?? '',
      tithiNe: json['tithi_ne'] as String? ?? '',
      tithiEn: json['tithi_en'] as String? ?? '',
      isHoliday: json['is_holiday'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$CalendarEventModelToJson(_CalendarEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': _dateToJson(instance.date),
      'title_ne': instance.titleNe,
      'title_en': instance.titleEn,
      'title_hi': instance.titleHi,
      'description_ne': instance.descriptionNe,
      'description_en': instance.descriptionEn,
      'description_hi': instance.descriptionHi,
      'tithi_ne': instance.tithiNe,
      'tithi_en': instance.tithiEn,
      'is_holiday': instance.isHoliday,
      'image_url': ?instance.imageUrl,
    };
