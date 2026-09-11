import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_boosted_products.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_my_products.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/toggle_favourite.dart';
import '../../../../core/state/app_cubit.dart';

part 'marketplace_cubit.freezed.dart';
part 'marketplace_state.dart';

/// Drives the marketplace tab: categories, boosted carousel, my products and
/// the Recent / Recommendation feed.
class MarketplaceCubit extends AppCubit<MarketplaceState> {
  MarketplaceCubit({
    required GetCategories getCategories,
    required GetBoostedProducts getBoosted,
    required GetProducts getProducts,
    required GetMyProducts getMyProducts,
    required ToggleFavourite toggleFavourite,
    required DeleteProduct deleteProduct,
  }) : _getCategories = getCategories,
       _getBoosted = getBoosted,
       _getProducts = getProducts,
       _getMyProducts = getMyProducts,
       _toggleFavourite = toggleFavourite,
       _deleteProduct = deleteProduct,
       super(const MarketplaceState());

  final GetCategories _getCategories;
  final GetBoostedProducts _getBoosted;
  final GetProducts _getProducts;
  final GetMyProducts _getMyProducts;
  final ToggleFavourite _toggleFavourite;
  final DeleteProduct _deleteProduct;

  static const int _feedLimit = 8;

  Future<void> load() async {
    emit(
      state.copyWith(
        categories: state.categories.toLoading(),
        boosted: state.boosted.toLoading(),
        myProducts: state.myProducts.toLoading(),
        recent: state.recent.toLoading(),
        recommended: state.recommended.toLoading(),
      ),
    );
    final categories = await _getCategories();
    final boosted = await _getBoosted();
    final mine = await _getMyProducts();
    final recent = await _getProducts(_feedFilter(ProductSort.latest));
    final recommended = await _getProducts(
      _feedFilter(ProductSort.priceHighToLow),
    );
    emit(
      state.copyWith(
        categories: categories.fold(
          state.categories.toFailed,
          LoadState.loaded,
        ),
        boosted: boosted.fold(state.boosted.toFailed, LoadState.loaded),
        myProducts: mine.fold(state.myProducts.toFailed, LoadState.loaded),
        recent: recent.fold(state.recent.toFailed, LoadState.loaded),
        recommended: recommended.fold(
          state.recommended.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  Future<void> selectCategory(String id) async {
    if (id == state.selectedCategoryId) return;
    emit(
      state.copyWith(
        selectedCategoryId: id,
        recent: state.recent.toLoading(),
        recommended: state.recommended.toLoading(),
      ),
    );
    final recent = await _getProducts(_feedFilter(ProductSort.latest));
    final recommended = await _getProducts(
      _feedFilter(ProductSort.priceHighToLow),
    );
    emit(
      state.copyWith(
        recent: recent.fold(state.recent.toFailed, LoadState.loaded),
        recommended: recommended.fold(
          state.recommended.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  void selectTab(MarketplaceTab tab) => emit(state.copyWith(tab: tab));

  void selectFeedTab(FeedTab tab) => emit(state.copyWith(feedTab: tab));

  Future<void> toggleFavourite(String productId) async {
    final result = await _toggleFavourite(productId);
    final updated = result.valueOrNull;
    if (updated == null) return;
    List<Product> replace(List<Product> list) => [
      for (final p in list) p.id == updated.id ? updated : p,
    ];
    emit(
      state.copyWith(
        boosted: state.boosted.map(replace),
        myProducts: state.myProducts.map(replace),
        recent: state.recent.map(replace),
        recommended: state.recommended.map(replace),
      ),
    );
  }

  /// Removes one of the seller's listings from every slice; on failure the
  /// lists are untouched and `deletion` carries the failure for a snackbar.
  Future<void> deleteMyProduct(String productId) async {
    emit(state.copyWith(deletion: state.deletion.toLoading()));
    final result = await _deleteProduct(productId);
    List<Product> drop(List<Product> list) => [
      for (final p in list)
        if (p.id != productId) p,
    ];
    emit(
      result.fold(
        (f) => state.copyWith(deletion: state.deletion.toFailed(f)),
        (_) => state.copyWith(
          deletion: LoadState.loaded(productId),
          boosted: state.boosted.map(drop),
          myProducts: state.myProducts.map(drop),
          recent: state.recent.map(drop),
          recommended: state.recommended.map(drop),
        ),
      ),
    );
  }

  ProductFilter _feedFilter(ProductSort sort) => ProductFilter(
    categoryId: state.selectedCategoryId == MarketplaceState.allCategoryId
        ? null
        : state.selectedCategoryId,
    sort: sort,
    limit: _feedLimit,
  );
}
