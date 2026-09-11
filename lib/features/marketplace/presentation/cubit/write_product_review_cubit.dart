import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/product_review.dart';
import '../../domain/usecases/product_review_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'write_product_review_cubit.freezed.dart';
part 'write_product_review_state.dart';

/// Writing one review.
class WriteProductReviewCubit extends AppCubit<WriteProductReviewState> {
  WriteProductReviewCubit({
    required String productId,
    required SubmitProductReview submitReview,
    String? orderId,
  }) : _submit = submitReview,
       super(
         WriteProductReviewState(
           draft: ProductReviewDraft(productId: productId, orderId: orderId),
         ),
       );

  final SubmitProductReview _submit;

  void setRating(int rating) => emit(
    state.copyWith(
      draft: state.draft.copyWith(rating: rating),
      submitError: null,
    ),
  );

  void setComment(String comment) =>
      emit(state.copyWith(draft: state.draft.copyWith(comment: comment)));

  /// No picker plugin is wired yet; a deterministic ref keeps the flow
  /// walkable without pretending a real upload happened.
  /// Attaches a photo the reviewer has already uploaded.
  void addPhoto(String url) {
    if (url.isEmpty || state.draft.photos.contains(url)) return;
    emit(
      state.copyWith(
        draft: state.draft.copyWith(photos: [...state.draft.photos, url]),
      ),
    );
  }

  void removePhoto(String ref) => emit(
    state.copyWith(
      draft: state.draft.copyWith(
        photos: [
          for (final p in state.draft.photos)
            if (p != ref) p,
        ],
      ),
    ),
  );

  Future<bool> submit() async {
    emit(
      state.copyWith(
        submission: state.submission.toLoading(),
        submitError: null,
      ),
    );
    final result = await _submit(state.draft);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            submission: state.submission.toFailed(failure),
            submitError: failure.message,
          ),
        );
        return false;
      },
      (review) {
        emit(state.copyWith(submission: LoadState.loaded(review)));
        return true;
      },
    );
  }
}
