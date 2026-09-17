part of 'product_form_cubit.dart';

/// Fields the seller form validates.
enum ProductFormField {
  title,
  category,
  description,
  location,
  photos,
  price,
  phone,
  website,
}

/// Validation outcome per field (rendered via `MarketplaceStrings`).
enum ProductFormError {
  required,
  invalidPrice,
  invalidCategory,
  invalidPhone,

  /// A website that is not an address the app could open. Optional field —
  /// this fires only when something was typed.
  invalidWebsite,
}

@freezed
abstract class ProductFormState with _$ProductFormState {
  const ProductFormState._();

  const factory ProductFormState({
    /// Listing being edited; `null` while creating a new one.
    String? productId,
    @Default(ProductDraft()) ProductDraft draft,

    /// The existing product loaded for edit mode.
    @Default(LoadState.idle()) LoadState<Product> initial,
    @Default(LoadState.idle()) LoadState<List<Category>> categories,

    /// Result of Save / Update.
    @Default(LoadState.idle()) LoadState<Product> submission,

    /// Result of Delete (`true` when the listing was removed).
    @Default(LoadState.idle()) LoadState<bool> deletion,
    @Default({}) Map<ProductFormField, ProductFormError> errors,

    /// True after the first submit attempt – errors are shown live from then.
    @Default(false) bool submitted,

    /// Category names renamed through the "Product Category edit" popup
    /// (display-only overrides, keyed by category id).
    @Default({}) Map<String, String> categoryNames,
  }) = _ProductFormState;

  bool get isEdit => productId != null;
  bool get isBusy => submission.isLoading || deletion.isLoading;
  bool get isValid => errors.isEmpty;
}
