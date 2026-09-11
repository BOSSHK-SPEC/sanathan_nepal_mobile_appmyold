import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/session/permission.dart';
import '../../core/session/route_guard.dart';
import 'presentation/pages/admin_businesses_page.dart';
import 'presentation/pages/business_form_page.dart';
import 'presentation/pages/business_profile_page.dart';
import 'presentation/pages/edit_profile_page.dart';
import 'presentation/pages/my_business_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/support_page.dart';

/// Root page of the 'profile' bottom-nav branch.
final GoRoute profileTabRoute = GoRoute(
  path: AppRoutes.profile,
  name: 'profile',
  builder: (context, state) => const ProfilePage(),
);

/// Routes pushed on top of the shell for the profile feature.
///
/// `businessForm` ('/business/form') and `myBusiness` ('/business/mine') are
/// registered before the parameterised `businessProfile` ('/business/:id')
/// so they are matched first. `/business/:id?mode=owner|admin` selects the
/// [BusinessProfileMode]; `/admin/businesses` is guarded by
/// [Permission.approveBusiness] and sends anyone else to the profile tab.
final List<RouteBase> profileRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.editProfile,
    name: 'editProfile',
    builder: (context, state) => const EditProfilePage(),
  ),
  GoRoute(
    path: AppRoutes.businessForm,
    name: 'businessForm',
    builder: (context, state) =>
        BusinessFormPage(businessId: state.uri.queryParameters['id']),
  ),
  GoRoute(
    path: AppRoutes.myBusiness,
    name: 'myBusiness',
    builder: (context, state) => const MyBusinessPage(),
  ),
  GoRoute(
    path: AppRoutes.businessProfile,
    name: 'businessProfile',
    builder: (context, state) => BusinessProfilePage(
      businessId: state.pathParameters['id'] ?? '',
      mode: BusinessProfileMode.fromQuery(state.uri.queryParameters['mode']),
    ),
  ),
  GoRoute(
    path: AppRoutes.adminBusinesses,
    name: 'adminBusinesses',
    redirect: RouteGuard.require(
      Permission.approveBusiness,
      fallback: AppRoutes.profile,
    ),
    builder: (context, state) => const AdminBusinessesPage(),
  ),
  GoRoute(
    path: AppRoutes.support,
    name: 'support',
    builder: (context, state) => const SupportPage(),
  ),
];
