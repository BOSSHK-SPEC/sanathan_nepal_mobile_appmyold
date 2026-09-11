import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_product.freezed.dart';

/// A product/service the user marked as favourite
/// (Figma "Your Favorite Product & Services" grid).
@freezed
abstract class FavouriteProduct with _$FavouriteProduct {
  const factory FavouriteProduct({
    required String id,
    required String name,
    required String description,

    /// e.g. `रु. 10,000 - 20,000` / `₹8,000 - ₹16,000` (region currency).
    required String priceLabel,

    /// e.g. `Brand New`.
    required String condition,
    required String sellerName,
    required String location,
    required int views,
    required int sold,

    /// 0–5.
    required double rating,
    required DateTime postedAt,
    String? imageUrl,
  }) = _FavouriteProduct;
}
