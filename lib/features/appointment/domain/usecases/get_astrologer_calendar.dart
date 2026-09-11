import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/astrologer_slot.dart';
import '../repositories/appointment_repository.dart';

/// The astrologer's whole publishable calendar — a rolling fortnight of half
/// hours generated from the weekly hours they keep.
///
/// The wizard needs it as well as the per-date grid: opening on "tomorrow"
/// lands on a day the astrologer does not work roughly two days in seven, and
/// an empty grid on arrival reads as "nobody can book this person".
class GetAstrologerCalendar
    implements UseCase<List<AstrologerSlot>, String> {
  const GetAstrologerCalendar(this._repository);

  final AppointmentRepository _repository;

  @override
  Future<Result<List<AstrologerSlot>>> call(String astrologerId) =>
      _repository.getAstrologerSlots(astrologerId);
}
