part of 'book_appointment_cubit.dart';

/// Wizard step (Basic Info → Details → Payment); [index] drives the header.
enum BookingStep { basicInfo, details, payment }

/// Calendar / date-entry mode (Figma radio "B.S | A.D" – the traditional
/// side is Bikram Sambat in Nepal and the Saka calendar in India).
enum DateMode { traditional, gregorian }

/// State of the 3-step booking wizard (Basic Info → Details → Payment).
@freezed
abstract class BookAppointmentState with _$BookAppointmentState {
  const BookAppointmentState._();

  const factory BookAppointmentState({
    required BookableAstrologer astrologer,
    required String serviceId,
    required DateTime date,
    @Default(BookingStep.basicInfo) BookingStep step,

    /// Always one. A sitting is a single half hour in one diary: booking it
    /// twice is not a bigger booking, it is the same slot claimed twice, which
    /// the server refuses. Kept in state because the request carries it.
    /// Days in the astrologer's published fortnight that still have a free
    /// slot, so the calendar can dim the ones that never will.
    @Default(<DateTime>[]) List<DateTime> availableDays,

    @Default(1) int quantity,
    @Default(DateMode.traditional) DateMode dateMode,

    /// Slots of the selected [date].
    @Default(LoadState.idle()) LoadState<List<TimeSlot>> slots,
    String? slotId,
    @Default('') String customerName,
    @Default('') String phone,
    @Default('') String email,
    @Default('Nepal') String country,
    @Default('') String birthPlace,
    DateTime? birthDate,
    String? birthTime,
    @Default('') String notes,
    @Default(PaymentMethod.esewa) PaymentMethod paymentMethod,

    /// Media id of the birth chart attached in step 2, once uploaded.
    String? cheenaMediaId,

    /// Media id of the transfer receipt attached in step 3, once uploaded.
    String? receiptMediaId,

    /// Booking call; `loaded` carries the created appointment.
    @Default(LoadState.idle()) LoadState<Appointment> submission,
  }) = _BookAppointmentState;

  SittingOption get service =>
      astrologer.services.firstWhere((s) => s.id == serviceId);

  TimeSlot? get slot =>
      slots.dataOrNull?.where((s) => s.id == slotId).firstOrNull;

  int get total => service.price;

  bool get canProceedFromBasic => slot != null && slot!.available;

  bool get canProceedFromDetails =>
      customerName.trim().isNotEmpty &&
      phone.trim().length >= 7 &&
      isEmailValid;

  /// Email is optional, but an address that is present has to be one the
  /// server will accept — it validates the field, and a rejection there would
  /// surface as "request validation failed" after the last step of a
  /// three-step form, with nothing pointing at the field that caused it.
  bool get isEmailValid {
    final value = email.trim();
    return value.isEmpty || emailPattern.hasMatch(value);
  }

  /// Deliberately permissive: it mirrors what the API accepts rather than
  /// trying to out-guess it, so the app never blocks an address the server
  /// would have taken.
  static final RegExp emailPattern = RegExp(r'^[^@\s]+@[^@\s.]+\.[^@\s]+$');
}
