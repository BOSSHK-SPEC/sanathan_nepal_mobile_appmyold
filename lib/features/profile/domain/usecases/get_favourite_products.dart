import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/favourite_product.dart';
import '../repositories/profile_repository.dart';

/// Loads the user's favourite products & services.
class GetFavouriteProducts implements NoParamsUseCase<List<FavouriteProduct>> {
  const GetFavouriteProducts(this._repo);
  final ProfileRepository _repo;

  @override
  Future<Result<List<FavouriteProduct>>> call() => _repo.getFavourites();
}
