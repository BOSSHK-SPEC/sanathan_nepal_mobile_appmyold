import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'product_draft.freezed.dart';

/// Editable payload for the seller "Add / Edit Product" form
/// ([CreateProduct] / [UpdateProduct]).
///
/// The seller, timestamps and counters are filled in by the data layer –
/// the form only owns what the user can type. `titleLocal` /
/// `descriptionLocal` are the Devanagari (Nepali / Hindi) variants and fall
/// back to the English text when left empty.
@freezed
abstract class ProductDraft with _$ProductDraft {
  const ProductDraft._();

  const factory ProductDraft({
    @Default('') String title,
    @Default('') String titleLocal,
    @Default('') String categoryId,
    @Default('') String description,
    @Default('') String descriptionLocal,
    @Default(0) double price,
    @Default(ProductCondition.used) ProductCondition condition,
    @Default(false) bool isService,
    @Default(false) bool negotiable,
    @Default([]) List<String> images,
    @Default('') String location,
    @Default('') String locationLocal,
    @Default('') String phone,
    String? websiteLink,
    @Default(30) int expiryDays,
  }) = _ProductDraft;

  /// Pre-fills a draft from an existing listing (edit mode).
  factory ProductDraft.fromProduct(Product p, {required DateTime now}) =>
      ProductDraft(
        title: p.title,
        titleLocal: p.titleNe,
        categoryId: p.categoryId,
        description: p.description,
        descriptionLocal: p.descriptionNe,
        price: p.price,
        condition: p.condition,
        isService: p.isService,
        negotiable: p.negotiable,
        images: p.images,
        location: p.location,
        locationLocal: p.locationNe,
        phone: p.seller.phone ?? '',
        websiteLink: p.websiteLink,
        expiryDays: p.expiresAt == null
            ? 30
            : p.expiresAt!.difference(now).inDays.clamp(1, 365),
      );

  String get effectiveTitleLocal => titleLocal.isEmpty ? title : titleLocal;
  String get effectiveDescriptionLocal =>
      descriptionLocal.isEmpty ? description : descriptionLocal;
  String get effectiveLocationLocal =>
      locationLocal.isEmpty ? location : locationLocal;
}
