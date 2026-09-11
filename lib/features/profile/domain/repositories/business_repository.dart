import '../../../../core/utils/result.dart';
import '../entities/business_profile.dart';

/// Access to seller/business profiles.
abstract interface class BusinessRepository {
  Future<Result<BusinessProfile>> getBusiness(String id);

  /// The signed-in user's own business, or a not-found failure when they have
  /// not registered one.
  Future<Result<BusinessProfile>> getMyBusiness();

  /// All listings (seed + user-created), optionally filtered by [status].
  Future<Result<List<BusinessProfile>>> getBusinesses({BusinessStatus? status});

  /// Creates or updates a business and returns the persisted entity.
  Future<Result<BusinessProfile>> upsertBusiness(BusinessProfile business);

  /// Admin action: approve / reject a listing.
  Future<Result<BusinessProfile>> setStatus(
    String id,
    BusinessStatus status, {
    String note = '',
  });

  /// Submits a customer review for a business.
  Future<Result<BusinessProfile>> addReview(
    String businessId,
    int rating,
    String text,
  );
}
