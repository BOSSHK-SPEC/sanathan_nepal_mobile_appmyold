part of 'schedule_cubit.dart';

@freezed
abstract class ScheduleState with _$ScheduleState {
  const ScheduleState._();

  const factory ScheduleState({
    @Default(LoadState.idle()) LoadState<Availability> availability,
    @Default(LoadState.idle()) LoadState<Availability> saving,

    /// Edited copy; only [ScheduleCubit.save] promotes it.
    Availability? draft,
    String? saveError,
  }) = _ScheduleState;

  Availability get working =>
      draft ?? availability.dataOrNull ?? const Availability();

  bool get hasChanges =>
      availability.dataOrNull != null && working != availability.dataOrNull;
}
