import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/business_profile.dart';
import '../repositories/business_repository.dart';

/// Lists business listings for the admin approvals page, optionally
/// filtered by moderation [BusinessStatus] (`null` = all).
class GetBusinesses implements UseCase<List<BusinessProfile>, BusinessStatus?> {
  const GetBusinesses(this._repo);
  final BusinessRepository _repo;

  @override
  Future<Result<List<BusinessProfile>>> call(BusinessStatus? params) =>
      _repo.getBusinesses(status: params);
}
