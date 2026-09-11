// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleTextModel _$ArticleTextModelFromJson(Map<String, dynamic> json) =>
    _ArticleTextModel(
      en: json['en'] as String? ?? '',
      ne: json['ne'] as String?,
      hi: json['hi'] as String?,
    );

Map<String, dynamic> _$ArticleTextModelToJson(_ArticleTextModel instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ne': ?instance.ne,
      'hi': ?instance.hi,
    };

_ArticleLabelModel _$ArticleLabelModelFromJson(Map<String, dynamic> json) =>
    _ArticleLabelModel(
      key: json['key'] as String,
      label: ArticleTextModel.fromJson(json['label'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticleLabelModelToJson(_ArticleLabelModel instance) =>
    <String, dynamic>{'key': instance.key, 'label': instance.label.toJson()};

_ArticleModel _$ArticleModelFromJson(
  Map<String, dynamic> json,
) => _ArticleModel(
  id: json['id'] as String,
  type:
      $enumDecodeNullable(
        _$ArticleTypeEnumMap,
        json['type'],
        unknownValue: ArticleType.blog,
      ) ??
      ArticleType.blog,
  title: ArticleTextModel.fromJson(json['title'] as Map<String, dynamic>),
  excerpt: ArticleTextModel.fromJson(json['excerpt'] as Map<String, dynamic>),
  body:
      (json['body'] as List<dynamic>?)
          ?.map((e) => ArticleTextModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  category: ArticleLabelModel.fromJson(
    json['category'] as Map<String, dynamic>,
  ),
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => ArticleLabelModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  publishedAt: DateTime.parse(json['published_at'] as String),
  author: ArticleTextModel.fromJson(json['author'] as Map<String, dynamic>),
  readTimeMinutes: (json['read_time_minutes'] as num?)?.toInt() ?? 1,
  imageAsset: json['image_asset'] as String?,
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  isLiked: json['is_liked'] as bool? ?? false,
);

Map<String, dynamic> _$ArticleModelToJson(_ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ArticleTypeEnumMap[instance.type]!,
      'title': instance.title.toJson(),
      'excerpt': instance.excerpt.toJson(),
      'body': instance.body.map((e) => e.toJson()).toList(),
      'category': instance.category.toJson(),
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'published_at': instance.publishedAt.toIso8601String(),
      'author': instance.author.toJson(),
      'read_time_minutes': instance.readTimeMinutes,
      'image_asset': ?instance.imageAsset,
      'likes': instance.likes,
      'is_liked': instance.isLiked,
    };

const _$ArticleTypeEnumMap = {
  ArticleType.blog: 'blog',
  ArticleType.news: 'news',
};
