part of 'business_profile_cubit.dart';

/// State of the business profile page.
///
/// A failed approve/reject moves [business] to `failed` while keeping the
/// current listing as `previous`, so the page can show a snackbar without
/// losing the content.
@freezed
abstract class BusinessProfileState with _$BusinessProfileState {
  const factory BusinessProfileState({
    @Default(LoadState.idle()) LoadState<BusinessProfile> business,
    @Default(false) bool isFollowing,
  }) = _BusinessProfileState;
}
