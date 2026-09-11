import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/consult_channel.dart';

part 'consult_intake.freezed.dart';

/// What the seeker confirms before a session starts.
///
/// Birth details are collected here rather than assumed from the profile,
/// because people consult on behalf of family members and because an
/// unknown birth time changes which techniques the astrologer can use.
@freezed
abstract class ConsultIntake with _$ConsultIntake {
  const ConsultIntake._();

  const factory ConsultIntake({
    required String astrologerId,
    required ConsultChannel channel,
    @Default('') String name,

    /// Gregorian date of birth.
    DateTime? birthDate,

    /// Local time of birth; null when unknown.
    String? birthTime,
    @Default(false) bool birthTimeUnknown,
    @Default('') String birthPlace,
    @Default('') String question,
  }) = _ConsultIntake;

  /// The astrologer needs a name, a date and a place to cast a chart at all.
  bool get isValid =>
      name.trim().isNotEmpty &&
      birthDate != null &&
      birthPlace.trim().isNotEmpty &&
      (birthTimeUnknown || (birthTime != null && birthTime!.isNotEmpty));
}
