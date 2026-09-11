import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/session/route_guard.dart';
import 'presentation/pages/addresses_page.dart';
import 'presentation/pages/offers_page.dart';
import 'presentation/pages/privacy_page.dart';
import 'presentation/pages/security_page.dart';
import 'presentation/pages/support_tickets_page.dart';

/// Account routes.
///
/// All of these are personal records, so they require a signed-in session
/// rather than a particular capability. `/support/tickets` is registered
/// before `/support/tickets/:id` so the list is not read as an id.
final List<RouteBase> accountRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.addresses,
    name: 'addresses',
    redirect: _signedIn,
    builder: (context, state) => const AddressesPage(),
  ),
  GoRoute(
    path: AppRoutes.accountSecurity,
    name: 'accountSecurity',
    redirect: _signedIn,
    builder: (context, state) => const AccountSecurityPage(),
  ),
  GoRoute(
    path: AppRoutes.accountPrivacy,
    name: 'accountPrivacy',
    redirect: _signedIn,
    builder: (context, state) => const AccountPrivacyPage(),
  ),
  GoRoute(
    path: AppRoutes.supportTickets,
    name: 'supportTickets',
    redirect: _signedIn,
    builder: (context, state) => const SupportTicketsPage(),
  ),
  GoRoute(
    path: AppRoutes.supportTicket,
    name: 'supportTicket',
    redirect: _signedIn,
    builder: (context, state) =>
        SupportTicketPage(ticketId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.offers,
    name: 'offers',
    redirect: _signedIn,
    builder: (context, state) => const OffersPage(),
  ),
  GoRoute(
    path: AppRoutes.referral,
    name: 'referral',
    redirect: _signedIn,
    builder: (context, state) => const ReferralPage(),
  ),
];

final GoRouterRedirect _signedIn = RouteGuard.requireAuth(
  signInPath: AppRoutes.login,
);
