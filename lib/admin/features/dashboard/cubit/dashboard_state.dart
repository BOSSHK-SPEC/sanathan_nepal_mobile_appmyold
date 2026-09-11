part of 'dashboard_cubit.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    @Default(30) int days,
    @Default(LoadState<FinancialSummary>.idle())
    LoadState<FinancialSummary> summary,
  }) = _DashboardState;

  /// Stale figures are kept visible while a new window loads, so the panel
  /// dims rather than emptying.
  FinancialSummary? get data => summary.dataOrNull;
}
