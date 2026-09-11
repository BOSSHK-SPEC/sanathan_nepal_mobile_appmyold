part of 'profile_cubit.dart';

/// State of the profile tab.
@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(LoadState.idle()) LoadState<UserProfile> profile,
    @Default(LoadState.idle()) LoadState<List<FavouriteProduct>> favourites,

    /// Logout / delete-account request; `loaded` means the session ended.
    @Default(LoadState.idle()) LoadState<void> signOut,
  }) = _ProfileState;
}
