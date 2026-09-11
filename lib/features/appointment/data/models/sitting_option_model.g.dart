// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitting_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SittingOptionModel _$SittingOptionModelFromJson(Map<String, dynamic> json) =>
    _SittingOptionModel(
      id: json['id'] as String,
      channel:
          $enumDecodeNullable(_$SittingChannelEnumMap, json['channel']) ??
          SittingChannel.chat,
      name: LocalizedTextModel.fromJson(json['name'] as Map<String, dynamic>),
      price: (json['price'] as num).toInt(),
      ratePerMinute: (json['rate_per_minute'] as num?)?.toDouble() ?? 0,
      description: LocalizedTextModel.fromJson(
        json['description'] as Map<String, dynamic>,
      ),
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$SittingOptionModelToJson(_SittingOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channel': _$SittingChannelEnumMap[instance.channel]!,
      'name': instance.name.toJson(),
      'price': instance.price,
      'rate_per_minute': instance.ratePerMinute,
      'description': instance.description.toJson(),
      'duration_minutes': instance.durationMinutes,
    };

const _$SittingChannelEnumMap = {
  SittingChannel.chat: 'chat',
  SittingChannel.voice: 'voice',
  SittingChannel.video: 'video',
};
