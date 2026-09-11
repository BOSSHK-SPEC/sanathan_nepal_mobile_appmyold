import '../../../../core/utils/result.dart';
import '../entities/astrologer.dart';
import '../entities/astrologer_filter.dart';
import '../entities/astrologer_review.dart';

/// Discovery + public-profile data for astrologers.
///
/// Kept narrow (ISP): consultation delivery, scheduling and earnings live
/// behind their own repositories.
abstract interface class AstrologerRepository {
  Future<Result<List<Astrologer>>> getAstrologers(AstrologerFilter filter);

  Future<Result<Astrologer>> getAstrologer(String id);

  /// Distinct languages / specialties present in the catalogue, so the
  /// filter sheet offers only options that can actually match.
  Future<Result<List<String>>> getLanguages();

  Future<Result<List<AstrologerReview>>> getReviews(String astrologerId);

  Future<Result<AstrologerReview>> submitReview(ReviewDraft draft);

  /// The completed consultation this user may review [astrologerId] against,
  /// or null when there is none — a review must be tied to a real session.
  Future<Result<String?>> reviewableConsultationId(String astrologerId);

  /// Returns the new follow state.
  Future<Result<bool>> toggleFollow(String astrologerId);

  Future<Result<void>> report(ReportDraft draft);

  /// Recent free-text searches, newest first.
  Future<Result<List<String>>> recentSearches();

  Future<Result<void>> saveSearch(String query);

  Future<Result<void>> clearSearches();
}
