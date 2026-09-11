import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/entities/puja_service.dart';
import '../../domain/repositories/puja_repository.dart';
import '../../domain/usecases/puja_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'book_puja_cubit.freezed.dart';
part 'book_puja_state.dart';

/// Booking one puja: mode, date and muhurta, sankalp, then payment.
class BookPujaCubit extends AppCubit<BookPujaState> {
  BookPujaCubit({
    required String serviceId,
    required GetPujaService getService,
    required GetPujaTimes getTimes,
    required BookPuja bookPuja,
  }) : _serviceId = serviceId,
       _getService = getService,
       _getTimes = getTimes,
       _book = bookPuja,
       super(BookPujaState(date: _tomorrow()));

  final String _serviceId;
  final GetPujaService _getService;
  final GetPujaTimes _getTimes;
  final BookPuja _book;

  /// A puja is prepared for, not walked into — the calendar opens tomorrow.
  static DateTime _tomorrow() {
    final now = DateTime.now().add(const Duration(days: 1));
    return DateTime(now.year, now.month, now.day);
  }

  Future<void> load() async {
    emit(state.copyWith(service: state.service.toLoading()));
    final result = await _getService(_serviceId);
    result.fold(
      (failure) =>
          emit(state.copyWith(service: state.service.toFailed(failure))),
      (service) => emit(
        state.copyWith(
          service: LoadState.loaded(service),
          // Preselect the only mode when a puja offers just one, so the
          // devotee is not asked a question with a single answer.
          mode:
              state.mode ??
              (service.modes.length == 1 ? service.modes.first : null),
        ),
      ),
    );
    await loadTimes();
  }

  Future<void> loadTimes() async {
    emit(state.copyWith(times: state.times.toLoading(), selectedTime: null));
    final result = await _getTimes(
      PujaTimesParams(serviceId: _serviceId, date: state.date),
    );
    emit(
      state.copyWith(
        times: result.fold(state.times.toFailed, LoadState.loaded),
      ),
    );
  }

  void selectMode(PujaMode mode) =>
      emit(state.copyWith(mode: mode, bookingError: null));

  Future<void> selectDate(DateTime date) async {
    emit(state.copyWith(date: DateTime(date.year, date.month, date.day)));
    await loadTimes();
  }

  void selectTime(DateTime time) =>
      emit(state.copyWith(selectedTime: time, bookingError: null));

  void setSamagri(bool value) => emit(state.copyWith(withSamagri: value));

  void setSankalp(SankalpDetails sankalp) =>
      emit(state.copyWith(sankalp: sankalp, bookingError: null));

  void setAddress(String address) =>
      emit(state.copyWith(address: address, bookingError: null));

  void selectRail(PaymentRail rail) => emit(state.copyWith(rail: rail));

  Future<PujaBooking?> confirm() async {
    final service = state.service.dataOrNull;
    final mode = state.mode;
    final time = state.selectedTime;
    final rail = state.rail;
    if (service == null || mode == null || time == null || rail == null) {
      return null;
    }

    emit(
      state.copyWith(booking: state.booking.toLoading(), bookingError: null),
    );
    final result = await _book(
      PujaBookingRequest(
        serviceId: service.id,
        mode: mode,
        scheduledAt: time,
        sankalp: state.sankalp,
        withSamagri: state.withSamagri,
        paymentRail: rail,
        address: mode == PujaMode.atHome ? state.address : null,
      ),
    );
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            booking: state.booking.toFailed(failure),
            bookingError: failure.message,
          ),
        );
        return null;
      },
      (booking) {
        emit(state.copyWith(booking: LoadState.loaded(booking)));
        return booking;
      },
    );
  }
}
