import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

/// Kind of editorial content.
enum ArticleType {
  blog('blog'),
  news('news');

  const ArticleType(this.code);
  final String code;

  static ArticleType fromCode(String? code) => ArticleType.values.firstWhere(
    (t) => t.code == code,
    orElse: () => ArticleType.blog,
  );
}

/// Content language chosen by the reader (independent from the app locale).
/// Which values are offered comes from `RegionConfig.languageCodes`.
enum ContentLanguage {
  nepali('ne', 'नेपाली'),
  english('en', 'English'),
  hindi('hi', 'हिन्दी');

  const ContentLanguage(this.code, this.nativeName);

  /// ISO 639-1 code (`ne`, `en`, `hi`).
  final String code;

  /// Endonym shown on language switches regardless of the UI locale.
  final String nativeName;

  static ContentLanguage fromCode(String? code) => ContentLanguage.values
      .firstWhere((l) => l.code == code, orElse: () => english);
}

/// Localised text value (Nepali / English / Hindi).
///
/// English is mandatory; [ne] / [hi] hold only the variants a seed actually
/// carries. [forLanguage] applies the fallbacks: Hindi falls back to English,
/// Nepali falls back to Hindi (same script) and then English.
@freezed
abstract class ArticleText with _$ArticleText {
  const ArticleText._();

  const factory ArticleText({required String en, String? ne, String? hi}) =
      _ArticleText;

  /// Variant for an app / content language code (`ne`, `en`, `hi`).
  String forLanguage(String languageCode) => switch (languageCode) {
    'ne' => ne ?? hi ?? en,
    'hi' => hi ?? en,
    _ => en,
  };
}

/// A category or tag: a stable [key] plus its localised label.
@freezed
abstract class ArticleLabel with _$ArticleLabel {
  const factory ArticleLabel({
    required String key,
    required ArticleText label,
  }) = _ArticleLabel;
}

/// A blog post or news story.
@freezed
abstract class Article with _$Article {
  const factory Article({
    required String id,
    required ArticleType type,
    required ArticleText title,
    required ArticleText excerpt,

    /// Body paragraphs (each localised).
    required List<ArticleText> body,
    required ArticleLabel category,
    required List<ArticleLabel> tags,
    required DateTime publishedAt,
    required ArticleText author,
    required int readTimeMinutes,
    String? imageAsset,
    @Default(0) int likes,
    @Default(false) bool isLiked,
  }) = _Article;
}
