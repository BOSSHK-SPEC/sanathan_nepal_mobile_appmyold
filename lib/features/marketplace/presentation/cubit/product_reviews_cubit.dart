import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/product_review.dart';
import '../../domain/usecases/product_review_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'product_reviews_cubit.freezed.dart';
part 'product_reviews_state.dart';

/// The review list for one product, with its filters.
class ProductReviewsCubit extends AppCubit<ProductReviewsState> {
  ProductReviewsCubit({
    required String productId,
    required GetProductReviews getReviews,
    required GetRatingSummary getSummary,
    required ToggleReviewHelpful toggleHelpful,
    required ReplyToProductReview replyToReview,
  }) : _productId = productId,
       _getReviews = getReviews,
       _getSummary = getSummary,
       _toggleHelpful = toggleHelpful,
       _reply = replyToReview,
       super(const ProductReviewsState());

  final String _productId;
  final GetProductReviews _getReviews;
  final GetRatingSummary _getSummary;
  final ToggleReviewHelpful _toggleHelpful;
  final ReplyToProductReview _reply;

  /// [sort] lets a caller open on a different ordering — the product page's
  /// preview shows the most helpful — without a second round trip.
  Future<void> load({ReviewSort? sort}) async {
    emit(
      state.copyWith(
        sort: sort ?? state.sort,
        reviews: state.reviews.toLoading(),
        summary: state.summary.toLoading(),
      ),
    );

    // The summary counts every review, so it must not be recomputed from a
    // filtered list — it is fetched alongside, not derived from, the rows.
    final (reviews, summary) = await (
      _getReviews(_query),
      _getSummary(_productId),
    ).wait;

    emit(
      state.copyWith(
        reviews: reviews.fold(state.reviews.toFailed, LoadState.loaded),
        summary: summary.fold(state.summary.toFailed, LoadState.loaded),
      ),
    );
  }

  ReviewQuery get _query => ReviewQuery(
    productId: _productId,
    sort: state.sort,
    minRating: state.minRating,
    withPhotosOnly: state.withPhotosOnly,
  );

  Future<void> _refetch() async {
    emit(state.copyWith(reviews: state.reviews.toLoading()));
    final result = await _getReviews(_query);
    emit(
      state.copyWith(
        reviews: result.fold(state.reviews.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> setSort(ReviewSort sort) async {
    if (sort == state.sort) return;
    emit(state.copyWith(sort: sort));
    await _refetch();
  }

  /// Passing the active star again clears it, so the row is a toggle.
  Future<void> setMinRating(int? stars) async {
    emit(state.copyWith(minRating: stars == state.minRating ? null : stars));
    await _refetch();
  }

  Future<void> setWithPhotosOnly(bool value) async {
    emit(state.copyWith(withPhotosOnly: value));
    await _refetch();
  }

  /// Optimistic: the count moves immediately and reverts if the call fails,
  /// because a helpful vote that lags reads as a dead button.
  Future<void> toggleHelpful(String reviewId) async {
    final before = state.all;
    emit(
      state.copyWith(reviews: LoadState.loaded(_flipHelpful(before, reviewId))),
    );

    final result = await _toggleHelpful(reviewId);
    if (result.failureOrNull != null) {
      emit(state.copyWith(reviews: LoadState.loaded(before)));
    }
  }

  List<ProductReview> _flipHelpful(
    List<ProductReview> reviews,
    String reviewId,
  ) => [
    for (final r in reviews)
      if (r.id == reviewId)
        r.copyWith(
          markedHelpful: !r.markedHelpful,
          helpfulCount: r.markedHelpful
              ? r.helpfulCount - 1
              : r.helpfulCount + 1,
        )
      else
        r,
  ];

  Future<bool> reply(String reviewId, String message) async {
    emit(state.copyWith(busyReviewId: reviewId, actionError: null));
    final result = await _reply(
      ReplyToProductReviewParams(reviewId: reviewId, message: message),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(busyReviewId: null, actionError: failure.message));
        return false;
      },
      (updated) {
        emit(
          state.copyWith(
            busyReviewId: null,
            reviews: LoadState.loaded([
              for (final r in state.all)
                if (r.id == updated.id) updated else r,
            ]),
          ),
        );
        return true;
      },
    );
  }
}
