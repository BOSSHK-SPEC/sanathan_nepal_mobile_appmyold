import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/patro_page.dart';

/// Routes pushed on top of the shell for the calendar feature.
final List<RouteBase> calendarRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.patro,
    name: 'patro',
    builder: (context, state) => const PatroPage(),
  ),
];
