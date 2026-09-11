part of 'reviews_inbox_cubit.dart';

/// Which reviews to show. "Needs reply" is the working view — an astrologer
/// opens this screen to answer, not to browse.
enum ReviewFilter { needsReply, all, critical }

@freezed
abstract class ReviewsInboxState with _$ReviewsInboxState {
  const ReviewsInboxState._();

  const factory ReviewsInboxState({
    @Default(LoadState.idle()) LoadState<List<AstrologerReview>> reviews,
    @Default(LoadState.idle()) LoadState<AstrologerReview> replying,
    @Default(ReviewFilter.needsReply) ReviewFilter filter,
  }) = _ReviewsInboxState;

  List<AstrologerReview> get all => reviews.dataOrNull ?? const [];

  List<AstrologerReview> get visible => switch (filter) {
    ReviewFilter.needsReply => all.where((r) => !r.hasReply).toList(),
    ReviewFilter.critical => all.where((r) => r.rating <= 3).toList(),
    ReviewFilter.all => all,
  };

  int get needsReplyCount => all.where((r) => !r.hasReply).length;

  int get criticalCount => all.where((r) => r.rating <= 3).length;

  double get averageRating => all.isEmpty
      ? 0
      : all.fold<int>(0, (sum, r) => sum + r.rating) / all.length;

  bool get isEmpty => reviews.isLoaded && visible.isEmpty;
}
