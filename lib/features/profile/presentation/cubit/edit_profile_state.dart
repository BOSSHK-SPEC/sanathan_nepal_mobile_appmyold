part of 'edit_profile_cubit.dart';

/// State of the edit-profile form.
@freezed
abstract class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    /// Profile being edited (loaded from the repository, then the saved copy).
    @Default(LoadState.idle()) LoadState<UserProfile> profile,

    /// Save request; `loaded` carries the persisted profile.
    @Default(LoadState.idle()) LoadState<UserProfile> save,
  }) = _EditProfileState;
}
