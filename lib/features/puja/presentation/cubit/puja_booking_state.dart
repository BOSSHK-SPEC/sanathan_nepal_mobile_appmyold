part of 'puja_booking_cubit.dart';

@freezed
abstract class PujaBookingState with _$PujaBookingState {
  const PujaBookingState._();

  const factory PujaBookingState({
    @Default(LoadState.idle()) LoadState<PujaBooking> booking,
    @Default(false) bool cancelling,
    String? actionError,
  }) = _PujaBookingState;

  PujaBooking? get value => booking.dataOrNull;
}
