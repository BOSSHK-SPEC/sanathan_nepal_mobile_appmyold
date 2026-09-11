import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/usecases/puja_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'puja_booking_cubit.freezed.dart';
part 'puja_booking_state.dart';

/// One booked puja.
class PujaBookingCubit extends AppCubit<PujaBookingState> {
  PujaBookingCubit({
    required String bookingId,
    required GetPujaBooking getBooking,
    required CancelPuja cancel,
  }) : _bookingId = bookingId,
       _get = getBooking,
       _cancel = cancel,
       super(const PujaBookingState());

  final String _bookingId;
  final GetPujaBooking _get;
  final CancelPuja _cancel;

  Future<void> load() async {
    emit(state.copyWith(booking: state.booking.toLoading()));
    final result = await _get(_bookingId);
    emit(
      state.copyWith(
        booking: result.fold(state.booking.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<bool> cancel(String reason) async {
    emit(state.copyWith(cancelling: true, actionError: null));
    final result = await _cancel(
      CancelPujaParams(bookingId: _bookingId, reason: reason),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(cancelling: false, actionError: failure.message));
        return false;
      },
      (updated) {
        emit(
          state.copyWith(cancelling: false, booking: LoadState.loaded(updated)),
        );
        return true;
      },
    );
  }
}
