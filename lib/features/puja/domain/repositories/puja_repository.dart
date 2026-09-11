import '../../../../core/region/region.dart';
import '../../../../core/utils/result.dart';
import '../entities/puja_booking.dart';
import '../entities/puja_service.dart';

/// Online puja bookings: the catalogue, available times and the devotee's
/// own bookings.
abstract interface class PujaRepository {
  Future<Result<List<PujaService>>> catalogue({PujaPurpose? purpose});

  Future<Result<PujaService>> service(String serviceId);

  /// Muhurta-aligned start times on [date] for [serviceId]. Times are not a
  /// free calendar: a ritual is performed at an auspicious hour.
  Future<Result<List<DateTime>>> availableTimes({
    required String serviceId,
    required DateTime date,
  });

  Future<Result<PujaBooking>> book(PujaBookingRequest request);

  Future<Result<List<PujaBooking>>> myBookings();

  Future<Result<PujaBooking>> booking(String bookingId);

  Future<Result<PujaBooking>> cancel(String bookingId, String reason);
}

/// One booking request.
class PujaBookingRequest {
  const PujaBookingRequest({
    required this.serviceId,
    required this.mode,
    required this.scheduledAt,
    required this.sankalp,
    required this.withSamagri,
    required this.paymentRail,
    this.address,
  });

  final String serviceId;
  final PujaMode mode;
  final DateTime scheduledAt;
  final SankalpDetails sankalp;
  final bool withSamagri;
  final PaymentRail paymentRail;
  final String? address;
}
