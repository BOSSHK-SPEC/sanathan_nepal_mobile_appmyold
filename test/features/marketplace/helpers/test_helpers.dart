import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/cart_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_boost_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_order_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/boost_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/cart_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/order_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/seller.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/add_to_cart.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/apply_coupon.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/clear_cart.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/create_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/delete_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_boost_plans.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_boosted_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_cart.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_categories.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_my_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_product_by_id.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/place_order.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/remove_from_cart.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/submit_boost_request.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/toggle_favourite.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/update_cart_item.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/update_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/boost_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/cart_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/checkout_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_details_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_form_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/product_review_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_review_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/product_review_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/pending_reviews_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_listing_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_reviews_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/write_product_review_cubit.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// Fixed clock so seed data ("4 minutes ago") is deterministic in tests.
final DateTime kTestNow = DateTime(2026, 8, 17, 12);

/// A fully wired, in-memory marketplace stack (real repositories + mock
/// data sources) for widget and cubit tests. Pass [region] to exercise the
/// India seed / payment rails.
class MarketplaceTestStack {
  MarketplaceTestStack({this.region = Region.nepal}) {
    resolver = FixedRegionResolver(region);
    final productSource = MockProductDataSource(
      clock: () => kTestNow,
      resolver: resolver,
    );
    products = ProductRepositoryImpl(productSource);
    cart = CartRepositoryImpl(CartLocalDataSource(InMemoryKeyValueStore()));
    orders = OrderRepositoryImpl(MockOrderDataSource(clock: () => kTestNow));
    boost = BoostRepositoryImpl(
      MockBoostDataSource(clock: () => kTestNow, resolver: resolver),
    );
  }

  final Region region;
  late final RegionResolver resolver;
  late final ProductRepositoryImpl products;
  late final CartRepositoryImpl cart;
  late final OrderRepositoryImpl orders;
  late final BoostRepositoryImpl boost;

  MarketplaceCubit marketplaceCubit() => MarketplaceCubit(
    getCategories: GetCategories(products),
    getBoosted: GetBoostedProducts(products),
    getProducts: GetProducts(products),
    getMyProducts: GetMyProducts(products),
    toggleFavourite: ToggleFavourite(products),
    deleteProduct: DeleteProduct(products),
  );

  ProductListingCubit listingCubit() => ProductListingCubit(
    getProducts: GetProducts(products),
    getCategories: GetCategories(products),
    toggleFavourite: ToggleFavourite(products),
  );

  /// Reviews share one in-memory store across the cubits below, so a review
  /// written through one is visible to the others — as a real backend would.
  late final ProductReviewRepositoryImpl reviews = ProductReviewRepositoryImpl(
    MockProductReviewDataSource(InMemoryKeyValueStore(), resolver),
  );

  ProductReviewsCubit reviewsCubit(String productId) => ProductReviewsCubit(
    productId: productId,
    getReviews: GetProductReviews(reviews),
    getSummary: GetRatingSummary(reviews),
    toggleHelpful: ToggleReviewHelpful(reviews),
    replyToReview: ReplyToProductReview(reviews),
  );

  WriteProductReviewCubit writeReviewCubit(
    String productId, {
    String? orderId,
  }) => WriteProductReviewCubit(
    productId: productId,
    orderId: orderId,
    submitReview: SubmitProductReview(reviews),
  );

  PendingReviewsCubit pendingReviewsCubit() =>
      PendingReviewsCubit(getPending: GetPendingReviews(reviews));

  /// Binds this stack's review cubit into GetIt.
  ///
  /// The product details page resolves its reviews block through the
  /// locator, so any test that renders the whole body needs this. Rebinding
  /// on each call keeps a fresh stack's store in play.
  void installReviewLocator() {
    final locator = GetIt.instance;
    if (locator.isRegistered<ProductReviewsCubit>()) {
      locator.unregister<ProductReviewsCubit>();
    }
    locator.registerFactoryParam<ProductReviewsCubit, String, void>(
      (productId, _) => reviewsCubit(productId),
    );
  }

  ProductDetailsCubit detailsCubit() => ProductDetailsCubit(
    getProductById: GetProductById(products),
    getProducts: GetProducts(products),
    toggleFavourite: ToggleFavourite(products),
    addToCart: AddToCart(cart),
  );

  ProductFormCubit formCubit() => ProductFormCubit(
    createProduct: CreateProduct(products),
    updateProduct: UpdateProduct(products),
    deleteProduct: DeleteProduct(products),
    getProductById: GetProductById(products),
    getCategories: GetCategories(products),
    resolver: resolver,
    clock: () => kTestNow,
  );

  CartCubit cartCubit() => CartCubit(
    getCart: GetCart(cart),
    addToCart: AddToCart(cart),
    updateCartItem: UpdateCartItem(cart),
    removeFromCart: RemoveFromCart(cart),
    applyCoupon: ApplyCoupon(cart),
    clearCart: ClearCart(cart),
  );

  CheckoutCubit checkoutCubit() => CheckoutCubit(
    getCart: GetCart(cart),
    placeOrder: PlaceOrder(orders),
    clearCart: ClearCart(cart),
    resolver: resolver,
  );

  BoostCubit boostCubit() => BoostCubit(
    getProducts: GetProducts(products),
    getPlans: GetBoostPlans(boost),
    submitBoost: SubmitBoostRequest(boost),
  );
}

/// Sample product for unit tests.
Product sampleProduct({
  String id = 'x1',
  double price = 1500,
  bool mine = false,
}) => Product(
  id: id,
  title: 'Sample $id',
  titleNe: 'नमूना $id',
  description: 'desc',
  descriptionNe: 'विवरण',
  price: price,
  categoryId: 'gemstones',
  images: const ['category:gemstones'],
  seller: const Seller(id: 's', name: 'Seller'),
  location: 'Kathmandu',
  locationNe: 'काठमाडौँ',
  postedAt: kTestNow,
  isMine: mine,
);

/// Wraps [child] in a themed, localised MaterialApp with the given cubits,
/// inside a [RegionScope] for [region] (Nepal by default).
Widget wrapPage(
  Widget child, {
  List<BlocProvider> providers = const [],
  Locale locale = const Locale('en'),
  ThemeData? theme,
  Region region = Region.nepal,

  /// Seller-only affordances are gated on the session's permissions, so a
  /// test that exercises them has to say who is looking.
  AppSession session = AppSession.guest,
}) {
  final app = SessionScope(
    session: session,
    child: RegionScope(
      region: region,
      child: MaterialApp(
        theme: theme ?? AppTheme.light(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    ),
  );
  if (providers.isEmpty) return app;
  return MultiBlocProvider(providers: providers, child: app);
}

/// Pumps and waits out the mock data-source latency.
Future<void> settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  await tester.pump();
}

/// A signed-in merchant — the only role that may publish listings.
const AppSession merchantSession = AppSession(
  userId: 'u1',
  name: 'Seller',
  roles: {AppRole.seeker, AppRole.merchant},
  isAuthenticated: true,
);
