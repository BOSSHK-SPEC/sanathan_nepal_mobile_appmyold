import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/bookable_astrologer.dart';
import '../repositories/appointment_repository.dart';

/// Loads one astrologer profile by id.
class GetBookableAstrologer implements UseCase<BookableAstrologer, String> {
  const GetBookableAstrologer(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<BookableAstrologer>> call(String params) =>
      _repo.getAstrologer(params);
}
