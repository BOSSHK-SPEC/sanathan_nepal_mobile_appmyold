import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import 'puja_service.dart';

part 'puja_booking.freezed.dart';

enum PujaBookingStatus {
  pendingPayment,
  confirmed,
  inProgress,
  completed,
  cancelled,
}

/// The devotee's details recited during the sankalp.
///
/// A puja performed without these is not the devotee's puja, which is why
/// they are required rather than optional profile decoration.
@freezed
abstract class SankalpDetails with _$SankalpDetails {
  const SankalpDetails._();

  const factory SankalpDetails({
    @Default('') String fullName,
    @Default('') String gotra,
    @Default('') String rashiOrNakshatra,

    /// Others named in the sankalp — family pujas name the household.
    @Default(<String>[]) List<String> familyMembers,
  }) = _SankalpDetails;

  /// Gotra is genuinely optional: many devotees do not know theirs, and the
  /// priest recites a default. Blocking the booking on it would be wrong.
  bool get isValid => fullName.trim().isNotEmpty;
}

@freezed
abstract class PujaBooking with _$PujaBooking {
  const PujaBooking._();

  const factory PujaBooking({
    required String id,
    required String serviceId,
    required String serviceName,
    required PujaMode mode,
    required DateTime scheduledAt,
    required double amount,
    required SankalpDetails sankalp,
    required DateTime bookedAt,
    @Default(PujaBookingStatus.pendingPayment) PujaBookingStatus status,
    @Default(false) bool withSamagri,

    /// The rail the devotee paid through. Core's [PaymentRail] rather
    /// than another feature's payment enum — puja must not depend on
    /// the appointment feature to describe money.
    PaymentRail? paymentRail,

    /// Where the priest goes, for an at-home booking.
    String? address,

    /// Live stream, available shortly before a temple puja begins.
    String? streamUrl,

    /// Photos and the recording, delivered after the ritual.
    @Default(<String>[]) List<String> prasadPhotos,
    String? recordingUrl,
    String? priestName,
    String? cancellationReason,
  }) = _PujaBooking;

  bool get isUpcoming =>
      status == PujaBookingStatus.confirmed ||
      status == PujaBookingStatus.pendingPayment;

  bool get isLive => status == PujaBookingStatus.inProgress;

  bool get canJoin => streamUrl != null && (isLive || _startsSoon);

  /// The stream opens half an hour ahead so devotees can settle in.
  bool get _startsSoon =>
      status == PujaBookingStatus.confirmed &&
      scheduledAt.difference(DateTime.now()) <= const Duration(minutes: 30) &&
      scheduledAt.isAfter(DateTime.now());

  /// Cancelling within a day of the ritual is refused: the priest and the
  /// temple slot are already committed by then.
  bool get canCancel =>
      isUpcoming &&
      scheduledAt.difference(DateTime.now()) > const Duration(hours: 24);

  bool get isDelivered =>
      status == PujaBookingStatus.completed &&
      (prasadPhotos.isNotEmpty || recordingUrl != null);
}
