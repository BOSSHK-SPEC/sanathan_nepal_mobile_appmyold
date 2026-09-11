import '../../../../core/utils/result.dart';
import '../entities/product_review.dart';

/// Ratings and written reviews on marketplace listings.
///
/// Its own repository rather than more methods on [ProductRepository]:
/// listings and opinions about them change for different reasons and are
/// read by different screens.
abstract interface class ProductReviewRepository {
  Future<Result<List<ProductReview>>> reviews(
    String productId, {
    ReviewSort sort,
    int? minRating,
    bool withPhotosOnly,
  });

  Future<Result<ProductRatingSummary>> summary(String productId);

  Future<Result<ProductReview>> submit(ProductReviewDraft draft);

  /// Marks a review useful, or takes the mark back.
  Future<Result<ProductReview>> toggleHelpful(String reviewId);

  /// The seller's single public reply. Fails when one already exists.
  Future<Result<ProductReview>> reply(String reviewId, String message);

  /// Delivered order lines the buyer has not reviewed yet — what the
  /// "rate your purchase" prompt is built from.
  Future<Result<List<PendingReview>>> pendingReviews();
}

/// A delivered item still waiting on its review.
class PendingReview {
  const PendingReview({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.deliveredAt,
    this.image,
  });

  final String orderId;
  final String productId;
  final String productName;
  final DateTime deliveredAt;
  final String? image;
}
