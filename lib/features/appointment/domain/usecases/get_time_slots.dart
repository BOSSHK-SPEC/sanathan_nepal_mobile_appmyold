import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/booking_request.dart';
import '../entities/time_slot.dart';
import '../repositories/appointment_repository.dart';

/// Available slots of a astrologer on a given day.
class GetTimeSlots implements UseCase<List<TimeSlot>, SlotQuery> {
  const GetTimeSlots(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<List<TimeSlot>>> call(SlotQuery params) =>
      _repo.getTimeSlots(params);
}
