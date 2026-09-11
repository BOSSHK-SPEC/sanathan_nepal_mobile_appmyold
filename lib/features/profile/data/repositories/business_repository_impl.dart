import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/business_profile.dart';
import '../../domain/repositories/business_repository.dart';
import '../datasources/mock_business_data_source.dart';
import '../models/business_profile_model.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  BusinessRepositoryImpl(this._source);
  final BusinessDataSource _source;

  @override
  Future<Result<BusinessProfile>> getMyBusiness() =>
      guard(() async => (await _source.myBusiness()).toEntity());

  @override
  Future<Result<BusinessProfile>> getBusiness(String id) =>
      guard(() async => (await _source.getBusiness(id)).toEntity());

  @override
  Future<Result<List<BusinessProfile>>> getBusinesses({
    BusinessStatus? status,
  }) => guard(() async {
    // Filtered server-side: an approvals queue can be long, and shipping every
    // rejected listing across the wire to drop it on the client is waste that
    // grows with the platform.
    final all = await _source.listBusinesses(status: status);
    return [for (final b in all) b.toEntity()];
  });

  @override
  Future<Result<BusinessProfile>> upsertBusiness(BusinessProfile business) =>
      guard(() async {
        final saved = await _source.upsert(
          BusinessProfileModel.fromEntity(business),
        );
        return saved.toEntity();
      });

  @override
  Future<Result<BusinessProfile>> setStatus(
    String id,
    BusinessStatus status, {
    String note = '',
  }) => guard(() async {
    // One call to the decision endpoint. It used to read the business and
    // write it back through `upsert`, which posted to `/business/mine` and
    // carried no status field at all — so a decision silently did nothing to
    // the business it was aimed at.
    final saved = await _source.setStatus(id, status, note: note);
    return saved.toEntity();
  });

  @override
  Future<Result<BusinessProfile>> addReview(
    String businessId,
    int rating,
    String text,
  ) => guard(() async {
    final saved = await _source.addReview(businessId, rating, text);
    return saved.toEntity();
  });
}
