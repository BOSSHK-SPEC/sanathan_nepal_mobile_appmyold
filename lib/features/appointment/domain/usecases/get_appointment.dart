import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

/// One appointment by id.
class GetAppointment implements UseCase<Appointment, String> {
  const GetAppointment(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<Appointment>> call(String params) =>
      _repo.getAppointment(params);
}
