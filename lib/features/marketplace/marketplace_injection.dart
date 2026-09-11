import 'package:get_it/get_it.dart';

import '../../core/region/region_all.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_marketplace_data_sources.dart';
import 'data/datasources/api_product_data_source.dart';
import 'data/datasources/api_cart_data_source.dart';
import 'data/datasources/cart_data_source.dart';
import 'data/datasources/cart_local_data_source.dart';
import 'data/datasources/mock_boost_data_source.dart';
import 'data/datasources/mock_order_data_source.dart';
import 'data/datasources/mock_product_data_source.dart';
import 'data/datasources/product_review_data_source.dart';
import 'data/repositories/boost_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/product_review_repository_impl.dart';
import 'domain/repositories/boost_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/product_review_repository.dart';
import 'domain/usecases/add_to_cart.dart';
import 'domain/usecases/apply_coupon.dart';
import 'domain/usecases/clear_cart.dart';
import 'domain/usecases/create_product.dart';
import 'domain/usecases/delete_product.dart';
import 'domain/usecases/get_boost_plans.dart';
import 'domain/usecases/get_boosted_products.dart';
import 'domain/usecases/get_cart.dart';
import 'domain/usecases/get_categories.dart';
import 'domain/usecases/get_my_products.dart';
import 'domain/usecases/get_product_by_id.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/place_order.dart';
import 'domain/usecases/product_review_usecases.dart';
import 'domain/usecases/remove_from_cart.dart';
import 'domain/usecases/submit_boost_request.dart';
import 'domain/usecases/toggle_favourite.dart';
import 'domain/usecases/update_cart_item.dart';
import 'domain/usecases/update_product.dart';
import 'presentation/cubit/boost_cubit.dart';
import 'presentation/cubit/business_listings_cubit.dart';
import 'presentation/cubit/cart_cubit.dart';
import 'presentation/cubit/checkout_cubit.dart';
import 'presentation/cubit/marketplace_cubit.dart';
import 'presentation/cubit/pending_reviews_cubit.dart';
import 'presentation/cubit/product_details_cubit.dart';
import 'presentation/cubit/product_form_cubit.dart';
import 'presentation/cubit/product_reviews_cubit.dart';
import 'presentation/cubit/write_product_review_cubit.dart';
import 'presentation/cubit/product_listing_cubit.dart';

