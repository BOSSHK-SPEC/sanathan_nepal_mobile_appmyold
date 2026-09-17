import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/astrologer_slot.dart';
import '../../domain/entities/booking_request.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../../domain/entities/time_slot.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_data_source.dart';

/// [AppointmentRepository] delegating to an [AppointmentDataSource].
class AppointmentRepositoryImpl implements AppointmentRepository {
  AppointmentRepositoryImpl(this._source);
  final AppointmentDataSource _source;

  @override
  Future<Result<List<BookableAstrologer>>> getAstrologers() =>
      guard(_source.fetchAstrologers);

  @override
  Future<Result<BookableAstrologer>> getAstrologer(String id) =>
      guard(() => _source.fetchAstrologer(id));

  @override
  Future<Result<List<AstrologerSlot>>> getAstrologerSlots(
    String astrologerId,
  ) => guard(() => _source.fetchAstrologerSlots(astrologerId));

  @override
  Future<Result<List<TimeSlot>>> getTimeSlots(SlotQuery query) =>
      guard(() async {
        final slots = await _source.fetchTimeSlots(
          query.astrologerId,
          query.date,
          serviceId: query.serviceId,
        );
        return slots.map((s) => s.toEntity()).toList();
      });

  @override
  Future<Result<List<Appointment>>> getAppointments() => guard(() async {
    final list = await _source.fetchAppointments();
    return list.map((a) => a.toEntity()).toList();
  });

  @override
  Future<Result<Appointment>> getAppointment(String id) =>
      guard(() async => (await _source.fetchAppointment(id)).toEntity());

  @override
  Future<Result<Appointment>> book(BookingRequest request) =>
      guard(() async => (await _source.book(request)).toEntity());

  @override
  Future<Result<Appointment>> cancel(String id) =>
      guard(() async => (await _source.cancel(id)).toEntity());

  @override
  Future<Result<Appointment>> reschedule(RescheduleRequest request) =>
      guard(() async {
        final updated = await _source.reschedule(
          request.appointmentId,
          request.date,
          request.slotId,
        );
        return updated.toEntity();
      });
}
