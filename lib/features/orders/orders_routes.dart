import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/session/permission.dart';
import '../../core/session/route_guard.dart';
import 'presentation/cubit/orders_list_cubit.dart';
import 'presentation/pages/order_details_page.dart';
import 'presentation/pages/orders_list_page.dart';
import 'presentation/pages/return_request_page.dart';

/// Order tracking for buyers, fulfilment for sellers.
///
/// `/seller/orders` needs the fulfilment permission; the buyer routes only
/// need a purchasing account.
final List<RouteBase> ordersRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.sellerOrders,
    name: 'sellerOrders',
    redirect: RouteGuard.require(
      Permission.fulfilOrders,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) =>
        const OrdersListPage(scope: OrdersScope.seller),
  ),
  GoRoute(
    path: AppRoutes.myOrders,
    name: 'myOrders',
    redirect: RouteGuard.require(
      Permission.purchaseProducts,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => const OrdersListPage(scope: OrdersScope.buyer),
  ),
  GoRoute(
    path: AppRoutes.orderReturn,
    name: 'orderReturn',
    builder: (context, state) =>
        ReturnRequestPage(orderId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.orderDetails,
    name: 'orderDetails',
    builder: (context, state) =>
        OrderDetailsPage(orderId: state.pathParameters['id'] ?? ''),
  ),
];
