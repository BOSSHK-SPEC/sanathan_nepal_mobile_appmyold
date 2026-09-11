import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../entities/product_draft.dart';
import '../repositories/product_repository.dart';

/// Publishes a new listing for the current seller.
class CreateProduct implements UseCase<Product, ProductDraft> {
  const CreateProduct(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<Product>> call(ProductDraft params) => _repo.create(params);
}
