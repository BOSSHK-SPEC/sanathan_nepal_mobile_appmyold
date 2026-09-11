import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// User gender options shown in the profile form.
enum Gender { female, male, other }

/// Access level of the signed-in user.
///
/// * [user] – regular member.
/// * [seller] – has a business listing (may still be pending approval).
/// * [admin] – sees "Admin: Business approvals" in the profile LINKS tab and
///   can approve/reject listings. The mock seed profile is an admin so the
///   moderation flow is demoable without a backend.
/// Primary persisted role on the profile record.
///
/// Runtime authorization uses `AppRole` + `Permission` (core/session);
/// this is only what the profile document stores.
enum UserRole { user, astrologer, seller, admin }

/// Zodiac signs (राशि) selectable in the horoscope dropdown
/// (Figma "Horoscope dropdown" 1337:3023). Kept feature-local so the
/// profile feature does not depend on the horoscope feature.
enum ProfileZodiac {
  aries('Aries', 'मेष', 'aeries 1.png'),
  taurus('Taurus', 'वृष', 'taurus 1.png'),
  gemini('Gemini', 'मिथुन', 'gemini 1.png'),
  cancer('Cancer', 'कर्कट', 'cancer 1.png'),
  leo('Leo', 'सिंह', 'leo 1.png'),
  virgo('Virgo', 'कन्या', 'virgo 1.png'),
  libra('Libra', 'तुला', 'libra 1.png'),
  scorpio('Scorpio', 'वृश्चिक', 'scorpio 1.png'),
  sagittarius('Sagittarius', 'धनु', 'sagittarius 1 (1).png'),
  capricorn('Capricorn', 'मकर', 'capricorn 1.png'),
  aquarius('Aquarius', 'कुम्भ', 'aquarius 1.png'),
  pisces('Pisces', 'मीन', 'pisces 1.png');

  const ProfileZodiac(this.nameEn, this.nameNe, this.asset);

  final String nameEn;
  final String nameNe;

  /// Legacy zodiac PNG in `assets/images/`.
  final String asset;

  /// "Taurus (वृष)" style label used by the dropdown.
  String get combinedLabel => '$nameEn ($nameNe)';

  /// Localised sign name: Devanagari for Nepali/Hindi, English otherwise.
  String localName(String languageCode) =>
      languageCode == 'ne' || languageCode == 'hi' ? nameNe : nameEn;
}

/// The signed-in user's profile (Figma "User Profile Page").
@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String id,
    required String name,
    required String email,
    @Default('') String phone,
    String? avatarUrl,
    Gender? gender,

    /// Date of birth in the region's traditional calendar (Bikram Sambat for
    /// Nepal, Saka for India), `YYYY/MM/DD`. The field keeps its historical
    /// `dobBs` name.
    String? dobBs,

    /// Date of birth in Gregorian calendar, `YYYY/MM/DD`.
    String? dobAd,

    /// Birth time, e.g. `4:12:20 PM`.
    String? birthTime,
    String? birthPlace,
    String? address,
    ProfileZodiac? zodiacSign,
    String? religion,
    String? bio,
    @Default(false) bool verified,

    /// Roles this account holds.
    ///
    /// A set, not a field: someone can be an astrologer *and* run a shop,
    /// and gaining one role must never silently strip another.
    @Default({UserRole.user}) Set<UserRole> roles,
  }) = _UserProfile;

  bool get isAdmin => roles.contains(UserRole.admin);

  bool get isAstrologer => roles.contains(UserRole.astrologer);

  bool get isSeller => roles.contains(UserRole.seller);

  /// Percentage (0–100) of the optional profile fields that are filled.
  int get profileCompletion {
    final fields = <Object?>[
      name.isEmpty ? null : name,
      email.isEmpty ? null : email,
      phone.isEmpty ? null : phone,
      avatarUrl,
      gender,
      dobBs ?? dobAd,
      birthTime,
      birthPlace,
      address,
      zodiacSign,
    ];
    final filled = fields.where((f) => f != null).length;
    return (filled * 100 / fields.length).round();
  }

  bool get isComplete => profileCompletion >= 100;
}
