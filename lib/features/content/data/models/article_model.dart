import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/article.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

/// JSON shape of [ArticleText] (`{"en": …, "ne": …, "hi": …}`; absent
/// variants are omitted).
@freezed
abstract class ArticleTextModel with _$ArticleTextModel {
  const ArticleTextModel._();

  const factory ArticleTextModel({
    @Default('') String en,
    String? ne,
    String? hi,
  }) = _ArticleTextModel;

  factory ArticleTextModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleTextModelFromJson(json);

  factory ArticleTextModel.fromEntity(ArticleText e) =>
      ArticleTextModel(en: e.en, ne: e.ne, hi: e.hi);

  ArticleText toEntity() => ArticleText(en: en, ne: ne, hi: hi);
}

/// JSON shape of [ArticleLabel].
@freezed
abstract class ArticleLabelModel with _$ArticleLabelModel {
  const ArticleLabelModel._();

  const factory ArticleLabelModel({
    required String key,
    required ArticleTextModel label,
  }) = _ArticleLabelModel;

  factory ArticleLabelModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleLabelModelFromJson(json);

  factory ArticleLabelModel.fromEntity(ArticleLabel e) => ArticleLabelModel(
    key: e.key,
    label: ArticleTextModel.fromEntity(e.label),
  );

  ArticleLabel toEntity() => ArticleLabel(key: key, label: label.toEntity());
}

/// JSON-serialisable [Article]. [ArticleType] travels by name
/// (`blog` / `news`); unknown values fall back to `blog`.
@freezed
abstract class ArticleModel with _$ArticleModel {
  const ArticleModel._();

  const factory ArticleModel({
    required String id,
    @JsonKey(unknownEnumValue: ArticleType.blog)
    @Default(ArticleType.blog)
    ArticleType type,
    required ArticleTextModel title,
    required ArticleTextModel excerpt,
    @Default([]) List<ArticleTextModel> body,
    required ArticleLabelModel category,
    @Default([]) List<ArticleLabelModel> tags,
    required DateTime publishedAt,
    required ArticleTextModel author,
    @Default(1) int readTimeMinutes,
    String? imageAsset,
    @Default(0) int likes,
    @Default(false) bool isLiked,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  factory ArticleModel.fromEntity(Article e) => ArticleModel(
    id: e.id,
    type: e.type,
    title: ArticleTextModel.fromEntity(e.title),
    excerpt: ArticleTextModel.fromEntity(e.excerpt),
    body: e.body.map(ArticleTextModel.fromEntity).toList(),
    category: ArticleLabelModel.fromEntity(e.category),
    tags: e.tags.map(ArticleLabelModel.fromEntity).toList(),
    publishedAt: e.publishedAt,
    author: ArticleTextModel.fromEntity(e.author),
    readTimeMinutes: e.readTimeMinutes,
    imageAsset: e.imageAsset,
    likes: e.likes,
    isLiked: e.isLiked,
  );

  Article toEntity() => Article(
    id: id,
    type: type,
    title: title.toEntity(),
    excerpt: excerpt.toEntity(),
    body: body.map((p) => p.toEntity()).toList(),
    category: category.toEntity(),
    tags: tags.map((t) => t.toEntity()).toList(),
    publishedAt: publishedAt,
    author: author.toEntity(),
    readTimeMinutes: readTimeMinutes,
    imageAsset: imageAsset,
    likes: likes,
    isLiked: isLiked,
  );
}
