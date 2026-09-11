import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/horoscope_page.dart';

/// Root page of the 'horoscope' bottom-nav branch.
final GoRoute horoscopeTabRoute = GoRoute(
  path: AppRoutes.horoscope,
  name: 'horoscope',
  builder: (context, state) => const HoroscopePage(),
);

/// Routes pushed on top of the shell for the horoscope feature.
final List<RouteBase> horoscopeRoutes = <RouteBase>[];
