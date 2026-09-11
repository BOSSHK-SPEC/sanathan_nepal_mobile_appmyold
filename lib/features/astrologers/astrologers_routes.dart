import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'presentation/pages/astrologer_list_page.dart';
import 'presentation/pages/astrologer_profile_page.dart';
import 'presentation/pages/astrologer_search_page.dart';
import 'presentation/pages/following_page.dart';
import 'presentation/pages/write_review_page.dart';

/// Astrologer discovery routes.
///
/// `/astrologers/search` and `/astrologers/:id/review` are registered before
/// the parameterised `/astrologers/:id` so `search` is not swallowed as an id.
final List<RouteBase> astrologersRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.astrologers,
    name: 'astrologers',
    builder: (context, state) => const AstrologerListPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologersFollowing,
    name: 'astrologersFollowing',
    builder: (context, state) => const FollowingPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerSearch,
    name: 'astrologerSearch',
    builder: (context, state) => const AstrologerSearchPage(),
  ),
  GoRoute(
    path: AppRoutes.astrologerReview,
    name: 'astrologerReview',
    builder: (context, state) => WriteReviewPage(
      astrologerId: state.pathParameters['id'] ?? '',
      consultationId: state.uri.queryParameters['consultation'],
    ),
  ),
  GoRoute(
    path: AppRoutes.astrologerProfile,
    name: 'astrologerProfile',
    builder: (context, state) =>
        AstrologerProfilePage(astrologerId: state.pathParameters['id'] ?? ''),
  ),
];
