import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/session/permission.dart';
import '../../core/session/route_guard.dart';
import 'presentation/pages/analytics_page.dart';
import 'presentation/pages/application_status_page.dart';
import 'presentation/pages/astrologer_profile_page.dart';
import 'presentation/pages/boost_page.dart';
import 'presentation/pages/apply_intro_page.dart';
import 'presentation/pages/compliance_page.dart';
import 'presentation/pages/client_detail_page.dart';
import 'presentation/pages/clients_page.dart';
import 'presentation/pages/console_appointment_detail_page.dart';
import 'presentation/pages/console_appointments_page.dart';
import 'presentation/pages/console_dashboard_page.dart';
import 'presentation/pages/earnings_page.dart';
import 'presentation/pages/kyc_wizard_page.dart';
import 'presentation/pages/payouts_page.dart';
import 'presentation/pages/pricing_page.dart';
import 'presentation/pages/reviews_inbox_page.dart';
import 'presentation/pages/schedule_page.dart';
import 'presentation/pages/work_settings_page.dart';

/// The astrologer shell's four tabs.
///
/// Exposed as branches rather than routes so the router can host them in a
/// second [StatefulShellRoute] — the astrologer's side of the app has its
/// own navigation stack, independent of the seeker's.
List<StatefulShellBranch> astrologerShellBranches(
  GlobalKey<NavigatorState> rootKey,
) => [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.astrologerHome,
        name: 'astrologerHome',
        redirect: consoleGuard,
        builder: (context, state) => const ConsoleDashboardPage(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.astrologerSchedule,
        name: 'astrologerSchedule',
        redirect: RouteGuard.require(
          Permission.manageAvailability,
          fallback: AppRoutes.astrologerApply,
        ),
        builder: (context, state) => const SchedulePage(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.astrologerEarnings,
        name: 'astrologerEarnings',
        redirect: RouteGuard.require(
          Permission.viewEarnings,
          fallback: AppRoutes.astrologerApply,
        ),
        builder: (context, state) => const ConsoleEarningsPage(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.astrologerClients,
        name: 'astrologerClients',
        redirect: consoleGuard,
        builder: (context, state) => const ClientsPage(),
        routes: [
          // Pushed over the shell so the client's detail covers the tab bar,
          // the way a drill-down should.
          GoRoute(
            path: ':id',
            name: 'astrologerClient',
            parentNavigatorKey: rootKey,
            builder: (context, state) =>
                ClientDetailPage(clientId: state.pathParameters['id'] ?? ''),
          ),
        ],
      ),
    ],
  ),
];

/// Console routes that sit outside the shell: the application flow (which an
/// applicant reaches before they have a console at all) and the drill-downs
/// that deliberately cover the tab bar.
final List<RouteBase> astrologerRootRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.astrologerApply,
    name: 'astrologerApply',
    redirect: RouteGuard.require(
      Permission.applyAsAstrologer,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => const ApplyIntroPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerKyc,
    name: 'astrologerKyc',
    redirect: RouteGuard.require(
      Permission.applyAsAstrologer,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => const KycWizardPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerApplication,
    name: 'astrologerApplication',
    redirect: RouteGuard.require(
      Permission.applyAsAstrologer,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => const ApplicationStatusPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerPayoutAccount,
    name: 'astrologerPayoutAccount',
    redirect: payoutGuard,
    builder: (context, state) => const PayoutAccountPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerWithdraw,
    name: 'astrologerWithdraw',
    redirect: payoutGuard,
    builder: (context, state) => const WithdrawPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerPayouts,
    name: 'astrologerPayouts',
    redirect: payoutGuard,
    builder: (context, state) => const PayoutsPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerTax,
    name: 'astrologerTax',
    redirect: payoutGuard,
    builder: (context, state) => const TaxDocumentsPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerMyProfile,
    name: 'astrologerMyProfile',
    redirect: RouteGuard.require(
      Permission.viewAstrologerConsole,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) => const AstrologerProfilePage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerCompliance,
    name: 'astrologerCompliance',
    redirect: RouteGuard.require(
      Permission.viewAstrologerConsole,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) => const CompliancePage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerWorkSettings,
    name: 'astrologerWorkSettings',
    redirect: RouteGuard.require(
      Permission.viewAstrologerConsole,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) => const WorkSettingsPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerPricing,
    name: 'astrologerPricing',
    redirect: RouteGuard.require(
      Permission.managePricing,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) => const ConsolePricingPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerReviews,
    name: 'astrologerReviews',
    redirect: RouteGuard.require(
      Permission.replyToReview,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) => const ReviewsInboxPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerBoost,
    name: 'astrologerBoost',
    redirect: RouteGuard.require(
      Permission.purchaseBoost,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) => const ConsoleBoostPage(),
  ),
  // Booked sittings. Outside the shell: a list the astrologer opens from the
  // console home, with each appointment pushed over it.
  GoRoute(
    path: AppRoutes.astrologerAppointments,
    name: 'astrologerAppointments',
    redirect: consoleGuard,
    builder: (context, state) => const ConsoleAppointmentsPage(),
    routes: [
      GoRoute(
        path: ':id',
        name: 'astrologerAppointment',
        builder: (context, state) => ConsoleAppointmentDetailPage(
          appointmentId: state.pathParameters['id'] ?? '',
        ),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.astrologerAnalytics,
    name: 'astrologerAnalytics',
    redirect: RouteGuard.require(
      Permission.viewEarnings,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) => const ConsoleAnalyticsPage(),
  ),
];

/// Anyone without the console permission is sent to the application flow
/// rather than to Home — that is what they were looking for.
final GoRouterRedirect consoleGuard = RouteGuard.require(
  Permission.viewAstrologerConsole,
  fallback: AppRoutes.astrologerApply,
);

final GoRouterRedirect payoutGuard = RouteGuard.require(
  Permission.requestPayout,
  fallback: AppRoutes.astrologerApply,
);
