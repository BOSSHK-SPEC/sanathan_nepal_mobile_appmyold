import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

/// Cancels a booked appointment.
class CancelAppointment implements UseCase<Appointment, String> {
  const CancelAppointment(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<Appointment>> call(String params) => _repo.cancel(params);
}
