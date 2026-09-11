import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filter.freezed.dart';

/// Sort order for product listings ("Sort by: Latest / Price Low to High /
/// Price High to Low" in Figma).
enum ProductSort { latest, priceLowToHigh, priceHighToLow }

/// Query parameters for [ProductRepository.getProducts].
///
/// Use `copyWith(categoryId: null)` / `copyWith(query: null)` to clear a
/// field (freezed distinguishes an explicit `null` from an omitted argument).
@freezed
abstract class ProductFilter with _$ProductFilter {
  const factory ProductFilter({
    String? categoryId,
    String? query,
    @Default(ProductSort.latest) ProductSort sort,
    @Default(false) bool boostedOnly,
    @Default(false) bool mineOnly,

    /// Restricts to one shop's listings — what its profile's Products and
    /// Services tabs show.
    String? businessId,

    /// Restricts to listings the buyer has saved. Set by the Saved
    /// screen rather than the sort/category row, so it is not something
    /// browsing can switch on by accident.
    @Default(false) bool favouritesOnly,
    int? limit,
  }) = _ProductFilter;
}
