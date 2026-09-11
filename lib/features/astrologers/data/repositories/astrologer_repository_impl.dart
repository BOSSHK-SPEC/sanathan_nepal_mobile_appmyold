import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../../domain/entities/astrologer_review.dart';
import '../../domain/repositories/astrologer_repository.dart';
import '../datasources/astrologer_data_source.dart';

class AstrologerRepositoryImpl implements AstrologerRepository {
  const AstrologerRepositoryImpl(this._source);

  final AstrologerDataSource _source;

  @override
  Future<Result<List<Astrologer>>> getAstrologers(AstrologerFilter filter) =>
      guard(() => _source.getAstrologers(filter));

  @override
  Future<Result<Astrologer>> getAstrologer(String id) =>
      guard(() => _source.getAstrologer(id));

  @override
  Future<Result<List<String>>> getLanguages() => guard(_source.getLanguages);

  @override
  Future<Result<List<AstrologerReview>>> getReviews(String astrologerId) =>
      guard(() => _source.getReviews(astrologerId));

  @override
  Future<Result<AstrologerReview>> submitReview(ReviewDraft draft) =>
      guard(() => _source.submitReview(draft));

  @override
  Future<Result<String?>> reviewableConsultationId(String astrologerId) =>
      guard(() => _source.reviewableConsultationId(astrologerId));

  @override
  Future<Result<bool>> toggleFollow(String astrologerId) =>
      guard(() => _source.toggleFollow(astrologerId));

  @override
  Future<Result<void>> report(ReportDraft draft) =>
      guard(() => _source.report(draft));

  @override
  Future<Result<List<String>>> recentSearches() =>
      guard(_source.recentSearches);

  @override
  Future<Result<void>> saveSearch(String query) =>
      guard(() => _source.saveSearch(query));

  @override
  Future<Result<void>> clearSearches() => guard(_source.clearSearches);
}