/// Registers data sources, repositories, use cases and cubits for
/// `marketplace`.
void registerMarketplaceFeature(GetIt sl) {
  sl
    // Data sources
    ..registerLazySingleton<ProductDataSource>(
      () => selectDataSource(
        mock: () => MockProductDataSource(resolver: sl<RegionResolver>()),
        live: () => ApiProductDataSource(sl<ApiClient>()),
      ),
    )
    // The cart has to live where checkout reads it. Local-only meant every
    // order came back "Your cart is empty", because the server was looking at
    // a cart the app had never written to.
    ..registerLazySingleton<CartDataSource>(
      () => selectDataSource(
        mock: () => CartLocalDataSource(sl<KeyValueStore>()),
        live: () => ApiCartDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<OrderDataSource>(
      () => selectDataSource(
        mock: MockOrderDataSource.new,
        live: () => ApiOrderDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<BoostDataSource>(
      () => selectDataSource(
        mock: () => MockBoostDataSource(resolver: sl<RegionResolver>()),
        live: () => ApiBoostDataSource(sl<ApiClient>()),
      ),
    )
    // Repositories
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()),
    )
    ..registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()))
    ..registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()))
    ..registerLazySingleton<BoostRepository>(() => BoostRepositoryImpl(sl()))
    // Use cases
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => GetBoostedProducts(sl()))
    ..registerLazySingleton(() => GetProductById(sl()))
    ..registerLazySingleton(() => ToggleFavourite(sl()))
    ..registerLazySingleton(() => GetMyProducts(sl()))
    ..registerLazySingleton(() => CreateProduct(sl()))
    ..registerLazySingleton(() => UpdateProduct(sl()))
    ..registerLazySingleton(() => DeleteProduct(sl()))
    ..registerLazySingleton(() => GetCart(sl()))
    ..registerLazySingleton(() => AddToCart(sl()))
    ..registerLazySingleton(() => UpdateCartItem(sl()))
    ..registerLazySingleton(() => RemoveFromCart(sl()))
    ..registerLazySingleton(() => ApplyCoupon(sl()))
    ..registerLazySingleton(() => ClearCart(sl()))
    ..registerLazySingleton(() => PlaceOrder(sl()))
    ..registerLazySingleton(() => GetBoostPlans(sl()))
    ..registerLazySingleton(() => SubmitBoostRequest(sl()))
    // Cubits
    // Keyed on the shop being viewed: its Products and Services tabs are the
    // marketplace listings carrying its id.
    ..registerFactoryParam<BusinessListingsCubit, String, void>(
      (businessId, _) => BusinessListingsCubit(
        getProducts: sl(),
        deleteProduct: sl(),
        businessId: businessId,
      ),
    )
    ..registerFactory(
      () => MarketplaceCubit(
        getCategories: sl(),
        getBoosted: sl(),
        getProducts: sl(),
        getMyProducts: sl(),
        toggleFavourite: sl(),
        deleteProduct: sl(),
      ),
    )
    ..registerFactory(
      () => ProductListingCubit(
        getProducts: sl(),
        getCategories: sl(),
        toggleFavourite: sl(),
      ),
    )
    ..registerFactory(
      () => ProductDetailsCubit(
        getProductById: sl(),
        getProducts: sl(),
        toggleFavourite: sl(),
        addToCart: sl(),
      ),
    )
    ..registerFactory(
      () => ProductFormCubit(
        createProduct: sl(),
        updateProduct: sl(),
        deleteProduct: sl(),
        getProductById: sl(),
        getCategories: sl(),
        resolver: sl<RegionResolver>(),
      ),
    )
    ..registerFactory(
      () => CartCubit(
        getCart: sl(),
        addToCart: sl(),
        updateCartItem: sl(),
        removeFromCart: sl(),
        applyCoupon: sl(),
        clearCart: sl(),
      ),
    )
    ..registerFactory(
      () => CheckoutCubit(
        getCart: sl(),
        placeOrder: sl(),
        clearCart: sl(),
        resolver: sl<RegionResolver>(),
      ),
    )
    ..registerFactory(
      () => BoostCubit(getProducts: sl(), getPlans: sl(), submitBoost: sl()),
    )
    // Reviews
    ..registerLazySingleton<ProductReviewDataSource>(
      () => selectDataSource(
        mock: () => MockProductReviewDataSource(
          sl<KeyValueStore>(),
          sl<RegionResolver>(),
        ),
        live: () => ApiProductReviewDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<ProductReviewRepository>(
      () => ProductReviewRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetProductReviews(sl()))
    ..registerLazySingleton(() => GetRatingSummary(sl()))
    ..registerLazySingleton(() => SubmitProductReview(sl()))
    ..registerLazySingleton(() => ToggleReviewHelpful(sl()))
    ..registerLazySingleton(() => ReplyToProductReview(sl()))
    ..registerLazySingleton(() => GetPendingReviews(sl()))
    ..registerFactoryParam<ProductReviewsCubit, String, void>(
      (productId, _) => ProductReviewsCubit(
        productId: productId,
        getReviews: sl(),
        getSummary: sl(),
        toggleHelpful: sl(),
        replyToReview: sl(),
      ),
    )
    // Two params: the product, and the order that makes it verified.
    ..registerFactoryParam<WriteProductReviewCubit, String, String?>(
      (productId, orderId) => WriteProductReviewCubit(
        productId: productId,
        orderId: orderId,
        submitReview: sl(),
      ),
    )
    ..registerFactory(() => PendingReviewsCubit(getPending: sl()));
}
