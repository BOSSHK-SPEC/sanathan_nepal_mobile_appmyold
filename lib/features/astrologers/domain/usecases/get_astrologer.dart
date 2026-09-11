import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/astrologer.dart';
import '../repositories/astrologer_repository.dart';

/// One astrologer's public profile.
class GetAstrologer implements UseCase<Astrologer, String> {
  const GetAstrologer(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<Astrologer>> call(String params) => _repo.getAstrologer(params);
}
