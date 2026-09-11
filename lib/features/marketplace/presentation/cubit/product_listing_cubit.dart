import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/toggle_favourite.dart';
import '../../../../core/state/app_cubit.dart';

part 'product_listing_cubit.freezed.dart';
part 'product_listing_state.dart';

/// "Product & Service listing" page: search + category + sort.
class ProductListingCubit extends AppCubit<ProductListingState> {
  ProductListingCubit({
    required GetProducts getProducts,
    required GetCategories getCategories,
    required ToggleFavourite toggleFavourite,
  }) : _getProducts = getProducts,
       _getCategories = getCategories,
       _toggleFavourite = toggleFavourite,
       super(const ProductListingState());

  final GetProducts _getProducts;
  final GetCategories _getCategories;
  final ToggleFavourite _toggleFavourite;

  Future<void> load({
    String? categoryId,
    String? query,
    bool favouritesOnly = false,
  }) async {
    final categories = await _getCategories();
    emit(
      state.copyWith(
        categories: categories.fold(
          state.categories.toFailed,
          LoadState.loaded,
        ),
        filter: ProductFilter(
          categoryId: categoryId,
          query: query,
          favouritesOnly: favouritesOnly,
        ),
      ),
    );
    await _refresh();
  }

  Future<void> search(String query) async {
    emit(state.copyWith(filter: state.filter.copyWith(query: query)));
    await _refresh();
  }

  Future<void> selectCategory(String? categoryId) async {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          categoryId: categoryId == null || categoryId == Category.all.id
              ? null
              : categoryId,
        ),
      ),
    );
    await _refresh();
  }

  Future<void> setSort(ProductSort sort) async {
    emit(state.copyWith(filter: state.filter.copyWith(sort: sort)));
    await _refresh();
  }

  Future<void> toggleFavourite(String productId) async {
    final result = await _toggleFavourite(productId);
    final updated = result.valueOrNull;
    if (updated == null) return;
    // On the saved list an un-favourite means the row no longer belongs;
    // refetch rather than leaving a stale card behind.
    if (!updated.isFavourite && state.filter.favouritesOnly) {
      await _refresh();
      return;
    }
    emit(
      state.copyWith(
        products: state.products.map(
          (list) => [for (final p in list) p.id == updated.id ? updated : p],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    emit(state.copyWith(products: state.products.toLoading()));
    final result = await _getProducts(state.filter);
    emit(
      state.copyWith(
        products: result.fold(state.products.toFailed, LoadState.loaded),
      ),
    );
  }
}
