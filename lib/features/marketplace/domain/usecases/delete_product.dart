import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/product_repository.dart';

/// Removes one of the current seller's listings.
class DeleteProduct implements UseCase<void, String> {
  const DeleteProduct(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<void>> call(String params) => _repo.delete(params);
}
