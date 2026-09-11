import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/astrologer_review.dart';
import '../repositories/astrologer_repository.dart';

class ReportAstrologer implements UseCase<void, ReportDraft> {
  const ReportAstrologer(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<void>> call(ReportDraft params) => _repo.report(params);
}
