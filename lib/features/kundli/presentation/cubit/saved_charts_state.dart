part of 'saved_charts_cubit.dart';

@freezed
abstract class SavedChartsState with _$SavedChartsState {
  const SavedChartsState._();

  const factory SavedChartsState({
    @Default(LoadState.idle()) LoadState<List<BirthProfile>> profiles,
  }) = _SavedChartsState;

  List<BirthProfile> get charts => profiles.dataOrNull ?? const [];

  bool get isEmpty => profiles.isLoaded && charts.isEmpty;

  /// Matching needs two charts, so the entry point is hidden until then.
  bool get canMatch => charts.length >= 2;
}
