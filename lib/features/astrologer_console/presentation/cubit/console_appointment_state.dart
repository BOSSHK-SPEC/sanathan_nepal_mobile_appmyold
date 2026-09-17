part of 'console_appointment_cubit.dart';

@freezed
abstract class ConsoleAppointmentState with _$ConsoleAppointmentState {
  const factory ConsoleAppointmentState({
    @Default(LoadState.idle()) LoadState<ConsoleAppointment> appointment,
    @Default(false) bool acting,
    ConsoleAppointmentAction? lastAction,
    Failure? actionFailure,
  }) = _ConsoleAppointmentState;
}
