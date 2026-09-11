import 'package:freezed_annotation/freezed_annotation.dart';

part 'earnings.freezed.dart';

/// One earning line: what the session grossed, what the platform took, and
/// what the astrologer actually keeps.
///
/// Gross, commission and net are stored rather than derived so a historical
/// entry keeps the commission rate that applied at the time.
@freezed
abstract class EarningEntry with _$EarningEntry {
  const EarningEntry._();

  const factory EarningEntry({
    required String id,
    required String clientName,
    required String channel,
    required int minutes,
    required double gross,
    required double commission,
    required DateTime occurredAt,

    /// True once the amount has been paid out.
    @Default(false) bool settled,
  }) = _EarningEntry;

  double get net => gross - commission;

  double get commissionRate => gross == 0 ? 0 : commission / gross;
}

/// Range selector on the earnings screen.
enum EarningsRange { today, week, month, year }

@freezed
abstract class EarningsSummary with _$EarningsSummary {
  const EarningsSummary._();

  const factory EarningsSummary({
    @Default(<EarningEntry>[]) List<EarningEntry> entries,

    /// Earned but not yet paid out.
    @Default(0) double pendingBalance,

    /// Available to withdraw right now.
    @Default(0) double availableBalance,
    @Default(EarningsRange.week) EarningsRange range,
  }) = _EarningsSummary;

  double get gross => entries.fold<double>(0, (sum, e) => sum + e.gross);

  double get commission =>
      entries.fold<double>(0, (sum, e) => sum + e.commission);

  double get net => entries.fold<double>(0, (sum, e) => sum + e.net);

  int get sessions => entries.length;

  int get minutes => entries.fold<int>(0, (sum, e) => sum + e.minutes);

  /// Blended rate across the range — a single number is more useful than
  /// per-entry rates when they vary.
  double get effectiveCommissionRate => gross == 0 ? 0 : commission / gross;
}
