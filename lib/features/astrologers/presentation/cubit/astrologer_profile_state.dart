part of 'astrologer_profile_cubit.dart';

/// Tabs on the public profile.
enum AstrologerProfileTab { about, services, reviews, contact }

@freezed
abstract class AstrologerProfileState with _$AstrologerProfileState {
  const AstrologerProfileState._();

  const factory AstrologerProfileState({
    @Default(LoadState.idle()) LoadState<Astrologer> astrologer,
    @Default(LoadState.idle()) LoadState<List<AstrologerReview>> reviews,

    /// Tracks the report submission separately so a failed report never
    /// blanks the profile behind it.
    @Default(LoadState.idle()) LoadState<bool> reporting,
    @Default(0) int tabIndex,

    /// The completed consultation a review would be attached to, when this
    /// seeker has one with this astrologer.
    String? reviewConsultationId,
  }) = _AstrologerProfileState;

  /// Whether to offer the review button at all.
  ///
  /// The server only accepts a review tied to a completed session, so without
  /// one the button could only ever end in an error.
  bool get canWriteReview => reviewConsultationId != null;

  AstrologerProfileTab get tab =>
      AstrologerProfileTab.values[tabIndex.clamp(
        0,
        AstrologerProfileTab.values.length - 1,
      )];

  List<AstrologerReview> get reviewList => reviews.dataOrNull ?? const [];
}
