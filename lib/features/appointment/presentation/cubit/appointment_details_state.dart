part of 'appointment_details_cubit.dart';

/// State of the appointment details page.
@freezed
abstract class AppointmentDetailsState with _$AppointmentDetailsState {
  const factory AppointmentDetailsState({
    @Default(LoadState.idle()) LoadState<Appointment> appointment,
    @Default(LoadState.idle()) LoadState<BookableAstrologer> astrologer,

    /// Slots for the reschedule sheet.
    @Default(LoadState.idle()) LoadState<List<TimeSlot>> slots,

    /// Last cancel / reschedule call (loading while in flight).
    @Default(LoadState.idle()) LoadState<Appointment> action,
  }) = _AppointmentDetailsState;
}
