import '../../domain/entities/puja_booking.dart';
import '../../domain/entities/puja_service.dart';
import '../../domain/repositories/puja_repository.dart';

/// I/O contract for puja bookings.
abstract interface class PujaDataSource {
  Future<List<PujaService>> catalogue({PujaPurpose? purpose});
  Future<PujaService> service(String serviceId);
  Future<List<DateTime>> availableTimes({
    required String serviceId,
    required DateTime date,
  });
  Future<PujaBooking> book(PujaBookingRequest request);
  Future<List<PujaBooking>> myBookings();
  Future<PujaBooking> booking(String bookingId);
  Future<PujaBooking> cancel(String bookingId, String reason);
}
