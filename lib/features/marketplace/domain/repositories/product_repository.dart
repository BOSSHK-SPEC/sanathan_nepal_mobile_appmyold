import '../../../../core/utils/result.dart';
import '../entities/category.dart';
import '../entities/product.dart';
import '../entities/product_draft.dart';
import '../entities/product_filter.dart';

/// Read/write access to marketplace listings.
abstract interface class ProductRepository {
  Future<Result<List<Category>>> getCategories();
  Future<Result<List<Product>>> getProducts(ProductFilter filter);
  Future<Result<Product>> getById(String id);
  Future<Result<Product>> toggleFavourite(String id);
  Future<Result<List<Product>>> myProducts();

  /// Seller CRUD – the created / updated listing is returned with
  /// `isMine == true` and the current user as [Product.seller].
  Future<Result<Product>> create(ProductDraft draft);
  Future<Result<Product>> update(String id, ProductDraft draft);
  Future<Result<void>> delete(String id);
}
