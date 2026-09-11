import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/astrologer_review.dart';
import '../../domain/usecases/get_astrologer.dart';
import '../../domain/usecases/get_astrologer_reviews.dart';
import '../../domain/usecases/report_astrologer.dart';
import '../../domain/usecases/reviewable_consultation.dart';
import '../../domain/usecases/toggle_follow_astrologer.dart';
import '../../../../core/state/app_cubit.dart';

part 'astrologer_profile_cubit.freezed.dart';
part 'astrologer_profile_state.dart';

/// Public astrologer profile: header, about, reviews, follow and report.
class AstrologerProfileCubit extends AppCubit<AstrologerProfileState> {
  AstrologerProfileCubit({
    required String astrologerId,
    required GetAstrologer getAstrologer,
    required GetAstrologerReviews getReviews,
    required ToggleFollowAstrologer toggleFollow,
    required ReportAstrologer report,
    required GetReviewableConsultation reviewableConsultation,
  }) : _id = astrologerId,
       _getAstrologer = getAstrologer,
       _getReviews = getReviews,
       _toggleFollow = toggleFollow,
       _report = report,
       _reviewable = reviewableConsultation,
       super(const AstrologerProfileState());

  final String _id;
  final GetAstrologer _getAstrologer;
  final GetAstrologerReviews _getReviews;
  final ToggleFollowAstrologer _toggleFollow;
  final ReportAstrologer _report;
  final GetReviewableConsultation _reviewable;

  Future<void> load() async {
    emit(
      state.copyWith(
        astrologer: state.astrologer.toLoading(),
        reviews: state.reviews.toLoading(),
      ),
    );
    // Kicked off together, folded separately: a reviews failure must not
    // blank the profile, and vice versa.
    final astrologerFuture = _getAstrologer(_id);
    final reviewsFuture = _getReviews(_id);
    // Whether this seeker may review at all. Folded separately again: not
    // being able to review is an ordinary state, not a reason to fail the
    // page, so a lookup that errors simply hides the button.
    final reviewableFuture = _reviewable(_id);
    final astrologer = await astrologerFuture;
    final reviews = await reviewsFuture;
    final reviewable = await reviewableFuture;
    emit(
      state.copyWith(
        astrologer: astrologer.fold(
          state.astrologer.toFailed,
          LoadState.loaded,
        ),
        reviews: reviews.fold(state.reviews.toFailed, LoadState.loaded),
        // A failed lookup leaves it null, which reads as "cannot review" —
        // the safe default, since the server would refuse anyway.
        reviewConsultationId: reviewable.valueOrNull,
      ),
    );
  }

  void selectTab(int index) => emit(state.copyWith(tabIndex: index));

  Future<void> toggleFollow() async {
    final current = state.astrologer.dataOrNull;
    if (current == null) return;
    emit(
      state.copyWith(
        astrologer: LoadState.loaded(
          current.copyWith(isFollowing: !current.isFollowing),
        ),
      ),
    );
    final result = await _toggleFollow(current.id);
    result.fold(
      (_) => emit(state.copyWith(astrologer: LoadState.loaded(current))),
      (following) => emit(
        state.copyWith(
          astrologer: LoadState.loaded(
            current.copyWith(isFollowing: following),
          ),
        ),
      ),
    );
  }

  Future<bool> report(ReportDraft draft) async {
    emit(state.copyWith(reporting: state.reporting.toLoading()));
    final result = await _report(draft);
    return result.fold(
      (failure) {
        emit(state.copyWith(reporting: state.reporting.toFailed(failure)));
        return false;
      },
      (_) {
        emit(state.copyWith(reporting: const LoadState.loaded(true)));
        return true;
      },
    );
  }
}
