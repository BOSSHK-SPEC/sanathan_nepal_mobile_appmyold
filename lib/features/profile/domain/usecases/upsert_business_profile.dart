import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/business_profile.dart';
import '../repositories/business_repository.dart';

/// Validates and saves a business profile submitted from the form.
class UpsertBusinessProfile
    implements UseCase<BusinessProfile, BusinessProfile> {
  const UpsertBusinessProfile(this._repo);
  final BusinessRepository _repo;

  @override
  Future<Result<BusinessProfile>> call(BusinessProfile params) {
    if (params.name.trim().isEmpty) {
      return Future.value(
        const Result.failure(ValidationFailure('Business name is required')),
      );
    }
    if (params.category.trim().isEmpty) {
      return Future.value(
        const Result.failure(ValidationFailure('Business type is required')),
      );
    }
    if (params.phone.trim().isEmpty) {
      return Future.value(
        const Result.failure(ValidationFailure('Phone number is required')),
      );
    }
    return _repo.upsertBusiness(params);
  }
}
