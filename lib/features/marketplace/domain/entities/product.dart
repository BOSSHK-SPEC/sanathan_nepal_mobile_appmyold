import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_comment.dart';
import 'seller.dart';

part 'product.freezed.dart';

/// Whether a listing is brand new or second-hand.
enum ProductCondition { brandNew, used }

/// A product or service listed on the marketplace.
///
/// Titles / descriptions / locations are bilingual so the UI can switch
/// language without another round-trip: `title` is English, `titleNe` is the
/// listing's *local Devanagari-language* text – Nepali for Nepal listings,
/// Hindi for India listings (see `MockProductSeedIndia`). Use
/// [titleFor] / [descriptionFor] / [locationFor] with the UI language code.
@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String title,
    required String titleNe,
    required String description,
    required String descriptionNe,
    required double price,
    required String categoryId,
    required List<String> images,
    required Seller seller,
    required String location,
    required String locationNe,
    required DateTime postedAt,
    @Default('NPR') String currency,
    @Default(ProductCondition.used) ProductCondition condition,
    @Default(0) int views,
    @Default(0) int likes,
    @Default(0) double rating,
    @Default(false) bool isBoosted,
    @Default(false) bool isFavourite,

    /// True when the current user is the seller (used by "My Products").
    @Default(false) bool isMine,

    /// The shop this listing belongs to, when the seller has an approved one.
    /// A business profile's Products and Services tabs are exactly the
    /// listings carrying its id.
    String? businessId,
    @Default(false) bool negotiable,

    /// True for service listings ("Product vs Service" in the seller form).
    @Default(false) bool isService,
    String? websiteLink,
    DateTime? expiresAt,

    /// Free-form specifications shown in the "General" card
    /// (e.g. `{'Carat': '7', 'Origin': 'Sri Lanka'}`).
    @Default({}) Map<String, String> specs,

    /// Selectable options (e.g. `{'Select Metal': ['Silver', 'Gold']}`).
    @Default({}) Map<String, List<String>> options,
    @Default([]) List<ProductComment> comments,

    /// Seller video links shown in the "Product Videos" card.
    @Default([]) List<String> videos,
  }) = _Product;

  String get primaryImage => images.isEmpty ? '' : images.first;

  /// True for the Devanagari UI languages (`ne` / `hi`) that use the local
  /// text variants.
  static bool _local(String languageCode) =>
      languageCode == 'ne' || languageCode == 'hi';

  String titleFor({required String languageCode}) =>
      _local(languageCode) ? titleNe : title;
  String descriptionFor({required String languageCode}) =>
      _local(languageCode) ? descriptionNe : description;

  /// First paragraph of the description (shown under the title).
  String summaryFor({required String languageCode}) =>
      descriptionFor(languageCode: languageCode).split('\n\n').first.trim();

  /// Remaining paragraphs (long "details" block); empty when the
  /// description is a single paragraph.
  List<String> detailParagraphsFor({required String languageCode}) =>
      descriptionFor(languageCode: languageCode)
          .split('\n\n')
          .skip(1)
          .map((p) => p.trim())
          .where((p) => p.isNotEmpty)
          .toList();
  String locationFor({required String languageCode}) =>
      _local(languageCode) ? locationNe : location;
}
