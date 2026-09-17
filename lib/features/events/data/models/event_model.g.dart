// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalizedTextModel _$LocalizedTextModelFromJson(Map<String, dynamic> json) =>
    _LocalizedTextModel(
      ne: json['ne'] as String? ?? '',
      en: json['en'] as String? ?? '',
      hi: json['hi'] as String? ?? '',
    );

Map<String, dynamic> _$LocalizedTextModelToJson(_LocalizedTextModel instance) =>
    <String, dynamic>{'ne': instance.ne, 'en': instance.en, 'hi': instance.hi};

_EventTimeModel _$EventTimeModelFromJson(Map<String, dynamic> json) =>
    _EventTimeModel(
      hour: (json['hour'] as num?)?.toInt() ?? 0,
      minute: (json['minute'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$EventTimeModelToJson(_EventTimeModel instance) =>
    <String, dynamic>{'hour': instance.hour, 'minute': instance.minute};

_EventReminderModel _$EventReminderModelFromJson(Map<String, dynamic> json) =>
    _EventReminderModel(
      daysBefore: (json['days_before'] as num?)?.toInt() ?? 1,
      time: json['time'] == null
          ? const EventTimeModel()
          : EventTimeModel.fromJson(json['time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventReminderModelToJson(_EventReminderModel instance) =>
    <String, dynamic>{
      'days_before': instance.daysBefore,
      'time': instance.time.toJson(),
    };

_ChecklistItemModel _$ChecklistItemModelFromJson(Map<String, dynamic> json) =>
    _ChecklistItemModel(
      id: json['id'] as String,
      label: json['label'] as String,
      isDone: json['is_done'] as bool? ?? false,
    );

Map<String, dynamic> _$ChecklistItemModelToJson(_ChecklistItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'is_done': instance.isDone,
    };

_EventModel _$EventModelFromJson(Map<String, dynamic> json) => _EventModel(
  id: json['id'] as String,
  title: LocalizedTextModel.fromJson(json['title'] as Map<String, dynamic>),
  date: DateTime.parse(json['date'] as String),
  category: $enumDecode(
    _$EventCategoryEnumMap,
    json['category'],
    unknownValue: EventCategory.personal,
  ),
  description: json['description'] == null
      ? const LocalizedTextModel()
      : LocalizedTextModel.fromJson(
          json['description'] as Map<String, dynamic>,
        ),
  time: json['time'] == null
      ? null
      : EventTimeModel.fromJson(json['time'] as Map<String, dynamic>),
  isHoliday: json['is_holiday'] as bool? ?? false,
  isVrat: json['is_vrat'] as bool? ?? false,
  isImportant: json['is_important'] as bool? ?? false,
  imagePath: json['image_path'] as String?,
  location: json['location'] == null
      ? const LocalizedTextModel()
      : LocalizedTextModel.fromJson(json['location'] as Map<String, dynamic>),
  tithi: json['tithi'] == null
      ? const LocalizedTextModel()
      : LocalizedTextModel.fromJson(json['tithi'] as Map<String, dynamic>),
  howToCelebrate: json['how_to_celebrate'] == null
      ? const LocalizedTextModel()
      : LocalizedTextModel.fromJson(
          json['how_to_celebrate'] as Map<String, dynamic>,
        ),
  attractionPlaces: json['attraction_places'] == null
      ? const LocalizedTextModel()
      : LocalizedTextModel.fromJson(
          json['attraction_places'] as Map<String, dynamic>,
        ),
  videoUrl: json['video_url'] as String?,
  checklist:
      (json['checklist'] as List<dynamic>?)
          ?.map((e) => ChecklistItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  reminder: json['reminder'] == null
      ? null
      : EventReminderModel.fromJson(json['reminder'] as Map<String, dynamic>),
  repeat:
      $enumDecodeNullable(
        _$EventRepeatEnumMap,
        json['repeat'],
        unknownValue: EventRepeat.none,
      ) ??
      EventRepeat.none,
  useTraditionalDate: json['use_traditional_date'] as bool? ?? false,
);

Map<String, dynamic> _$EventModelToJson(_EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title.toJson(),
      'date': instance.date.toIso8601String(),
      'category': _$EventCategoryEnumMap[instance.category]!,
      'description': instance.description.toJson(),
      'time': ?instance.time?.toJson(),
      'is_holiday': instance.isHoliday,
      'is_vrat': instance.isVrat,
      'is_important': instance.isImportant,
      'image_path': ?instance.imagePath,
      'location': instance.location.toJson(),
      'tithi': instance.tithi.toJson(),
      'how_to_celebrate': instance.howToCelebrate.toJson(),
      'attraction_places': instance.attractionPlaces.toJson(),
      'video_url': ?instance.videoUrl,
      'checklist': instance.checklist.map((e) => e.toJson()).toList(),
      'reminder': ?instance.reminder?.toJson(),
      'repeat': _$EventRepeatEnumMap[instance.repeat]!,
      'use_traditional_date': instance.useTraditionalDate,
    };

const _$EventCategoryEnumMap = {
  EventCategory.hinduFestival: 'hinduFestival',
  EventCategory.buddhistFestival: 'buddhistFestival',
  EventCategory.islamicFestival: 'islamicFestival',
  EventCategory.kiratFestival: 'kiratFestival',
  EventCategory.christianFestival: 'christianFestival',
  EventCategory.sikhFestival: 'sikhFestival',
  EventCategory.jainFestival: 'jainFestival',
  EventCategory.publicHoliday: 'publicHoliday',
  EventCategory.birthday: 'birthday',
  EventCategory.personal: 'personal',
  EventCategory.official: 'official',
  EventCategory.anniversary: 'anniversary',
  EventCategory.travel: 'travel',
  EventCategory.picnic: 'picnic',
  EventCategory.adventure: 'adventure',
  EventCategory.sports: 'sports',
  EventCategory.todo: 'todo',
};

const _$EventRepeatEnumMap = {
  EventRepeat.none: 'none',
  EventRepeat.daily: 'daily',
  EventRepeat.weekly: 'weekly',
  EventRepeat.monthly: 'monthly',
  EventRepeat.yearly: 'yearly',
};
