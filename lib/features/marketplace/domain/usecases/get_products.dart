import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../entities/product_filter.dart';
import '../repositories/product_repository.dart';

/// Lists products for a [ProductFilter] (search / category / sort).
class GetProducts implements UseCase<List<Product>, ProductFilter> {
  const GetProducts(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<List<Product>>> call(ProductFilter params) =>
      _repo.getProducts(params);
}
