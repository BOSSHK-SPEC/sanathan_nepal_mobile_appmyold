import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/panchanga_page.dart';

/// Routes pushed on top of the shell for the panchanga feature.
///
/// Optional query `?date=YYYY-MM-DD` opens a specific day.
final List<RouteBase> panchangaRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.panchanga,
    name: 'panchanga',
    builder: (context, state) => PanchangaPage(
      initialDate: DateTime.tryParse(state.uri.queryParameters['date'] ?? ''),
    ),
  ),
];
