// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astrologer_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AstrologerReviewModel _$AstrologerReviewModelFromJson(
  Map<String, dynamic> json,
) => _AstrologerReviewModel(
  id: json['id'] as String,
  astrologerId: json['astrologer_id'] as String,
  authorName: json['author_name'] as String,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  authorAvatar: json['author_avatar'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  reply: json['reply'] as String?,
  repliedAt: json['replied_at'] == null
      ? null
      : DateTime.parse(json['replied_at'] as String),
  consultationId: json['consultation_id'] as String?,
);

Map<String, dynamic> _$AstrologerReviewModelToJson(
  _AstrologerReviewModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'astrologer_id': instance.astrologerId,
  'author_name': instance.authorName,
  'rating': instance.rating,
  'comment': instance.comment,
  'created_at': instance.createdAt.toIso8601String(),
  'author_avatar': ?instance.authorAvatar,
  'tags': instance.tags,
  'reply': ?instance.reply,
  'replied_at': ?instance.repliedAt?.toIso8601String(),
  'consultation_id': ?instance.consultationId,
};
