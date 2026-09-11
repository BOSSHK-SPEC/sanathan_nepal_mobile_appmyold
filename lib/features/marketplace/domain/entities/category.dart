import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

/// Marketplace product / service category (English / Nepali / Hindi).
@freezed
abstract class Category with _$Category {
  const Category._();

  const factory Category({
    required String id,
    required String nameEn,
    required String nameNe,

    /// Hindi name; falls back to [nameNe] when null.
    String? nameHi,

    /// Optional icon key resolved by the presentation layer.
    String? iconName,
  }) = _Category;

  /// Pseudo-category used for the "All" chip.
  static const Category all = Category(
    id: 'all',
    nameEn: 'All',
    nameNe: 'सबै',
    nameHi: 'सभी',
  );

  /// Name for [languageCode] (`en` / `ne` / `hi`).
  String name({required String languageCode}) => switch (languageCode) {
    'ne' => nameNe,
    'hi' => nameHi ?? nameNe,
    _ => nameEn,
  };
}
