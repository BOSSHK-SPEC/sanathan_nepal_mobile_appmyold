import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../entities/product_filter.dart';
import '../repositories/product_repository.dart';

/// Products currently boosted ("Boosted Post" carousel).
class GetBoostedProducts implements NoParamsUseCase<List<Product>> {
  const GetBoostedProducts(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<List<Product>>> call() =>
      _repo.getProducts(const ProductFilter(boostedOnly: true));
}
