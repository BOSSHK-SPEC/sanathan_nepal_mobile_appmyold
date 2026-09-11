import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/article.dart';
import '../cubit/article_list_cubit.dart';
import '../l10n/content_strings.dart';
import '../widgets/article_format.dart';
import '../widgets/blog_card.dart';

/// Embeddable "Latest Blogs" / "Latest News" strip (section header with
/// "See All" + a horizontal row of [BlogCard]s) that Home or other pages can
/// drop in. It provides its own [ArticleListCubit], so callers need nothing
/// but the [type].
///
/// * [maxItems] caps the number of cards (newest first).
/// * [onSeeAll] – tapping the header / "See All"; defaults to pushing the
///   Blogs / News list route.
/// * Cards open the details route. Failed / empty states collapse to a
///   compact retry / nothing so the host page never breaks.
class LatestArticlesSection extends StatelessWidget {
  const LatestArticlesSection({
    required this.type,
    this.maxItems = 4,
    this.onSeeAll,
    super.key,
  });

  final ArticleType type;
  final int maxItems;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ArticleListCubit>(param1: type)..load(),
    child: _LatestArticlesView(maxItems: maxItems, onSeeAll: onSeeAll),
  );
}

class _LatestArticlesView extends StatelessWidget {
  const _LatestArticlesView({required this.maxItems, required this.onSeeAll});

  final int maxItems;
  final VoidCallback? onSeeAll;

  static const double _cardWidth = 170;
  static const double _cardHeight = 200;

  @override
  Widget build(BuildContext context) {
    final strings = ContentStrings.of(context);
    return BlocBuilder<ArticleListCubit, ArticleListState>(
      builder: (context, state) {
        final cubit = context.read<ArticleListCubit>();
        final isBlog = state.type == ArticleType.blog;
        final languageCode = ArticleFormat.languageCode(
          context,
          state.language,
        );
        final items = state.filtered.take(maxItems).toList();
        // Nothing to show – keep the host layout untouched.
        if (state.articles is Loaded && items.isEmpty) {
          return const SizedBox.shrink();
        }
        final seeAll =
            onSeeAll ??
            () => context.push(isBlog ? AppRoutes.blogs : AppRoutes.news);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionHeader(
              title: isBlog ? strings.latestBlogs : strings.latestNews,
              onTap: seeAll,
              trailing: TextButton(
                onPressed: seeAll,
                child: Text(
                  context.l10n.seeAll,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _cardHeight,
              child: switch (state.articles) {
                Idle() || Loading() => const LoadingView(),
                // Compact: the stock ErrorView is taller than the strip.
                Failed(:final failure) => _CompactError(
                  message: failure.message,
                  onRetry: cubit.load,
                ),
                Loaded() => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pageGutter,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, i) => SizedBox(
                    width: _cardWidth,
                    child: BlogCard(
                      article: items[i],
                      languageCode: languageCode,
                      onTap: () => context.push(
                        AppRoutes.contentDetailsPath(
                          items[i].type.code,
                          items[i].id,
                        ),
                      ),
                    ),
                  ),
                ),
              },
            ),
          ],
        );
      },
    );
  }
}

class _CompactError extends StatelessWidget {
  const _CompactError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 28, color: context.colors.error),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall,
          ),
          TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
        ],
      ),
    ),
  );
}
