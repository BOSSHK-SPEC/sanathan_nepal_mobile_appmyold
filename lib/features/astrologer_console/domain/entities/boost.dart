import 'package:freezed_annotation/freezed_annotation.dart';

part 'boost.freezed.dart';

/// Where a boost places the astrologer.
enum BoostPlacement {
  /// Pinned to the top of the discovery list.
  topOfList,

  /// Featured on the home rail.
  homeRail,

  /// Surfaced to seekers who match the astrologer's specialities.
  targeted,
}

/// A purchasable visibility package.
@freezed
abstract class BoostPlan with _$BoostPlan {
  const BoostPlan._();

  const factory BoostPlan({
    required String id,
    required BoostPlacement placement,
    required int days,
    required double price,

    /// Impressions the platform expects to deliver — a range in reality, so
    /// it is labelled as an estimate wherever it is shown.
    required int estimatedImpressions,
    @Default(false) bool popular,
  }) = _BoostPlan;

  double get pricePerDay => days == 0 ? 0 : price / days;

  /// Cost per thousand impressions — the number that makes two plans with
  /// different durations actually comparable.
  double get estimatedCpm =>
      estimatedImpressions == 0 ? 0 : price / (estimatedImpressions / 1000);
}

/// A purchased boost and how it is performing.
@freezed
abstract class BoostCampaign with _$BoostCampaign {
  const BoostCampaign._();

  const factory BoostCampaign({
    required String id,
    required BoostPlacement placement,
    required DateTime startedAt,
    required DateTime endsAt,
    required double spent,
    @Default(0) int impressions,
    @Default(0) int profileViews,
    @Default(0) int consultations,
  }) = _BoostCampaign;

  bool isActive({DateTime? now}) {
    final at = now ?? DateTime.now();
    return at.isAfter(startedAt) && at.isBefore(endsAt);
  }

  int daysRemaining({DateTime? now}) =>
      endsAt.difference(now ?? DateTime.now()).inDays.clamp(0, 9999);

  double get progress {
    final total = endsAt.difference(startedAt).inSeconds;
    if (total <= 0) return 1;
    final elapsed = DateTime.now().difference(startedAt).inSeconds;
    return (elapsed / total).clamp(0, 1);
  }

  /// Share of impressions that became a profile view.
  double get viewRate => impressions == 0 ? 0 : profileViews / impressions;

  /// Share of profile views that became a paid consultation — the number
  /// that says whether the boost was worth buying.
  double get conversionRate =>
      profileViews == 0 ? 0 : consultations / profileViews;

  /// What each consultation cost in boost spend.
  double get costPerConsultation =>
      consultations == 0 ? 0 : spent / consultations;
}
