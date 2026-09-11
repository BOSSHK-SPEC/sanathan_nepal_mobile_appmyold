part of 'profile_details_cubit.dart';

/// Details Input form: the editable [draft] plus the outcome of [submit].
@freezed
abstract class ProfileDetailsState with _$ProfileDetailsState {
  const ProfileDetailsState._();

  const factory ProfileDetailsState({
    @Default(UserProfileDraft()) UserProfileDraft draft,
    @Default(LoadState.idle()) LoadState<void> submission,
  }) = _ProfileDetailsState;

  bool get isSubmitting => submission.isLoading;
}
