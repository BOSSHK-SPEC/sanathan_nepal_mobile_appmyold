part of 'chart_form_cubit.dart';

@freezed
abstract class ChartFormState with _$ChartFormState {
  const ChartFormState._();

  const factory ChartFormState({
    required BirthProfile profile,
    @Default(LoadState.idle()) LoadState<BirthProfile> saving,
  }) = _ChartFormState;

  bool get isEditing => profile.id.isNotEmpty;

  bool get canSubmit =>
      profile.name.trim().isNotEmpty &&
      profile.birthPlace.trim().isNotEmpty &&
      !saving.isLoading;
}
