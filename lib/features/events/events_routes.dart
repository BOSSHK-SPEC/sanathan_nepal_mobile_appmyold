import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'domain/entities/event.dart';
import 'domain/entities/event_category.dart';
import 'presentation/pages/event_details_page.dart';
import 'presentation/pages/event_form_page.dart';
import 'presentation/pages/events_page.dart';

/// Routes pushed on top of the shell for the events feature.
///
/// `eventCreate` ('/events/new') is registered before `eventDetails`
/// ('/events/:id') so "new" is not captured as an id.
/// * `/events?tab=festival|personal|todo` – opens a specific tab.
/// * `/events/new` – `extra` may be an [Event] (edit when its id is set,
///   otherwise used as a template) or a [DateTime] (pre-selected day, e.g.
///   from the date converter). Pops with the saved [Event].
final List<RouteBase> eventsRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.events,
    name: 'events',
    builder: (context, state) => EventsPage(
      initialGroup: EventGroup.values.firstWhere(
        (g) => g.name == state.uri.queryParameters['tab'],
        orElse: () => EventGroup.festival,
      ),
    ),
  ),
  GoRoute(
    path: AppRoutes.eventCreate,
    name: 'eventCreate',
    builder: (context, state) => EventFormPage(
      initial: state.extra is Event ? state.extra! as Event : null,
      initialDate: state.extra is DateTime ? state.extra! as DateTime : null,
    ),
  ),
  GoRoute(
    path: AppRoutes.eventDetails,
    name: 'eventDetails',
    builder: (context, state) =>
        EventDetailsPage(eventId: state.pathParameters['id'] ?? ''),
  ),
];
