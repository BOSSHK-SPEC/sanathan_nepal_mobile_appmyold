// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_thread_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageThreadModel _$MessageThreadModelFromJson(Map<String, dynamic> json) =>
    _MessageThreadModel(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      lastMessageAt: DateTime.parse(json['last_message_at'] as String),
      side:
          $enumDecodeNullable(_$MessageSideEnumMap, json['side']) ??
          MessageSide.customer,
      businessName: json['business_name'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      contactName: json['contact_name'] as String? ?? '',
      contactEmail: json['contact_email'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      lastMessagePreview: json['last_message_preview'] as String? ?? '',
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      archived: json['archived'] as bool? ?? false,
      businessLogoUrl: json['business_logo_url'] as String?,
      otherSideUnread: (json['other_side_unread'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MessageThreadModelToJson(_MessageThreadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'last_message_at': instance.lastMessageAt.toIso8601String(),
      'side': _$MessageSideEnumMap[instance.side]!,
      'business_name': instance.businessName,
      'customer_name': instance.customerName,
      'contact_name': instance.contactName,
      'contact_email': instance.contactEmail,
      'subject': instance.subject,
      'last_message_preview': instance.lastMessagePreview,
      'unread_count': instance.unreadCount,
      'archived': instance.archived,
      'business_logo_url': ?instance.businessLogoUrl,
      'other_side_unread': instance.otherSideUnread,
    };

const _$MessageSideEnumMap = {
  MessageSide.customer: 'customer',
  MessageSide.owner: 'owner',
};
