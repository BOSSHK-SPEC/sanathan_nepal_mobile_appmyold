import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_review.freezed.dart';

/// A rating and written review left on a product listing.
///
/// Distinct from [ProductComment], which is a public question on the
/// listing: a comment carries no score and anyone may leave one, a review
/// carries a score and — when [orderId] is set — the weight of an actual
/// purchase. Buyers read the two differently, so the app must not merge them.
@freezed
abstract class ProductReview with _$ProductReview {
  const ProductReview._();

  const factory ProductReview({
    required String id,
    required String productId,
    required String authorName,

    /// 1–5.
    required int rating,
    required String comment,
    required DateTime createdAt,
    String? authorAvatar,

    /// The order this review came from. Its presence is what makes the
    /// review "verified" — never a flag someone can set independently.
    String? orderId,

    /// Photos the buyer attached.
    @Default(<String>[]) List<String> photos,

    /// The seller's public reply, when they have answered.
    String? sellerReply,
    DateTime? repliedAt,

    /// Buyers marking the review useful. Drives the "most helpful" ordering.
    @Default(0) int helpfulCount,
    @Default(false) bool markedHelpful,
  }) = _ProductReview;

  bool get isVerifiedPurchase => orderId != null;

  bool get hasReply => sellerReply != null && sellerReply!.isNotEmpty;

  bool get hasPhotos => photos.isNotEmpty;
}

/// What the buyer submits from the review screen.
@freezed
abstract class ProductReviewDraft with _$ProductReviewDraft {
  const ProductReviewDraft._();

  const factory ProductReviewDraft({
    required String productId,
    @Default(0) int rating,
    @Default('') String comment,
    @Default(<String>[]) List<String> photos,

    /// Set when the review is written from a delivered order.
    String? orderId,
  }) = _ProductReviewDraft;

  /// A star alone is a valid review — demanding prose is how review
  /// prompts get abandoned. Only the score is required.
  bool get isValid => rating >= 1 && rating <= 5;
}

/// Aggregate scores for one product.
///
/// Computed from the reviews rather than stored beside them, so the headline
/// figure and the list underneath can never disagree.
@freezed
abstract class ProductRatingSummary with _$ProductRatingSummary {
  const ProductRatingSummary._();

  const factory ProductRatingSummary({
    @Default(0) double average,
    @Default(0) int total,

    /// Count per star, keyed 1–5.
    @Default(<int, int>{}) Map<int, int> distribution,
    @Default(0) int verifiedCount,
    @Default(0) int withPhotos,
  }) = _ProductRatingSummary;

  factory ProductRatingSummary.from(List<ProductReview> reviews) {
    if (reviews.isEmpty) return const ProductRatingSummary();
    final distribution = <int, int>{for (var i = 1; i <= 5; i++) i: 0};
    var sum = 0;
    for (final r in reviews) {
      sum += r.rating;
      distribution[r.rating] = (distribution[r.rating] ?? 0) + 1;
    }
    return ProductRatingSummary(
      average: sum / reviews.length,
      total: reviews.length,
      distribution: distribution,
      verifiedCount: reviews.where((r) => r.isVerifiedPurchase).length,
      withPhotos: reviews.where((r) => r.hasPhotos).length,
    );
  }

  bool get isEmpty => total == 0;

  /// Share of the total for one star, 0–1 — the width of its bar.
  double shareOf(int star) =>
      total == 0 ? 0 : (distribution[star] ?? 0) / total;
}

/// How a review list is ordered.
enum ReviewSort { recent, helpful, highest, lowest }
