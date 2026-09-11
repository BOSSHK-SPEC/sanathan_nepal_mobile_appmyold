import '../../../../core/utils/result.dart';
import '../entities/appointment.dart';
import '../entities/astrologer_slot.dart';
import '../entities/booking_request.dart';
import '../entities/bookable_astrologer.dart';
import '../entities/time_slot.dart';

/// Appointment booking + astrologer profile access.
abstract interface class AppointmentRepository {
  Future<Result<List<BookableAstrologer>>> getAstrologers();
  Future<Result<BookableAstrologer>> getAstrologer(String id);
  Future<Result<List<TimeSlot>>> getTimeSlots(SlotQuery query);

  /// An astrologer's bookable calendar for the next two weeks.
  Future<Result<List<AstrologerSlot>>> getAstrologerSlots(String astrologerId);
  Future<Result<List<Appointment>>> getAppointments();
  Future<Result<Appointment>> getAppointment(String id);
  Future<Result<Appointment>> book(BookingRequest request);
  Future<Result<Appointment>> cancel(String id);
  Future<Result<Appointment>> reschedule(RescheduleRequest request);

}
