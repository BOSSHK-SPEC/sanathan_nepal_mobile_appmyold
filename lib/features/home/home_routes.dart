import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/home_page.dart';

/// Root page of the 'home' bottom-nav branch.
final GoRoute homeTabRoute = GoRoute(
  path: AppRoutes.home,
  name: 'home',
  builder: (context, state) => const HomePage(),
);

/// Routes pushed on top of the shell for the home feature (none – Home only
/// composes other features' sections).
final List<RouteBase> homeRoutes = <RouteBase>[];
