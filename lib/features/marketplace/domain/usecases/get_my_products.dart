import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Listings owned by the current user ("My Products & Services").
class GetMyProducts implements NoParamsUseCase<List<Product>> {
  const GetMyProducts(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<List<Product>>> call() => _repo.myProducts();
}
