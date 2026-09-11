part of 'pending_reviews_cubit.dart';

@freezed
abstract class PendingReviewsState with _$PendingReviewsState {
  const PendingReviewsState._();

  const factory PendingReviewsState({
    @Default(LoadState.idle()) LoadState<List<PendingReview>> pending,
  }) = _PendingReviewsState;

  List<PendingReview> get all => pending.dataOrNull ?? const [];

  bool get isEmpty => pending.isLoaded && all.isEmpty;
}
