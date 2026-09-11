import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/notifications_page.dart';

/// Routes pushed on top of the shell for the notifications feature.
final List<RouteBase> notificationsRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.notifications,
    name: 'notifications',
    builder: (context, state) => const NotificationsPage(),
  ),
  GoRoute(
    path: AppRoutes.notificationSettings,
    name: 'notificationSettings',
    builder: (context, state) => const NotificationSettingsPage(),
  ),
];
