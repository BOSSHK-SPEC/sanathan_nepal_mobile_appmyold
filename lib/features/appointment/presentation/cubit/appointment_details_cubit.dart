import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/booking_request.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../../domain/entities/time_slot.dart';
import '../../domain/usecases/cancel_appointment.dart';
import '../../domain/usecases/get_appointment.dart';
import '../../domain/usecases/get_bookable_astrologer.dart';
import '../../domain/usecases/get_time_slots.dart';
import '../../domain/usecases/reschedule_appointment.dart';
import '../../../../core/state/app_cubit.dart';

part 'appointment_details_cubit.freezed.dart';
part 'appointment_details_state.dart';

/// Loads one appointment (+ its astrologer) and handles cancel / reschedule.
class AppointmentDetailsCubit extends AppCubit<AppointmentDetailsState> {
  AppointmentDetailsCubit({
    required GetAppointment getAppointment,
    required GetBookableAstrologer getAstrologer,
    required GetTimeSlots getTimeSlots,
    required CancelAppointment cancelAppointment,
    required RescheduleAppointment rescheduleAppointment,
  }) : _getAppointment = getAppointment,
       _getAstrologer = getAstrologer,
       _getTimeSlots = getTimeSlots,
       _cancel = cancelAppointment,
       _reschedule = rescheduleAppointment,
       super(const AppointmentDetailsState());

  final GetAppointment _getAppointment;
  final GetBookableAstrologer _getAstrologer;
  final GetTimeSlots _getTimeSlots;
  final CancelAppointment _cancel;
  final RescheduleAppointment _reschedule;

  Future<void> load(String id) async {
    emit(
      state.copyWith(
        appointment: state.appointment.toLoading(),
        astrologer: state.astrologer.toLoading(),
      ),
    );
    final result = await _getAppointment(id);
    switch (result) {
      case ResultFailure(:final failure):
        emit(
          state.copyWith(
            appointment: state.appointment.toFailed(failure),
            astrologer: state.astrologer.toFailed(failure),
          ),
        );
      case Success(value: final appointment):
        final astrologer = await _getAstrologer(appointment.astrologerId);
        emit(
          state.copyWith(
            appointment: LoadState.loaded(appointment),
            astrologer: astrologer.fold(state.astrologer.toFailed, LoadState.loaded),
          ),
        );
    }
  }

  /// Cancels the loaded appointment. Resolves with the failure (if any) so
  /// the caller can show feedback; `null` means success.
  Future<Failure?> cancel() async {
    final appointment = state.appointment.dataOrNull;
    if (appointment == null) return null;
    return _runAction(() => _cancel(appointment.id));
  }

  /// Loads slots for the reschedule sheet.
  Future<void> loadSlots(DateTime date) async {
    final appointment = state.appointment.dataOrNull;
    if (appointment == null) return;
    emit(state.copyWith(slots: state.slots.toLoading()));
    final result = await _getTimeSlots(
      SlotQuery(
        astrologerId: appointment.astrologerId,
        date: date,
        // Rescheduling moves the same sitting, so only the booked service's
        // slots are offered — the server refuses a move onto another
        // service's hour.
        serviceId: appointment.service.id,
      ),
    );
    emit(
      state.copyWith(
        slots: result.fold(state.slots.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Moves the loaded appointment to [date] / [slotId]. Resolves with the
  /// failure (if any); `null` means success.
  Future<Failure?> reschedule(DateTime date, String slotId) async {
    final appointment = state.appointment.dataOrNull;
    if (appointment == null) return null;
    return _runAction(
      () => _reschedule(
        RescheduleRequest(
          appointmentId: appointment.id,
          date: date,
          slotId: slotId,
        ),
      ),
    );
  }

  Future<Failure?> _runAction(
    Future<Result<Appointment>> Function() action,
  ) async {
    emit(state.copyWith(action: state.action.toLoading()));
    final result = await action();
    emit(
      state.copyWith(
        action: result.fold(state.action.toFailed, LoadState.loaded),
        appointment: result.fold((_) => state.appointment, LoadState.loaded),
      ),
    );
    return result.failureOrNull;
  }
}
