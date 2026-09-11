import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Toggles the heart on a listing and returns the updated product.
class ToggleFavourite implements UseCase<Product, String> {
  const ToggleFavourite(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<Product>> call(String params) => _repo.toggleFavourite(params);
}
