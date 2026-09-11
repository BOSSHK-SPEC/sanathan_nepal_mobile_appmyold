import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';

part 'session_summary.freezed.dart';

/// Kind of remedy an astrologer prescribes. Each maps to a different
/// follow-up: a gemstone and a puja are things the marketplace can sell, a
/// mantra and a practice are not.
enum RemedyKind { gemstone, mantra, puja, donation, fasting, practice }

@freezed
abstract class Remedy with _$Remedy {
  const Remedy._();

  const factory Remedy({
    required RemedyKind kind,
    required LocalizedText title,
    required LocalizedText description,

    /// Links into the marketplace when the remedy is purchasable.
    String? productId,
  }) = _Remedy;

  bool get isPurchasable => productId != null;
}

/// What the seeker gets after a session ends.
@freezed
abstract class SessionSummary with _$SessionSummary {
  const SessionSummary._();

  const factory SessionSummary({
    required String consultationId,
    @Default('') String notes,
    @Default(<Remedy>[]) List<Remedy> remedies,

    /// Present once a chat transcript or call recording is available.
    @Default(false) bool hasTranscript,
    String? recordingUrl,
  }) = _SessionSummary;

  bool get isEmpty => notes.isEmpty && remedies.isEmpty;
}
