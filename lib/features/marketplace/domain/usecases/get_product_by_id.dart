import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Loads a single listing for the details page.
class GetProductById implements UseCase<Product, String> {
  const GetProductById(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<Product>> call(String params) => _repo.getById(params);
}
