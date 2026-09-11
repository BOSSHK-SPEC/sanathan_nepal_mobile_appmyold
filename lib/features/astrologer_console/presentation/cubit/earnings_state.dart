part of 'earnings_cubit.dart';

@freezed
abstract class EarningsState with _$EarningsState {
  const EarningsState._();

  const factory EarningsState({
    @Default(LoadState.idle()) LoadState<EarningsSummary> summary,
    @Default(LoadState.idle()) LoadState<PerformanceMetrics> performance,
    @Default(EarningsRange.week) EarningsRange range,

    /// Null once loaded means no payout account has been added yet, which is
    /// different from "not loaded", hence the explicit flag.
    PayoutAccount? account,
    @Default(false) bool accountLoaded,
  }) = _EarningsState;

  EarningsSummary get earnings => summary.dataOrNull ?? const EarningsSummary();

  PerformanceMetrics get metrics =>
      performance.dataOrNull ?? const PerformanceMetrics();

  bool get needsPayoutAccount => accountLoaded && account == null;

  bool get canWithdraw => account != null && earnings.availableBalance > 0;
}
