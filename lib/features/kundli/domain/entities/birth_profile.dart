import 'package:freezed_annotation/freezed_annotation.dart';

part 'birth_profile.freezed.dart';

/// Who a saved chart belongs to.
///
/// People cast charts for spouses, children and prospective matches as often
/// as for themselves, so a profile is a first-class saved record rather than
/// something derived from the account.
enum ChartRelation {
  self,
  spouse,
  child,
  parent,
  sibling,
  friend,
  match,
  other,
}

@freezed
abstract class BirthProfile with _$BirthProfile {
  const BirthProfile._();

  const factory BirthProfile({
    required String id,
    required String name,

    /// Local date and time of birth. When [timeUnknown] the time component
    /// is a placeholder and must not be used for house calculations.
    required DateTime birthDateTime,
    required String birthPlace,
    @Default(ChartRelation.self) ChartRelation relation,

    /// Needed for Gun Milan, which is asymmetric between bride and groom.
    @Default(false) bool isFemale,

    /// Without a birth time the ascendant and houses cannot be computed, so
    /// the chart falls back to a Moon-based reading.
    @Default(false) bool timeUnknown,
    DateTime? createdAt,
  }) = _BirthProfile;

  /// A chart with no birth time can still show planets in signs, but not
  /// houses — the UI must not present house positions as reliable.
  bool get supportsHouses => !timeUnknown;
}
