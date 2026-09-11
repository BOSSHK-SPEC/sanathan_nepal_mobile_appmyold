import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/forex_repository.dart';

/// Reads the ISO codes pinned to the home page.
class GetFavouriteCurrencies implements NoParamsUseCase<List<String>> {
  const GetFavouriteCurrencies(this._repo);
  final ForexRepository _repo;
  @override
  Future<Result<List<String>>> call() => _repo.getFavouriteCurrencies();
}

/// Persists the ISO codes pinned to the home page (max [maxFavourites]).
class SaveFavouriteCurrencies implements UseCase<void, List<String>> {
  const SaveFavouriteCurrencies(this._repo);
  final ForexRepository _repo;

  static const int maxFavourites = 4;

  @override
  Future<Result<void>> call(List<String> params) =>
      _repo.saveFavouriteCurrencies(params.take(maxFavourites).toList());
}
