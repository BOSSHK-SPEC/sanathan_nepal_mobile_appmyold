part of 'write_product_review_cubit.dart';

@freezed
abstract class WriteProductReviewState with _$WriteProductReviewState {
  const WriteProductReviewState._();

  const factory WriteProductReviewState({
    required ProductReviewDraft draft,
    @Default(LoadState.idle()) LoadState<ProductReview> submission,
    String? submitError,
  }) = _WriteProductReviewState;

  bool get canSubmit => draft.isValid && !submission.isLoading;

  bool get isSubmitting => submission.isLoading;
}
