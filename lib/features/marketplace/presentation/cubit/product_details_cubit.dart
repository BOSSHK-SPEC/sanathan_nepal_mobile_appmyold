import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/toggle_favourite.dart';
import '../../../../core/state/app_cubit.dart';

part 'product_details_cubit.freezed.dart';
part 'product_details_state.dart';

/// Product details page: gallery, options, comments, similar products and
/// the Call / Chat / Add-to-cart actions.
class ProductDetailsCubit extends AppCubit<ProductDetailsState> {
  ProductDetailsCubit({
    required GetProductById getProductById,
    required GetProducts getProducts,
    required ToggleFavourite toggleFavourite,
    required AddToCart addToCart,
  }) : _getProductById = getProductById,
       _getProducts = getProducts,
       _toggleFavourite = toggleFavourite,
       _addToCart = addToCart,
       super(const ProductDetailsState());

  final GetProductById _getProductById;
  final GetProducts _getProducts;
  final ToggleFavourite _toggleFavourite;
  final AddToCart _addToCart;

  Future<void> load(String id) async {
    emit(
      state.copyWith(
        product: state.product.toLoading(),
        similar: state.similar.toLoading(),
      ),
    );
    final result = await _getProductById(id);
    await result.fold(
      (f) async => emit(
        state.copyWith(
          product: state.product.toFailed(f),
          similar: state.similar.toFailed(f),
        ),
      ),
      (product) async {
        final defaults = {
          for (final e in product.options.entries)
            if (e.value.isNotEmpty) e.key: e.value.first,
        };
        final similar = await _getProducts(
          ProductFilter(categoryId: product.categoryId, limit: 5),
        );
        emit(
          state.copyWith(
            product: LoadState.loaded(product),
            selectedOptions: defaults,
            similar: similar.fold(
              state.similar.toFailed,
              (list) => LoadState.loaded(
                list.where((p) => p.id != product.id).take(4).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  void selectImage(int index) => emit(state.copyWith(selectedImage: index));

  void selectTab(DetailsTab tab) => emit(state.copyWith(tab: tab));

  void selectOption(String name, String value) => emit(
    state.copyWith(selectedOptions: {...state.selectedOptions, name: value}),
  );

  /// Flips the favourite flag; on failure the current product stays visible
  /// (`Failed(previous: product)`) so the page can show a snackbar.
  Future<void> toggleFavourite() async {
    final product = state.product.dataOrNull;
    if (product == null) return;
    final result = await _toggleFavourite(product.id);
    emit(
      state.copyWith(
        product: result.fold(state.product.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Adds the product with the selected options; [buyNow] marks the request
  /// so the page can jump to checkout afterwards.
  Future<void> addToCart({bool buyNow = false}) async {
    final product = state.product.dataOrNull;
    if (product == null || state.addToCart.isLoading) return;
    emit(
      state.copyWith(addToCart: state.addToCart.toLoading(), buyNow: buyNow),
    );
    final result = await _addToCart(
      AddToCartParams(product: product, selectedOptions: state.selectedOptions),
    );
    emit(
      state.copyWith(
        addToCart: result.fold(state.addToCart.toFailed, LoadState.loaded),
      ),
    );
  }
}
