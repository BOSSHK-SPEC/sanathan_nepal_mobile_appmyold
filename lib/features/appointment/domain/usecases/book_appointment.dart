import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/appointment.dart';
import '../entities/booking_request.dart';
import '../repositories/appointment_repository.dart';

/// Validates and books a new appointment.
class BookAppointment implements UseCase<Appointment, BookingRequest> {
  const BookAppointment(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<Appointment>> call(BookingRequest params) {
    if (params.customerName.trim().isEmpty) {
      return Future.value(
        const Result.failure(ValidationFailure('Name is required')),
      );
    }
    if (params.phone.trim().length < 7) {
      return Future.value(
        const Result.failure(ValidationFailure('Valid phone is required')),
      );
    }
    if (params.quantity < 1) {
      return Future.value(
        const Result.failure(ValidationFailure('Quantity must be at least 1')),
      );
    }
    return _repo.book(params);
  }
}
