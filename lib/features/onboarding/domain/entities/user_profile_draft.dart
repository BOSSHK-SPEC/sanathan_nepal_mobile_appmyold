import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_draft.freezed.dart';

/// Gender options offered on the details form.
enum Gender { male, female, other }

/// Calendar system used to enter/display the date of birth: [bs] = the
/// region's traditional calendar (Bikram Sambat in Nepal, Saka in India),
/// [ad] = Gregorian. Kept as `bs` for persistence compatibility.
enum DateSystem { bs, ad }

/// The twelve zodiac (राशि) signs.
enum ZodiacSign {
  aries,
  taurus,
  gemini,
  cancer,
  leo,
  virgo,
  libra,
  scorpio,
  sagittarius,
  capricorn,
  aquarius,
  pisces,
}

/// Profile information collected during onboarding (Details Input Page).
///
/// Everything is nullable so the form can be built up incrementally; the
/// cubit validates before submission.
@freezed
abstract class UserProfileDraft with _$UserProfileDraft {
  const UserProfileDraft._();

  const factory UserProfileDraft({
    @Default('') String fullName,
    @Default('') String email,

    /// Stored as Gregorian; presentation converts to BS when needed.
    DateTime? dateOfBirth,
    @Default(DateSystem.bs) DateSystem dateSystem,

    /// Minutes since midnight (0–1439) or `null` if unknown.
    int? birthTimeMinutes,
    @Default('') String birthPlace,
    Gender? gender,
    ZodiacSign? zodiacSign,
  }) = _UserProfileDraft;

  bool get isValid =>
      fullName.trim().length >= 2 && dateOfBirth != null && gender != null;
}
