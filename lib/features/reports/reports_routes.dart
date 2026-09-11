import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/my_reports_page.dart';
import 'presentation/pages/report_delivery_page.dart';
import 'presentation/pages/report_details_page.dart';
import 'presentation/pages/reports_catalogue_page.dart';

/// Paid PDF report routes.
///
/// `/reports/mine` is registered before `/reports/:id` so the library is not
/// swallowed as a product id.
final List<RouteBase> reportsRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.reports,
    name: 'reports',
    builder: (context, state) => const ReportsCataloguePage(),
  ),
  GoRoute(
    path: AppRoutes.myReports,
    name: 'myReports',
    builder: (context, state) => const MyReportsPage(),
  ),
  GoRoute(
    path: AppRoutes.reportDelivery,
    name: 'reportDelivery',
    builder: (context, state) =>
        ReportDeliveryPage(reportId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.reportDetails,
    name: 'reportDetails',
    builder: (context, state) =>
        ReportDetailsPage(productId: state.pathParameters['id'] ?? ''),
  ),
];
