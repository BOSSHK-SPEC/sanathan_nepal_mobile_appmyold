import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/console_appointment.dart';
import '../../domain/usecases/console_usecases.dart';

part 'console_appointment_cubit.freezed.dart';
part 'console_appointment_state.dart';

/// What the astrologer last did to the appointment, for the confirmation.
enum ConsoleAppointmentAction { completed, noShow, cancelled }

/// One appointment: the client's details, and closing it out.
///
/// An action never replaces what is on screen with an error — the appointment
/// stays, and [ConsoleAppointmentState.actionFailure] carries what went wrong.
class ConsoleAppointmentCubit extends AppCubit<ConsoleAppointmentState> {
  ConsoleAppointmentCubit({
    required this.id,
    required GetConsoleAppointment getAppointment,
    required RecordAppointmentOutcome recordOutcome,
    required CancelConsoleAppointment cancelAppointment,
  }) : _getAppointment = getAppointment,
       _recordOutcome = recordOutcome,
       _cancelAppointment = cancelAppointment,
       super(const ConsoleAppointmentState());

  final String id;
  final GetConsoleAppointment _getAppointment;
  final RecordAppointmentOutcome _recordOutcome;
  final CancelConsoleAppointment _cancelAppointment;

  Future<void> load() async {
    emit(state.copyWith(appointment: state.appointment.toLoading()));
    final result = await _getAppointment(id);
    emit(
      state.copyWith(
        appointment: result.fold(state.appointment.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> complete() => _act(
    () =>
        _recordOutcome(RecordAppointmentOutcomeParams(id: id, completed: true)),
    ConsoleAppointmentAction.completed,
  );

  Future<void> markNoShow() => _act(
    () => _recordOutcome(
      RecordAppointmentOutcomeParams(id: id, completed: false),
    ),
    ConsoleAppointmentAction.noShow,
  );

  Future<void> cancel(String reason) => _act(
    () => _cancelAppointment(
      CancelConsoleAppointmentParams(id: id, reason: reason.trim()),
    ),
    ConsoleAppointmentAction.cancelled,
  );

  Future<void> _act(
    Future<Result<ConsoleAppointment>> Function() call,
    ConsoleAppointmentAction action,
  ) async {
    // One action at a time: a double tap must not cancel and complete.
    if (state.acting) return;
    emit(state.copyWith(acting: true, lastAction: null, actionFailure: null));
    final result = await call();
    emit(
      result.fold(
        (failure) => state.copyWith(acting: false, actionFailure: failure),
        (updated) => state.copyWith(
          acting: false,
          appointment: LoadState.loaded(updated),
          lastAction: action,
        ),
      ),
    );
  }
}
