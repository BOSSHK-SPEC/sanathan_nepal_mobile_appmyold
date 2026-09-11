import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/astrologer_repository.dart';

class GetRecentSearches implements NoParamsUseCase<List<String>> {
  const GetRecentSearches(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<List<String>>> call() => _repo.recentSearches();
}

class SaveRecentSearch implements UseCase<void, String> {
  const SaveRecentSearch(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<void>> call(String params) => _repo.saveSearch(params);
}

class ClearRecentSearches implements NoParamsUseCase<void> {
  const ClearRecentSearches(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<void>> call() => _repo.clearSearches();
}
