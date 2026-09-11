part of 'work_preferences_cubit.dart';

@freezed
abstract class WorkPreferencesState with _$WorkPreferencesState {
  const WorkPreferencesState._();

  const factory WorkPreferencesState({
    @Default(LoadState.idle()) LoadState<WorkPreferences> prefs,
    String? saveError,
  }) = _WorkPreferencesState;

  WorkPreferences get working => prefs.dataOrNull ?? const WorkPreferences();

  bool get isReady => prefs.dataOrNull != null;
}
