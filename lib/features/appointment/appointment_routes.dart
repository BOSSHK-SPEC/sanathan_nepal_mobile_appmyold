import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/appointment_details_page.dart';
import 'presentation/pages/book_appointment_route_page.dart';
import 'presentation/pages/my_appointments_page.dart';
import 'presentation/pages/astrologer_picker_page.dart';

/// Routes pushed on top of the shell for the appointment feature.
///
/// `/appointments` is the user's own bookings, and `/appointments/astrologers`
/// is who you can book. Tapping one opens their profile in the astrologers
/// feature (`/astrologers/:id`) rather than a second, near-identical bio here —
/// there is one astrologer profile in the app, and this is not it.
///
/// The literal paths are registered before `/appointments/:id` so `astrologers`
/// and `astrologer` are not captured as appointment ids.
final List<RouteBase> appointmentRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.appointments,
    name: 'appointments',
    builder: (context, state) => MyAppointmentsPage(
      // `?tab=1` opens the past list; anything else opens upcoming. The old
      // route took a 0-4 astrologer-tab index, so a stale deep link lands on
      // Upcoming rather than on a wrong screen.
      initialTab: state.uri.queryParameters['tab'] == '1' ? 1 : 0,
    ),
  ),
  GoRoute(
    path: AppRoutes.appointmentAstrologers,
    name: 'appointmentAstrologers',
    builder: (context, state) => const AstrologerPickerPage(),
  ),
  // Booking wizard. Registered before `/appointments/:id` so `book` isn't
  // captured as an appointment id. The astrologer is addressed by id rather
  // than passed through `extra`, so the URL survives a cold start, a reload
  // and a push-notification tap.
  GoRoute(
    path: AppRoutes.appointmentBook,
    name: 'appointmentBook',
    builder: (context, state) => BookAppointmentRoutePage(
      astrologerId: state.pathParameters['astrologerId'] ?? '',
      initialServiceId: state.uri.queryParameters['service'],
    ),
  ),
  GoRoute(
    path: AppRoutes.appointmentDetails,
    name: 'appointmentDetails',
    builder: (context, state) =>
        AppointmentDetailsPage(id: state.pathParameters['id'] ?? ''),
  ),
];
