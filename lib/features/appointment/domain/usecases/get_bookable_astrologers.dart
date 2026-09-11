import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/bookable_astrologer.dart';
import '../repositories/appointment_repository.dart';

/// Lists all bookable astrologers (the first one is the featured astrologer).
class GetBookableAstrologers implements NoParamsUseCase<List<BookableAstrologer>> {
  const GetBookableAstrologers(this._repo);
  final AppointmentRepository _repo;

  @override
  Future<Result<List<BookableAstrologer>>> call() => _repo.getAstrologers();
}
