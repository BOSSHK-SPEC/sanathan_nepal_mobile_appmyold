import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/business_profile.dart';
import '../repositories/business_repository.dart';

/// Loads a business/seller profile by id.
class GetBusinessProfile implements UseCase<BusinessProfile, String> {
  const GetBusinessProfile(this._repo);
  final BusinessRepository _repo;

  @override
  Future<Result<BusinessProfile>> call(String params) =>
      _repo.getBusiness(params);
}
