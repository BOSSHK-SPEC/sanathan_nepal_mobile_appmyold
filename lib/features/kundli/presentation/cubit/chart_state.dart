part of 'chart_cubit.dart';

/// North Indian charts are diamond-shaped with fixed *houses*; South Indian
/// charts are a fixed grid of *signs*. Readers are fluent in one or the
/// other, so this is a preference, not a detail.
enum ChartStyle { north, south }

enum ChartTab { chart, planets, dasha, dosha }

@freezed
abstract class ChartState with _$ChartState {
  const ChartState._();

  const factory ChartState({
    @Default(LoadState.idle()) LoadState<KundliChart> chart,
    @Default(LoadState.idle()) LoadState<List<DashaPeriod>> dashas,
    @Default(LoadState.idle()) LoadState<List<DoshaReading>> doshas,
    @Default(ChartStyle.north) ChartStyle style,
    @Default(0) int tabIndex,
    String? expandedDasha,
  }) = _ChartState;

  KundliChart? get kundli => chart.dataOrNull;

  List<DashaPeriod> get dashaList => dashas.dataOrNull ?? const [];

  List<DoshaReading> get doshaList => doshas.dataOrNull ?? const [];

  List<DoshaReading> get activeDoshas =>
      doshaList.where((d) => d.isPresent).toList();

  ChartTab get tab =>
      ChartTab.values[tabIndex.clamp(0, ChartTab.values.length - 1)];

  DashaPeriod? get currentDasha {
    for (final period in dashaList) {
      if (period.isCurrent()) return period;
    }
    return null;
  }
}
