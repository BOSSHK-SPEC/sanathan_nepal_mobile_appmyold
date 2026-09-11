import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/consult_channel.dart';

part 'console_pricing.freezed.dart';

/// What the astrologer charges.
@freezed
abstract class ConsolePricing with _$ConsolePricing {
  const ConsolePricing._();

  const factory ConsolePricing({
    @Default(<ConsultChannel, double>{})
    Map<ConsultChannel, double> ratePerMinute,

    /// Discounted rate for a seeker's first session, if offered.
    double? firstSessionRate,

    /// Free minutes granted at the start of a first session.
    @Default(0) int freeFirstMinutes,

    /// Platform cut, 0–1. Set by the platform, shown here so the astrologer
    /// can see what a rate change actually earns them.
    @Default(0.2) double commissionRate,
  }) = _ConsolePricing;

  bool offers(ConsultChannel channel) => ratePerMinute.containsKey(channel);

  double? rateFor(ConsultChannel channel) => ratePerMinute[channel];

  /// What the astrologer keeps per minute after commission.
  double netPerMinute(ConsultChannel channel) =>
      (ratePerMinute[channel] ?? 0) * (1 - commissionRate);

  /// The most anyone may charge per minute, in whole currency units.
  ///
  /// A typo guard rather than a judgement about worth: a stray zero turns
  /// ₹100 a minute into ₹1,000, and nobody notices until a seeker is quoted
  /// ₹30,000 for half an hour and assumes the app is broken. The number is a
  /// policy knob — raise it if a real astrologer needs to charge more.
  static const double maxRatePerMinute = 5000;

  bool get isValid =>
      ratePerMinute.isNotEmpty &&
      ratePerMinute.values.every((r) => r > 0 && r <= maxRatePerMinute);
}
