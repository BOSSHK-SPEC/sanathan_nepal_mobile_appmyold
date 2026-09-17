part of 'console_appointments_cubit.dart';

@freezed
abstract class ConsoleAppointmentsState with _$ConsoleAppointmentsState {
  const ConsoleAppointmentsState._();

  const factory ConsoleAppointmentsState({
    @Default(AppointmentScope.upcoming) AppointmentScope scope,
    @Default(LoadState.idle()) LoadState<List<ConsoleAppointment>> upcoming,
    @Default(LoadState.idle()) LoadState<List<ConsoleAppointment>> past,
  }) = _ConsoleAppointmentsState;

  LoadState<List<ConsoleAppointment>> slice(AppointmentScope scope) =>
      scope == AppointmentScope.upcoming ? upcoming : past;

  /// The tab being shown.
  LoadState<List<ConsoleAppointment>> get current => slice(scope);
}
