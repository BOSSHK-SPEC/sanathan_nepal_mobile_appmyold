// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeSlotModel _$TimeSlotModelFromJson(Map<String, dynamic> json) =>
    _TimeSlotModel(
      id: json['id'] as String,
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num?)?.toInt() ?? 0,
      available: json['available'] as bool? ?? true,
    );

Map<String, dynamic> _$TimeSlotModelToJson(_TimeSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hour': instance.hour,
      'minute': instance.minute,
      'available': instance.available,
    };
