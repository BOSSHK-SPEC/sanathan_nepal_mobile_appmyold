import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/astrologer_review.dart';
import '../../domain/usecases/submit_astrologer_review.dart';
import '../../../../core/state/app_cubit.dart';

part 'write_review_cubit.freezed.dart';
part 'write_review_state.dart';

/// Star rating, tags and comment for a new review.
class WriteReviewCubit extends AppCubit<WriteReviewState> {
  WriteReviewCubit({
    required String astrologerId,
    required SubmitAstrologerReview submitReview,
    String? consultationId,
  }) : _submitReview = submitReview,
       super(
         WriteReviewState(
           astrologerId: astrologerId,
           consultationId: consultationId,
         ),
       );

  final SubmitAstrologerReview _submitReview;

  /// Tag vocabulary offered alongside the stars. Kept as stable keys; the
  /// strings class turns them into display text per language.
  static const List<String> tagKeys = [
    'accurate',
    'patient',
    'knowledgeable',
    'honest',
    'quick',
    'practical',
  ];

  void setRating(int rating) =>
      emit(state.copyWith(rating: rating, submission: const LoadState.idle()));

  void setComment(String comment) => emit(state.copyWith(comment: comment));

  void toggleTag(String tag) {
    final next = {...state.tags};
    if (!next.remove(tag)) next.add(tag);
    emit(state.copyWith(tags: next));
  }

  Future<AstrologerReview?> submit() async {
    if (!state.canSubmit) return null;
    emit(state.copyWith(submission: state.submission.toLoading()));
    final result = await _submitReview(
      ReviewDraft(
        astrologerId: state.astrologerId,
        rating: state.rating,
        comment: state.comment.trim(),
        tags: state.tags.toList(),
        consultationId: state.consultationId,
      ),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(submission: state.submission.toFailed(failure)));
        return null;
      },
      (review) {
        emit(state.copyWith(submission: LoadState.loaded(review)));
        return review;
      },
    );
  }
}
