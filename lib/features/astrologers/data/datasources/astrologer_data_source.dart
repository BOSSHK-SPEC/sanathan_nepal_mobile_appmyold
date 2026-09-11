import '../../domain/entities/astrologer.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../../domain/entities/astrologer_review.dart';

/// I/O contract for astrologer discovery. Throws `core/error` exceptions;
/// the repository converts them into `Failure`s.
abstract interface class AstrologerDataSource {
  Future<List<Astrologer>> getAstrologers(AstrologerFilter filter);
  Future<Astrologer> getAstrologer(String id);
  Future<List<String>> getLanguages();
  Future<List<AstrologerReview>> getReviews(String astrologerId);
  Future<AstrologerReview> submitReview(ReviewDraft draft);

  /// The consultation this user may review [astrologerId] against, or null.
  ///
  /// A review has to be tied to a completed session — the server rejects one
  /// that is not, which is what stops competitors and paid accounts leaving
  /// ratings. The profile asks first so it can offer the button only when it
  /// will work, instead of sending someone into a form that 400s on submit.
  Future<String?> reviewableConsultationId(String astrologerId);
  Future<bool> toggleFollow(String astrologerId);
  Future<void> report(ReportDraft draft);
  Future<List<String>> recentSearches();
  Future<void> saveSearch(String query);
  Future<void> clearSearches();
}
