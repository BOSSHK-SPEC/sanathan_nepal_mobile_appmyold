import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/astrologer.dart';
import '../entities/astrologer_filter.dart';
import '../repositories/astrologer_repository.dart';

/// Filtered, sorted astrologer catalogue for the discovery screen.
class GetAstrologers implements UseCase<List<Astrologer>, AstrologerFilter> {
  const GetAstrologers(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<List<Astrologer>>> call(AstrologerFilter params) =>
      _repo.getAstrologers(params);
}
