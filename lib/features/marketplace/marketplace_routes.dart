import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/cart_page.dart';
import 'presentation/pages/checkout_page.dart';
import 'presentation/pages/marketplace_page.dart';
import 'presentation/pages/product_details_page.dart';
import 'presentation/pages/product_form_page.dart';
import 'presentation/pages/product_listing_page.dart';
import 'presentation/pages/pending_reviews_page.dart';
import 'presentation/pages/product_reviews_page.dart';
import 'presentation/pages/saved_products_page.dart';
import 'presentation/pages/write_product_review_page.dart';

/// Root page of the 'marketplace' bottom-nav branch.
final GoRoute marketplaceTabRoute = GoRoute(
  path: AppRoutes.marketplace,
  name: 'marketplace',
  builder: (context, state) => const MarketplacePage(),
);

/// Routes pushed on top of the shell for the marketplace feature.
///
/// `/marketplace/listing` accepts optional `?category=<id>&q=<query>`.
///
/// Order matters: the static `/marketplace/product/new` and the
/// `/marketplace/product/:id/edit` routes are registered **before**
/// `/marketplace/product/:id` so go_router never treats `new` as an id.
final List<RouteBase> marketplaceRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.pendingReviews,
    name: 'pendingReviews',
    builder: (context, state) => const PendingReviewsPage(),
  ),
  GoRoute(
    path: AppRoutes.productReviews,
    name: 'productReviews',
    builder: (context, state) => ProductReviewsPage(
      productId: state.pathParameters['id'] ?? '',
      isSeller: state.uri.queryParameters['seller'] == 'true',
    ),
  ),
  GoRoute(
    path: AppRoutes.productReviewNew,
    name: 'productReviewNew',
    builder: (context, state) => WriteProductReviewPage(
      productId: state.pathParameters['id'] ?? '',
      orderId: state.uri.queryParameters['orderId'],
    ),
  ),
  GoRoute(
    path: AppRoutes.savedProducts,
    name: 'savedProducts',
    builder: (context, state) => const SavedProductsPage(),
  ),
  GoRoute(
    path: AppRoutes.productListing,
    name: 'productListing',
    builder: (context, state) => ProductListingPage(
      categoryId: state.uri.queryParameters['category'],
      query: state.uri.queryParameters['q'],
    ),
  ),
  GoRoute(
    path: AppRoutes.productCreate,
    name: 'productCreate',
    builder: (context, state) => const ProductFormPage(),
  ),
  GoRoute(
    path: AppRoutes.productEdit,
    name: 'productEdit',
    builder: (context, state) =>
        ProductFormPage(productId: state.pathParameters['id']),
  ),
  GoRoute(
    path: AppRoutes.productDetails,
    name: 'productDetails',
    builder: (context, state) =>
        ProductDetailsPage(productId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.cart,
    name: 'cart',
    builder: (context, state) => const CartPage(),
  ),
  GoRoute(
    path: AppRoutes.checkout,
    name: 'checkout',
    builder: (context, state) => const CheckoutPage(),
  ),
];
