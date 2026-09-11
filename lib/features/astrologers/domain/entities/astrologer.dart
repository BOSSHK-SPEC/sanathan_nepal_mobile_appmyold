import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';
import 'consult_channel.dart';
import 'specialty.dart';

part 'astrologer.freezed.dart';

/// A bookable astrologer as shown in discovery and on the public profile.
///
/// Distinct from the appointment feature's `BookableAstrologer`, which models a
/// scheduled-appointment vendor. This is the live-consultation supply side:
/// per-minute rates, presence and a queue.
@freezed
abstract class Astrologer with _$Astrologer {
  const Astrologer._();

  const factory Astrologer({
    required String id,
    required LocalizedText name,

    /// One-line practice summary, e.g. "Vedic astrology & Vaastu".
    required LocalizedText headline,
    required LocalizedText about,
    required List<Specialty> specialties,

    /// BCP-47 codes the astrologer consults in (`ne`, `en`, `hi`).
    required List<String> languageCodes,
    required int experienceYears,
    required double rating,
    required int reviewCount,

    /// Per-minute price by channel. A missing channel is not offered.
    required Map<ConsultChannel, double> ratePerMinute,
    @Default(0) int consultationCount,
    @Default(0) int followers,

    /// Share of reviewers who would recommend, 0–100.
    @Default(0) int recommendedPercent,
    @Default(false) bool isOnline,
    @Default(false) bool isVerified,

    /// People currently waiting. Only meaningful while [isOnline].
    @Default(0) int queueLength,
    @Default(false) bool isFollowing,
    String? avatarAsset,
    LocalizedText? location,

    /// star (1–5) → number of reviews with that star.
    @Default({}) Map<int, int> ratingBreakdown,
  }) = _Astrologer;

  /// Channels this astrologer actually offers.
  List<ConsultChannel> get channels =>
      ConsultChannel.values.where(ratePerMinute.containsKey).toList();

  double? rateFor(ConsultChannel channel) => ratePerMinute[channel];

  /// Cheapest per-minute rate — the "from ₹X/min" price on listing cards.
  double get lowestRate => ratePerMinute.values.isEmpty
      ? 0
      : ratePerMinute.values.reduce((a, b) => a < b ? a : b);

  /// Online but with people ahead — the card shows a wait instead of "free".
  bool get isBusy => isOnline && queueLength > 0;

  /// Rough wait in minutes, assuming an average session length.
  int get estimatedWaitMinutes => queueLength * 8;
}
