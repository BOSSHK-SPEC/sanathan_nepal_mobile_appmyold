import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/usecases/puja_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'my_pujas_cubit.freezed.dart';
part 'my_pujas_state.dart';

/// The devotee's booked pujas.
class MyPujasCubit extends AppCubit<MyPujasState> {
  MyPujasCubit({required GetMyPujas getMyPujas, required CancelPuja cancel})
    : _get = getMyPujas,
      _cancel = cancel,
      super(const MyPujasState());

  final GetMyPujas _get;
  final CancelPuja _cancel;

  Future<void> load() async {
    emit(state.copyWith(bookings: state.bookings.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        bookings: result.fold(state.bookings.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> refresh() => load();

  Future<bool> cancel(String bookingId, String reason) async {
    emit(state.copyWith(busyId: bookingId, actionError: null));
    final result = await _cancel(
      CancelPujaParams(bookingId: bookingId, reason: reason),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(busyId: null, actionError: failure.message));
        return false;
      },
      (updated) {
        emit(
          state.copyWith(
            busyId: null,
            bookings: LoadState.loaded([
              for (final b in state.all)
                if (b.id == updated.id) updated else b,
            ]),
          ),
        );
        return true;
      },
    );
  }
}
