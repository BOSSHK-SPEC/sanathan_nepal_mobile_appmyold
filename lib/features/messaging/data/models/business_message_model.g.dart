// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessMessageModel _$BusinessMessageModelFromJson(
  Map<String, dynamic> json,
) => _BusinessMessageModel(
  id: json['id'] as String,
  threadId: json['thread_id'] as String,
  sentAt: DateTime.parse(json['sent_at'] as String),
  sender:
      $enumDecodeNullable(_$MessageSideEnumMap, json['sender']) ??
      MessageSide.customer,
  body: json['body'] as String? ?? '',
  read: json['read'] as bool? ?? false,
);

Map<String, dynamic> _$BusinessMessageModelToJson(
  _BusinessMessageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'thread_id': instance.threadId,
  'sent_at': instance.sentAt.toIso8601String(),
  'sender': _$MessageSideEnumMap[instance.sender]!,
  'body': instance.body,
  'read': instance.read,
};

const _$MessageSideEnumMap = {
  MessageSide.customer: 'customer',
  MessageSide.owner: 'owner',
};
