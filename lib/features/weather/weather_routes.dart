import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/weather_page.dart';

/// Routes pushed on top of the shell for the weather feature.
final List<RouteBase> weatherRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.weather,
    name: 'weather',
    builder: (context, state) => const WeatherPage(),
  ),
];
