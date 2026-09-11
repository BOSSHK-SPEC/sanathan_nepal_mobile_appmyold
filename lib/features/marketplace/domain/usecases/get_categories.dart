import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/category.dart';
import '../repositories/product_repository.dart';

/// Loads the category chips shown on the marketplace tab.
class GetCategories implements NoParamsUseCase<List<Category>> {
  const GetCategories(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<List<Category>>> call() => _repo.getCategories();
}
