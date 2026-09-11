part of 'book_puja_cubit.dart';

@freezed
abstract class BookPujaState with _$BookPujaState {
  const BookPujaState._();

  const factory BookPujaState({
    required DateTime date,
    @Default(LoadState.idle()) LoadState<PujaService> service,
    @Default(LoadState.idle()) LoadState<List<DateTime>> times,
    @Default(LoadState.idle()) LoadState<PujaBooking> booking,
    @Default(SankalpDetails()) SankalpDetails sankalp,
    @Default(false) bool withSamagri,
    @Default('') String address,
    PujaMode? mode,
    DateTime? selectedTime,
    PaymentRail? rail,
    String? bookingError,
  }) = _BookPujaState;

  List<DateTime> get slots => times.dataOrNull ?? const [];

  double get total {
    final s = service.dataOrNull;
    final m = mode;
    if (s == null || m == null) return 0;
    return s.priceFor(mode: m, withSamagri: withSamagri);
  }

  bool get needsAddress => mode == PujaMode.atHome;

  /// Everything required before the booking can be sent. Mirrors the data
  /// source's rules so the button and the server agree.
  bool get canConfirm =>
      service.dataOrNull != null &&
      mode != null &&
      selectedTime != null &&
      rail != null &&
      sankalp.isValid &&
      (!needsAddress || address.trim().isNotEmpty) &&
      !booking.isLoading;
}
