import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/account/account_routes.dart';
import '../../features/appointment/appointment_routes.dart';
import '../../features/astrologer_console/astrologer_console_routes.dart';
import '../../features/astrologer_console/presentation/pages/astrologer_shell_page.dart';
import '../../features/astrologers/astrologers_routes.dart';
import '../../features/calendar/calendar_routes.dart';
import '../../features/consultation/consultation_routes.dart';
import '../../features/content/content_routes.dart';
import '../../features/date_converter/date_converter_routes.dart';
import '../../features/events/events_routes.dart';
import '../../features/forex/forex_routes.dart';
import '../../features/home/home_routes.dart';
import '../../features/horoscope/horoscope_routes.dart';
import '../../features/kundli/kundli_routes.dart';
import '../../features/legal/legal_routes.dart';
import '../../features/marketplace/marketplace_routes.dart';
import '../../features/messaging/messaging_routes.dart';
import '../../features/notifications/notifications_routes.dart';
import '../../features/onboarding/onboarding_routes.dart';
import '../../features/orders/orders_routes.dart';
import '../../features/puja/puja_routes.dart';
import '../../features/reports/reports_routes.dart';
import '../../features/panchanga/panchanga_routes.dart';
import '../../features/profile/profile_routes.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';
import '../../features/wallet/wallet_routes.dart';
import '../../features/weather/weather_routes.dart';

/// Composes the app router from per-feature route lists (OCP: adding a
/// feature means adding one import + one spread, nothing else changes).
abstract final class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static GoRouter create({String initialLocation = '/'}) => GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    debugLogDiagnostics: false,
    routes: <RouteBase>[
      ...onboardingRoutes,
      // Seeker shell: Home · Marketplace · Horoscope · Profile.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShellPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [homeTabRoute]),
          StatefulShellBranch(routes: [marketplaceTabRoute]),
          StatefulShellBranch(routes: [horoscopeTabRoute]),
          StatefulShellBranch(routes: [profileTabRoute]),
        ],
      ),
      // Astrologer shell: Queue · Schedule · Earnings · Clients. A separate
      // shell, not extra tabs — the two sides navigate independently and a
      // dual-role user switches between them rather than mixing them.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AstrologerShellPage(navigationShell: navigationShell),
        branches: astrologerShellBranches(rootNavigatorKey),
      ),
      ...marketplaceRoutes,
      ...profileRoutes,
      ...messagingRoutes,
      ...calendarRoutes,
      ...dateConverterRoutes,
      ...weatherRoutes,
      ...forexRoutes,
      ...panchangaRoutes,
      ...eventsRoutes,
      ...appointmentRoutes,
      ...astrologersRoutes,
      ...walletRoutes,
      ...consultationRoutes,
      ...kundliRoutes,
      ...astrologerRootRoutes,
      ...ordersRoutes,
      ...pujaRoutes,
      ...reportsRoutes,
      ...accountRoutes,
      ...notificationsRoutes,
      ...legalRoutes,
      ...contentRoutes,
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
}
