import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/session/permission.dart';
import '../../core/session/route_guard.dart';
import 'presentation/pages/payment_status_page.dart';
import 'presentation/pages/refund_request_page.dart';
import 'presentation/pages/topup_page.dart';
import 'presentation/pages/transactions_page.dart';
import 'presentation/pages/wallet_page.dart';

/// Wallet routes.
///
/// All of them are gated on [Permission.manageWallet], so a signed-out
/// session is sent back to Home rather than reaching a balance screen.
/// The server remains the actual authority on every debit and credit.
final List<RouteBase> walletRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.wallet,
    name: 'wallet',
    redirect: RouteGuard.require(
      Permission.manageWallet,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => const WalletPage(),
  ),
  GoRoute(
    path: AppRoutes.walletTopUp,
    name: 'walletTopUp',
    redirect: RouteGuard.require(
      Permission.manageWallet,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => TopUpPage(
      initialAmount: double.tryParse(state.uri.queryParameters['amount'] ?? ''),
    ),
  ),
  GoRoute(
    path: AppRoutes.walletTransactions,
    name: 'walletTransactions',
    redirect: RouteGuard.require(
      Permission.manageWallet,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => const TransactionsPage(),
  ),
  GoRoute(
    path: AppRoutes.walletPayment,
    name: 'walletPayment',
    redirect: RouteGuard.require(
      Permission.manageWallet,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) =>
        PaymentStatusPage(intentId: state.pathParameters['intentId'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.walletRefund,
    name: 'walletRefund',
    redirect: RouteGuard.require(
      Permission.manageWallet,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => RefundRequestPage(
      transactionId: state.pathParameters['transactionId'] ?? '',
    ),
  ),
];
