part of 'product_listing_cubit.dart';

@freezed
abstract class ProductListingState with _$ProductListingState {
  const ProductListingState._();

  const factory ProductListingState({
    @Default(ProductFilter()) ProductFilter filter,
    @Default(LoadState.idle()) LoadState<List<Product>> products,
    @Default(LoadState.idle()) LoadState<List<Category>> categories,
  }) = _ProductListingState;

  /// The category currently selected in [filter], if it is known.
  Category? get category => (categories.dataOrNull ?? const [])
      .where((c) => c.id == filter.categoryId)
      .firstOrNull;
}
