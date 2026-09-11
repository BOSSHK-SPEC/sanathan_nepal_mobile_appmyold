part of 'write_review_cubit.dart';

@freezed
abstract class WriteReviewState with _$WriteReviewState {
  const WriteReviewState._();

  const factory WriteReviewState({
    required String astrologerId,
    String? consultationId,
    @Default(0) int rating,
    @Default('') String comment,
    @Default(<String>{}) Set<String> tags,
    @Default(LoadState.idle()) LoadState<AstrologerReview> submission,
  }) = _WriteReviewState;

  /// A star rating is the only requirement; the comment is optional, which
  /// is what keeps completion rates up.
  /// A review must be attached to a completed consultation.
  ///
  /// The server enforces it — that requirement is what stops competitors and
  /// paid accounts leaving ratings — so submitting without one can only fail.
  /// Checking here means the button is disabled rather than the request being
  /// made and refused.
  bool get canSubmit =>
      rating > 0 && consultationId != null && !submission.isLoading;

  /// True when there is nothing to attach the review to.
  bool get needsConsultation => consultationId == null;

  bool get isSubmitted => submission.isLoaded;
}
