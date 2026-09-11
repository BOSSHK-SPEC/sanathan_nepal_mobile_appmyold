// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotificationModel _$AppNotificationModelFromJson(
  Map<String, dynamic> json,
) => _AppNotificationModel(
  id: json['id'] as String,
  titleNe: json['title_ne'] as String? ?? '',
  titleEn: json['title_en'] as String? ?? '',
  titleHi: json['title_hi'] as String? ?? '',
  bodyNe: json['body_ne'] as String? ?? '',
  bodyEn: json['body_en'] as String? ?? '',
  bodyHi: json['body_hi'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
  type:
      $enumDecodeNullable(
        _$NotificationTypeEnumMap,
        json['type'],
        unknownValue: NotificationType.general,
      ) ??
      NotificationType.general,
  isRead: json['is_read'] as bool? ?? false,
  route: json['route'] as String?,
);

Map<String, dynamic> _$AppNotificationModelToJson(
  _AppNotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title_ne': instance.titleNe,
  'title_en': instance.titleEn,
  'title_hi': instance.titleHi,
  'body_ne': instance.bodyNe,
  'body_en': instance.bodyEn,
  'body_hi': instance.bodyHi,
  'created_at': instance.createdAt.toIso8601String(),
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'is_read': instance.isRead,
  'route': ?instance.route,
};

const _$NotificationTypeEnumMap = {
  NotificationType.general: 'general',
  NotificationType.event: 'event',
  NotificationType.horoscope: 'horoscope',
  NotificationType.festival: 'festival',
  NotificationType.birthday: 'birthday',
  NotificationType.order: 'order',
  NotificationType.appointment: 'appointment',
};
