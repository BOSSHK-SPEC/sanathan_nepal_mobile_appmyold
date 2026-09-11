import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/date_converter_page.dart';

/// Routes pushed on top of the shell for the date_converter feature.
final List<RouteBase> dateConverterRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.dateConverter,
    name: 'dateConverter',
    builder: (context, state) => const DateConverterPage(),
  ),
];
