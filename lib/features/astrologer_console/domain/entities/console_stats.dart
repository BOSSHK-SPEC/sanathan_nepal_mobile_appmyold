import 'package:freezed_annotation/freezed_annotation.dart';

part 'console_stats.freezed.dart';

/// Today's numbers on the astrologer dashboard.
@freezed
abstract class DashboardStats with _$DashboardStats {
  const DashboardStats._();

  const factory DashboardStats({
    @Default(0) double earningsToday,
    @Default(0) double earningsThisWeek,
    @Default(0) int sessionsToday,
    @Default(0) int minutesToday,
    @Default(0) int waitingNow,
    @Default(0) double rating,
    @Default(0) int reviewCount,

    /// Share of requests accepted, 0–1. The single number that most affects
    /// how often the platform routes work to an astrologer.
    @Default(0) double acceptanceRate,

    /// Median seconds to accept a request.
    @Default(0) int responseSeconds,

    /// Share of clients who came back, 0–1.
    @Default(0) double repeatRate,

    /// Last seven days of earnings, oldest first — the sparkline series.
    @Default(<double>[]) List<double> earningsTrend,
  }) = _DashboardStats;

  /// Acceptance below this is where platforms usually start throttling
  /// routing, so the dashboard flags it rather than just showing a number.
  static const double acceptanceWarningThreshold = 0.8;

  bool get acceptanceNeedsAttention =>
      acceptanceRate > 0 && acceptanceRate < acceptanceWarningThreshold;

  String get responseLabel => responseSeconds < 60
      ? '${responseSeconds}s'
      : '${(responseSeconds / 60).round()}m';
}

/// Longer-range performance, for the analytics screen.
@freezed
abstract class PerformanceMetrics with _$PerformanceMetrics {
  const PerformanceMetrics._();

  const factory PerformanceMetrics({
    @Default(0) int totalSessions,
    @Default(0) int totalMinutes,
    @Default(0) double totalEarnings,
    @Default(0) double averageRating,
    @Default(0) double acceptanceRate,
    @Default(0) double repeatRate,

    /// Sessions by channel, for the split chart.
    @Default(<String, int>{}) Map<String, int> sessionsByChannel,

    /// Earnings per day over the selected range, oldest first.
    @Default(<double>[]) List<double> earningsSeries,
  }) = _PerformanceMetrics;

  double get averageSessionMinutes =>
      totalSessions == 0 ? 0 : totalMinutes / totalSessions;

  double get averageEarningPerSession =>
      totalSessions == 0 ? 0 : totalEarnings / totalSessions;
}
