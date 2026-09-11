import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/repositories/product_review_repository.dart';
import '../../domain/usecases/product_review_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'pending_reviews_cubit.freezed.dart';
part 'pending_reviews_state.dart';

/// Delivered purchases the buyer has not reviewed yet.
class PendingReviewsCubit extends AppCubit<PendingReviewsState> {
  PendingReviewsCubit({required GetPendingReviews getPending})
    : _get = getPending,
      super(const PendingReviewsState());

  final GetPendingReviews _get;

  Future<void> load() async {
    emit(state.copyWith(pending: state.pending.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        pending: result.fold(state.pending.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> refresh() => load();
}
