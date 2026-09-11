part of 'astrologer_profile_cubit.dart';

@freezed
abstract class AstrologerProfileState with _$AstrologerProfileState {
  const AstrologerProfileState._();

  const factory AstrologerProfileState({
    @Default(LoadState.idle()) LoadState<AstrologerProfileDraft> profile,
    @Default(LoadState.idle()) LoadState<AstrologerProfileDraft> saving,
    AstrologerProfileDraft? draft,
    String? saveError,
  }) = _AstrologerProfileState;

  AstrologerProfileDraft get working =>
      draft ?? profile.dataOrNull ?? const AstrologerProfileDraft();

  bool get hasChanges =>
      profile.dataOrNull != null && working != profile.dataOrNull;

  bool get canSave => working.isPublishable && hasChanges && !saving.isLoading;
}
