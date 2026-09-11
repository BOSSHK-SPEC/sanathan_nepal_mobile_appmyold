import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_products.dart';

part 'business_listings_cubit.freezed.dart';
part 'business_listings_state.dart';

/// The marketplace listings belonging to one shop.
///
/// A business profile's Products and Services tabs are exactly the listings
/// carrying its id — the same rows the marketplace serves, not a second
/// catalogue kept on the business record. Two lists both labelled "Products &
/// Services" is how a seller ends up adding a product that the marketplace
/// never shows.
class BusinessListingsCubit extends AppCubit<BusinessListingsState> {
  BusinessListingsCubit({
    required GetProducts getProducts,
    required DeleteProduct deleteProduct,
    required String businessId,
  }) : _getProducts = getProducts,
       _deleteProduct = deleteProduct,
       _businessId = businessId,
       super(const BusinessListingsState());

  final GetProducts _getProducts;
  final DeleteProduct _deleteProduct;
  final String _businessId;

  /// A shop's whole catalogue on one screen — it is browsed, not paged.
  static const int _limit = 100;

  Future<void> load() async {
    if (_businessId.isEmpty) {
      emit(state.copyWith(listings: const LoadState.loaded([])));
      return;
    }
    emit(state.copyWith(listings: state.listings.toLoading()));
    final result = await _getProducts(
      ProductFilter(businessId: _businessId, limit: _limit),
    );
    emit(
      state.copyWith(
        listings: result.fold(state.listings.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Removes one of the shop's listings, keeping the grid in step on success
  /// and leaving it untouched on failure.
  Future<void> remove(String productId) async {
    emit(state.copyWith(deletion: state.deletion.toLoading()));
    final result = await _deleteProduct(productId);
    emit(
      result.fold(
        (failure) => state.copyWith(deletion: state.deletion.toFailed(failure)),
        (_) => state.copyWith(
          deletion: LoadState.loaded(productId),
          listings: state.listings.map(
            (items) => [
              for (final p in items)
                if (p.id != productId) p,
            ],
          ),
        ),
      ),
    );
  }
}
