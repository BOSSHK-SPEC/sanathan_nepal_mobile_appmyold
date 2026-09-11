import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/message_thread_page.dart';
import 'presentation/pages/message_threads_page.dart';

/// Routes pushed on top of the shell for messaging.
///
/// `/messages/business/:id` is registered before `/messages/:id` so the
/// literal segment is matched first rather than being read as a thread id.
final List<RouteBase> messagingRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.messages,
    name: 'messages',
    builder: (context, state) => const MessageThreadsPage(),
  ),
  GoRoute(
    path: AppRoutes.businessMessageThread,
    name: 'businessMessageThread',
    builder: (context, state) =>
        MessageThreadPage(businessId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.messageThread,
    name: 'messageThread',
    builder: (context, state) =>
        MessageThreadPage(threadId: state.pathParameters['id'] ?? ''),
  ),
];
