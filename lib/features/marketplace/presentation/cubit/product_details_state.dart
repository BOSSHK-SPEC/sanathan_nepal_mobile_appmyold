part of 'product_details_cubit.dart';

/// "Description | Comments" toggle on the details page.
enum DetailsTab { description, comments }

@freezed
abstract class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState({
    @Default(LoadState.idle()) LoadState<Product> product,
    @Default(LoadState.idle()) LoadState<List<Product>> similar,
    @Default(0) int selectedImage,
    @Default({}) Map<String, String> selectedOptions,
    @Default(DetailsTab.description) DetailsTab tab,

    /// Outcome of the last "Add to cart" / "Buy now" tap
    /// (loading → loaded / failed).
    @Default(LoadState.idle()) LoadState<Cart> addToCart,

    /// True when the last add-to-cart came from "Buy now" – the page then
    /// continues to checkout once it succeeds.
    @Default(false) bool buyNow,
  }) = _ProductDetailsState;
}
