import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/my_pujas_page.dart';
import 'presentation/pages/puja_booking_page.dart';
import 'presentation/pages/puja_catalogue_page.dart';
import 'presentation/pages/puja_details_page.dart';

/// Online puja routes.
///
/// `/pujas/mine` and `/pujas/booking/:id` are registered before `/pujas/:id`
/// so neither is swallowed as a service id.
final List<RouteBase> pujaRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.pujas,
    name: 'pujas',
    builder: (context, state) => const PujaCataloguePage(),
  ),
  GoRoute(
    path: AppRoutes.myPujas,
    name: 'myPujas',
    builder: (context, state) => const MyPujasPage(),
  ),
  GoRoute(
    path: AppRoutes.pujaBooking,
    name: 'pujaBooking',
    builder: (context, state) =>
        PujaBookingPage(bookingId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.pujaDetails,
    name: 'pujaDetails',
    builder: (context, state) =>
        PujaDetailsPage(serviceId: state.pathParameters['id'] ?? ''),
  ),
];
