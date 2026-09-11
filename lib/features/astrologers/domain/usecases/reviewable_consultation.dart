import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/astrologer_repository.dart';

/// The completed consultation a seeker may review an astrologer against.
///
/// Null means they have not had one. The profile uses this to decide whether
/// to offer the review button at all: the server refuses a review with no
/// session behind it, and a button that always ends in an error is worse than
/// no button.
class GetReviewableConsultation implements UseCase<String?, String> {
  const GetReviewableConsultation(this._repo);

  final AstrologerRepository _repo;

  @override
  Future<Result<String?>> call(String astrologerId) =>
      _repo.reviewableConsultationId(astrologerId);
}
