import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_summary.freezed.dart';

/// Money moved over a window.
///
/// Amounts are **major units** (rupees) as doubles, matching the rest of the
/// app: the wire format is an integer string of paisa, and `ApiMoney.toMajor`
/// converts once at the data-source boundary so `MoneyText` and
/// `RegionFormat.money` render it with the right symbol, lakh/crore grouping
/// and Devanagari digits.
@freezed
abstract class FinancialSummary with _$FinancialSummary {
  const FinancialSummary._();

  const factory FinancialSummary({
    @Default(0) double grossRevenue,
    @Default(0) double consultationRevenue,
    @Default(0) double marketplaceRevenue,
    @Default(0) double walletTopUps,
    @Default(0) double refunds,
    @Default(0) double pendingPayouts,
    @Default(0) int orderCount,
    @Default(0) int consultationCount,

    /// The window this covers, echoed back so a chart can label itself without
    /// the page having to remember what it asked for.
    @Default(30) int days,
  }) = _FinancialSummary;

  /// What actually stayed, once refunds are taken out.
  double get netRevenue => grossRevenue - refunds;

  /// Share of gross that came back as refunds, 0 when nothing was earned.
  double get refundRate => grossRevenue <= 0 ? 0 : refunds / grossRevenue;

  /// Mean order value, 0 when there were no orders — a divide-by-zero here
  /// would render as `NaN` on the dashboard.
  double get averageOrderValue =>
      orderCount <= 0 ? 0 : marketplaceRevenue / orderCount;
}
