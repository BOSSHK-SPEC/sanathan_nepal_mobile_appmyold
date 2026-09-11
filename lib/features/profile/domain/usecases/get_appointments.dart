import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/appointment_summary.dart';
import '../repositories/activity_repository.dart';

/// Loads the user's booked appointments.
class GetAppointments implements NoParamsUseCase<List<AppointmentSummary>> {
  const GetAppointments(this._repo);
  final ActivityRepository _repo;

  @override
  Future<Result<List<AppointmentSummary>>> call() => _repo.getAppointments();
}
