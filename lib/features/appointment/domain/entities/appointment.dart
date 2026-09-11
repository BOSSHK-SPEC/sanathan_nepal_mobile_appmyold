import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import '../../../../core/utils/localized_text.dart';
import 'sitting_option.dart';
import 'time_slot.dart';

part 'appointment.freezed.dart';

/// Lifecycle of an appointment.
@JsonEnum(valueField: 'code')
enum AppointmentStatus {
  booked('booked'),
  completed('completed'),
  cancelled('cancelled');

  const AppointmentStatus(this.code);
  final String code;

  static AppointmentStatus fromCode(String? code) => AppointmentStatus.values
      .firstWhere((s) => s.code == code, orElse: () => booked);
}

/// How the customer pays. Region payment rails ([PaymentRail]) map onto
/// this persisted enum: Nepal offers eSewa / Khalti / bank transfer / cash,
/// India offers UPI / card / net banking / cash. `paypal` is kept only so
/// legacy JSON still decodes (it maps to a bank transfer).
@JsonEnum(valueField: 'code')
enum PaymentMethod {
  esewa('esewa', PaymentRail.esewa),
  khalti('khalti', PaymentRail.khalti),
  bank('bank', PaymentRail.bankTransfer),
  paypal('paypal', PaymentRail.bankTransfer),
  upi('upi', PaymentRail.upi),
  card('card', PaymentRail.card),
  netBanking('net_banking', PaymentRail.netBanking),
  cash('cash', PaymentRail.cashOnDelivery);

  const PaymentMethod(this.code, this.rail);
  final String code;

  /// Region-level payment rail this method belongs to.
  final PaymentRail rail;

  static PaymentMethod fromCode(String? code) => PaymentMethod.values
      .firstWhere((m) => m.code == code, orElse: () => esewa);

  /// Payment method offered for a region [PaymentRail].
  static PaymentMethod fromRail(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => esewa,
    PaymentRail.khalti => khalti,
    PaymentRail.bankTransfer => bank,
    PaymentRail.upi => upi,
    PaymentRail.card => card,
    PaymentRail.netBanking => netBanking,
    PaymentRail.cashOnDelivery => cash,
  };

  /// Whether the payer must transfer to a bank account (instructions shown).
  bool get needsBankDetails => rail == PaymentRail.bankTransfer;
}

/// A booked appointment with a [BookableAstrologer].
@freezed
abstract class Appointment with _$Appointment {
  const Appointment._();

  const factory Appointment({
    required String id,
    required String astrologerId,
    required LocalizedText astrologerName,
    required SittingOption service,
    required int quantity,

    /// Gregorian date of the appointment (the traditional-calendar date is
    /// derived in presentation from the active region).
    required DateTime date,
    required TimeSlot slot,
    required AppointmentStatus status,
    required String customerName,
    required String phone,
    required String email,
    required String country,
    required PaymentMethod paymentMethod,
    required DateTime createdAt,
    String? birthPlace,
    DateTime? birthDate,

    /// "HH:mm" 24h.
    String? birthTime,
    String? notes,

    /// Media id of the birth chart the customer already had, uploaded while
    /// booking so the astrologer can read it before the sitting.
    String? cheenaMediaId,

    /// Media id of the transfer receipt, for the rails that are settled by
    /// hand rather than through a gateway.
    String? receiptMediaId,
  }) = _Appointment;

  int get totalAmount => service.price * quantity;

  /// Whether the customer attached anything to this booking.
  bool get hasAttachments => cheenaMediaId != null || receiptMediaId != null;

  DateTime get startDateTime =>
      DateTime(date.year, date.month, date.day, slot.hour, slot.minute);

  bool get isUpcoming =>
      status == AppointmentStatus.booked &&
      startDateTime.isAfter(DateTime.now());
}
