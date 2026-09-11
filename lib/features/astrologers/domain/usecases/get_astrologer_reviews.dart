import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/astrologer_review.dart';
import '../repositories/astrologer_repository.dart';

class GetAstrologerReviews implements UseCase<List<AstrologerReview>, String> {
  const GetAstrologerReviews(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<List<AstrologerReview>>> call(String params) =>
      _repo.getReviews(params);
}
