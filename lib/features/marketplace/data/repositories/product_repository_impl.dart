import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_draft.dart';
import '../../domain/entities/product_filter.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/mock_product_data_source.dart';
import '../models/product_model.dart';

/// [ProductRepository] backed by a [ProductDataSource]; maps models to
/// entities and exceptions to [Failure]s via `guard`.
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._source);
  final ProductDataSource _source;

  @override
  Future<Result<List<Category>>> getCategories() =>
      guard(_source.fetchCategories);

  @override
  Future<Result<List<Product>>> getProducts(ProductFilter filter) =>
      guard(() async => _entities(await _source.fetchProducts(filter)));

  @override
  Future<Result<Product>> getById(String id) =>
      guard(() async => (await _source.fetchById(id)).toEntity());

  @override
  Future<Result<Product>> toggleFavourite(String id) =>
      guard(() async => (await _source.toggleFavourite(id)).toEntity());

  @override
  Future<Result<List<Product>>> myProducts() =>
      guard(() async => _entities(await _source.myProducts()));

  @override
  Future<Result<Product>> create(ProductDraft draft) =>
      guard(() async => (await _source.create(draft)).toEntity());

  @override
  Future<Result<Product>> update(String id, ProductDraft draft) =>
      guard(() async => (await _source.update(id, draft)).toEntity());

  @override
  Future<Result<void>> delete(String id) => guard(() => _source.delete(id));

  static List<Product> _entities(List<ProductModel> models) => [
    for (final m in models) m.toEntity(),
  ];
}
