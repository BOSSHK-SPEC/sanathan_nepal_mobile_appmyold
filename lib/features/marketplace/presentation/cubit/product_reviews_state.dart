part of 'product_reviews_cubit.dart';

@freezed
abstract class ProductReviewsState with _$ProductReviewsState {
  const ProductReviewsState._();

  const factory ProductReviewsState({
    @Default(LoadState.idle()) LoadState<List<ProductReview>> reviews,
    @Default(LoadState.idle()) LoadState<ProductRatingSummary> summary,
    @Default(ReviewSort.recent) ReviewSort sort,
    @Default(false) bool withPhotosOnly,
    int? minRating,
    String? busyReviewId,
    String? actionError,
  }) = _ProductReviewsState;

  List<ProductReview> get all => reviews.dataOrNull ?? const [];

  ProductRatingSummary get scores =>
      summary.dataOrNull ?? const ProductRatingSummary();

  bool get hasFilters => minRating != null || withPhotosOnly;

  /// True only when a completed load returned nothing, so the empty state
  /// never flashes while the first request is in flight.
  bool get isEmpty => reviews.isLoaded && all.isEmpty;
}
