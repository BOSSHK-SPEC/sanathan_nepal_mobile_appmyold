import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/business_profile.dart';
import '../repositories/business_repository.dart';

/// The signed-in user's own business.
///
/// Takes no id on purpose: "my business" is a question about who is asking,
/// and the app cannot know the id before it has loaded the business.
class GetMyBusiness implements NoParamsUseCase<BusinessProfile> {
  const GetMyBusiness(this._repo);
  final BusinessRepository _repo;

  @override
  Future<Result<BusinessProfile>> call() => _repo.getMyBusiness();
}
