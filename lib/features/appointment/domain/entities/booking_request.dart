import 'package:freezed_annotation/freezed_annotation.dart';

import 'appointment.dart';

part 'booking_request.freezed.dart';

/// Everything needed to book a new appointment (output of the 3-step form).
@freezed
abstract class BookingRequest with _$BookingRequest {
  const factory BookingRequest({
    /// The astrologer being booked.
    ///
    /// Their slots come from the weekly hours they keep in the console, so an
    /// astrologer who is offline can still be booked for later — which is what
    /// the profile now offers instead of a button that led to a 404.
    @Default('') String astrologerId,

    /// Which channel the sitting is held on (`chat` / `voice` / `video`) —
    /// the id of the chosen [SittingOption]. It decides the price, so an empty
    /// one lets the server fall back to the astrologer's chat rate.
    @Default('') String serviceId,
    required int quantity,
    required DateTime date,
    required String slotId,
    required String customerName,
    required String phone,
    required String email,
    required String country,
    required PaymentMethod paymentMethod,
    String? birthPlace,
    DateTime? birthDate,
    String? birthTime,
    String? notes,

    /// Media ids of the files attached in the form (birth chart, receipt).
    String? cheenaMediaId,
    String? receiptMediaId,
  }) = _BookingRequest;
}

/// Parameters for rescheduling an existing appointment.
@freezed
abstract class RescheduleRequest with _$RescheduleRequest {
  const factory RescheduleRequest({
    required String appointmentId,
    required DateTime date,
    required String slotId,
  }) = _RescheduleRequest;
}

/// Parameters for querying available slots.
///
/// [serviceId] is carried for symmetry with the booking request but does not
/// narrow the result: an astrologer publishes one calendar of half hours, and
/// the same half hour cannot be free for chat and taken for video.
@freezed
abstract class SlotQuery with _$SlotQuery {
  const factory SlotQuery({
    required String astrologerId,
    required DateTime date,
    String? serviceId,
  }) = _SlotQuery;
}
