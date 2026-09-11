import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/chart_form_page.dart';
import 'presentation/pages/chart_page.dart';
import 'presentation/pages/gun_milan_page.dart';
import 'presentation/pages/saved_charts_page.dart';

/// Kundli routes.
///
/// `/kundli/new` and `/kundli/match` come before `/kundli/:id` so they are
/// not matched as chart ids. No permission guard: a chart is computed on the
/// device from data the user types, so it works signed out.
final List<RouteBase> kundliRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.kundli,
    name: 'kundli',
    builder: (context, state) => const SavedChartsPage(),
  ),
  GoRoute(
    path: AppRoutes.kundliNew,
    name: 'kundliNew',
    builder: (context, state) => const ChartFormPage(),
  ),
  GoRoute(
    path: AppRoutes.kundliMatch,
    name: 'kundliMatch',
    builder: (context, state) => const GunMilanPage(),
  ),
  GoRoute(
    path: AppRoutes.kundliChart,
    name: 'kundliChart',
    builder: (context, state) =>
        ChartPage(profileId: state.pathParameters['id'] ?? ''),
  ),
];
