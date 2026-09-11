import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product_review.dart';
import '../repositories/product_review_repository.dart';

/// A product plus how its reviews should be narrowed and ordered.
class ReviewQuery {
  const ReviewQuery({
    required this.productId,
    this.sort = ReviewSort.recent,
    this.minRating,
    this.withPhotosOnly = false,
  });

  final String productId;
  final ReviewSort sort;
  final int? minRating;
  final bool withPhotosOnly;
}

class GetProductReviews implements UseCase<List<ProductReview>, ReviewQuery> {
  const GetProductReviews(this._repo);
  final ProductReviewRepository _repo;

  @override
  Future<Result<List<ProductReview>>> call(ReviewQuery params) => _repo.reviews(
    params.productId,
    sort: params.sort,
    minRating: params.minRating,
    withPhotosOnly: params.withPhotosOnly,
  );
}

class GetRatingSummary implements UseCase<ProductRatingSummary, String> {
  const GetRatingSummary(this._repo);
  final ProductReviewRepository _repo;

  @override
  Future<Result<ProductRatingSummary>> call(String params) =>
      _repo.summary(params);
}

class SubmitProductReview
    implements UseCase<ProductReview, ProductReviewDraft> {
  const SubmitProductReview(this._repo);
  final ProductReviewRepository _repo;

  @override
  Future<Result<ProductReview>> call(ProductReviewDraft params) =>
      _repo.submit(params);
}

class ToggleReviewHelpful implements UseCase<ProductReview, String> {
  const ToggleReviewHelpful(this._repo);
  final ProductReviewRepository _repo;

  @override
  Future<Result<ProductReview>> call(String params) =>
      _repo.toggleHelpful(params);
}

class ReplyToProductReviewParams {
  const ReplyToProductReviewParams({
    required this.reviewId,
    required this.message,
  });
  final String reviewId;
  final String message;
}

class ReplyToProductReview
    implements UseCase<ProductReview, ReplyToProductReviewParams> {
  const ReplyToProductReview(this._repo);
  final ProductReviewRepository _repo;

  @override
  Future<Result<ProductReview>> call(ReplyToProductReviewParams params) =>
      _repo.reply(params.reviewId, params.message);
}

class GetPendingReviews implements NoParamsUseCase<List<PendingReview>> {
  const GetPendingReviews(this._repo);
  final ProductReviewRepository _repo;

  @override
  Future<Result<List<PendingReview>>> call() => _repo.pendingReviews();
}
