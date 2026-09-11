import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/astrologer_review.dart';
import '../repositories/astrologer_repository.dart';

class SubmitAstrologerReview implements UseCase<AstrologerReview, ReviewDraft> {
  const SubmitAstrologerReview(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<AstrologerReview>> call(ReviewDraft params) =>
      _repo.submitReview(params);
}
