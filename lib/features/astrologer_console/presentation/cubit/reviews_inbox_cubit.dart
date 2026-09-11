import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'reviews_inbox_cubit.freezed.dart';
part 'reviews_inbox_state.dart';

/// Reviews left for this astrologer, with the right of reply.
class ReviewsInboxCubit extends AppCubit<ReviewsInboxState> {
  ReviewsInboxCubit({
    required GetMyReviews getReviews,
    required ReplyToReview replyToReview,
  }) : _getReviews = getReviews,
       _reply = replyToReview,
       super(const ReviewsInboxState());

  final GetMyReviews _getReviews;
  final ReplyToReview _reply;

  Future<void> load() async {
    emit(state.copyWith(reviews: state.reviews.toLoading()));
    final result = await _getReviews();
    emit(
      state.copyWith(
        reviews: result.fold(state.reviews.toFailed, LoadState.loaded),
      ),
    );
  }

  void setFilter(ReviewFilter filter) => emit(state.copyWith(filter: filter));

  Future<bool> reply(String reviewId, String text) async {
    emit(state.copyWith(replying: state.replying.toLoading()));
    final result = await _reply(
      ReplyToReviewParams(reviewId: reviewId, reply: text),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(replying: state.replying.toFailed(failure)));
        return false;
      },
      (review) async {
        emit(state.copyWith(replying: LoadState.loaded(review)));
        await load();
        return true;
      },
    );
  }
}
