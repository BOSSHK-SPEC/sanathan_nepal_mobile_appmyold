import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/specialty.dart';

part 'astrologer_profile.freezed.dart';

/// What seekers see on an astrologer's public profile.
///
/// Deliberately separate from [AstrologerApplication]: the application is a
/// point-in-time submission that a reviewer approved and must stay as filed,
/// while this is living content the astrologer maintains afterwards. Seeding
/// it from the application on approval is the only link between them.
@freezed
abstract class AstrologerProfileDraft with _$AstrologerProfileDraft {
  const AstrologerProfileDraft._();

  const factory AstrologerProfileDraft({
    @Default('') String displayName,
    @Default('') String headline,
    @Default('') String about,
    @Default(<Specialty>[]) List<Specialty> specialties,
    @Default(<String>[]) List<String> languageCodes,
    @Default(0) int experienceYears,
    String? avatarRef,
    String? introVideoRef,

    /// Hides the profile from discovery without giving up the account —
    /// what an astrologer taking extended leave actually needs.
    @Default(false) bool hiddenFromSearch,
  }) = _AstrologerProfileDraft;

  /// A headline is what a seeker scans first, so an empty one is not
  /// publishable even though everything else could be.
  bool get isPublishable =>
      displayName.trim().isNotEmpty &&
      headline.trim().isNotEmpty &&
      about.trim().length >= 40 &&
      specialties.isNotEmpty &&
      languageCodes.isNotEmpty;

  /// How complete the profile looks to a seeker, 0-1. Drives the nudge on
  /// the dashboard — a thin profile converts badly.
  double get completeness {
    final checks = [
      displayName.trim().isNotEmpty,
      headline.trim().isNotEmpty,
      about.trim().length >= 40,
      specialties.isNotEmpty,
      languageCodes.isNotEmpty,
      avatarRef != null,
      introVideoRef != null,
    ];
    return checks.where((c) => c).length / checks.length;
  }
}
