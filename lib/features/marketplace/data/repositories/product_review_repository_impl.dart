import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/product_review.dart';
import '../../domain/repositories/product_review_repository.dart';
import '../datasources/product_review_data_source.dart';

class ProductReviewRepositoryImpl implements ProductReviewRepository {
  const ProductReviewRepositoryImpl(this._source);

  final ProductReviewDataSource _source;

  @override
  Future<Result<List<ProductReview>>> reviews(
    String productId, {
    ReviewSort sort = ReviewSort.recent,
    int? minRating,
    bool withPhotosOnly = false,
  }) => guard(
    () => _source.reviews(
      productId,
      sort: sort,
      minRating: minRating,
      withPhotosOnly: withPhotosOnly,
    ),
  );

  @override
  Future<Result<ProductRatingSummary>> summary(String productId) =>
      guard(() => _source.summary(productId));

  @override
  Future<Result<ProductReview>> submit(ProductReviewDraft draft) =>
      guard(() => _source.submit(draft));

  @override
  Future<Result<ProductReview>> toggleHelpful(String reviewId) =>
      guard(() => _source.toggleHelpful(reviewId));

  @override
  Future<Result<ProductReview>> reply(String reviewId, String message) =>
      guard(() => _source.reply(reviewId, message));

  @override
  Future<Result<List<PendingReview>>> pendingReviews() =>
      guard(_source.pendingReviews);
}
