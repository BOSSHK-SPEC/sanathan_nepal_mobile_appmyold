import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'domain/entities/article.dart';
import 'presentation/pages/article_details_page.dart';
import 'presentation/pages/article_list_page.dart';

/// Routes pushed on top of the shell for the content feature.
final List<RouteBase> contentRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.blogs,
    name: 'blogs',
    builder: (context, state) => const ArticleListPage(type: ArticleType.blog),
  ),
  GoRoute(
    path: AppRoutes.news,
    name: 'news',
    builder: (context, state) => const ArticleListPage(type: ArticleType.news),
  ),
  GoRoute(
    path: AppRoutes.contentDetails,
    name: 'contentDetails',
    builder: (context, state) => ArticleDetailsPage(
      type: ArticleType.fromCode(state.pathParameters['type']),
      id: state.pathParameters['id'] ?? '',
    ),
  ),
];
