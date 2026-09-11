import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/forex_page.dart';

/// Routes pushed on top of the shell for the forex feature.
final List<RouteBase> forexRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.forex,
    name: 'forex',
    builder: (context, state) => const ForexPage(),
  ),
];
