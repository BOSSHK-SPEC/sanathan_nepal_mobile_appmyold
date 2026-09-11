part of 'panchanga_cubit.dart';

/// Which suva-sait table is open on the Panchanga page
/// ("मासिक शुभ साइत" / "वार्षिक शुभ साइत").
enum SaitView { monthly, yearly }

/// UI state of the panchanga page / home sections.
@freezed
abstract class PanchangaState with _$PanchangaState {
  const PanchangaState._();

  const factory PanchangaState({
    /// Civil day currently displayed (local midnight).
    required DateTime date,

    /// Traditional (B.S. / Saka) year and month browsed in the sait tables.
    /// Follow [date] until the user navigates with prev/next.
    required int saitYear,
    required int saitMonth,
    @Default(LoadState.idle()) LoadState<Panchanga> panchanga,

    /// Auspicious-timing categories (loaded once, independent of [date]).
    @Default(LoadState.idle()) LoadState<List<SuvaSait>> saits,
    @Default(SaitView.monthly) SaitView saitView,
  }) = _PanchangaState;

  bool get isLoading => panchanga.isLoading;

  List<SuvaSait> get allSaits => saits.dataOrNull ?? const <SuvaSait>[];

  /// Saits that fall on [date].
  List<SuvaSait> get saitsToday =>
      allSaits.where((s) => s.isOn(date)).toList(growable: false);
}
