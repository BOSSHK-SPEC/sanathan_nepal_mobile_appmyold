import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/appointment.dart';
import '../entities/booking_request.dart';
import '../repositories/appointment_repository.dart';

/// Moves a booked appointment to another date / slot.
class RescheduleAppointment implements UseCase<Appointment, RescheduleRequest> {
  const RescheduleAppointment(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<Appointment>> call(RescheduleRequest params) =>
      _repo.reschedule(params);
}
