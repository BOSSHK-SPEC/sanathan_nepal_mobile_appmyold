// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductCommentModel _$ProductCommentModelFromJson(Map<String, dynamic> json) =>
    _ProductCommentModel(
      id: json['id'] as String,
      author: json['author'] as String,
      message: json['message'] as String,
      postedAt: DateTime.parse(json['posted_at'] as String),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$ProductCommentModelToJson(
  _ProductCommentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'message': instance.message,
  'posted_at': instance.postedAt.toIso8601String(),
  'avatar': ?instance.avatar,
};
