import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/appointment.dart';
import '../repositories/appointment_repository.dart';

/// All appointments of the current user (upcoming + past).
class GetAppointments implements NoParamsUseCase<List<Appointment>> {
  const GetAppointments(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<List<Appointment>>> call() => _repo.getAppointments();
}
