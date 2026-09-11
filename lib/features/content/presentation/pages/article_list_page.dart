import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/article.dart';
import '../cubit/article_list_cubit.dart';
import '../l10n/content_strings.dart';
import '../widgets/article_filter_panel.dart';
import '../widgets/article_format.dart';
import '../widgets/blog_card.dart';
import '../widgets/news_card.dart';

/// Blogs (`1489:3694`) and News (`1506:2769`) listing page.
///
/// Blogs render as a 2-column grid of [BlogCard]s, news as a single column
/// of [NewsCard]s. An [ArticleFilterPanel] and an ad slot sit on top; an
/// [EmptyView] replaces the list when the active filter matches nothing.
class ArticleListPage extends StatelessWidget {
  const ArticleListPage({required this.type, super.key});

  final ArticleType type;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ArticleListCubit>(param1: type)..load(),
    child: const _ArticleListView(),
  );
}

class _ArticleListView extends StatelessWidget {
  const _ArticleListView();

  @override
  Widget build(BuildContext context) {
    final strings = ContentStrings.of(context);
    return BlocBuilder<ArticleListCubit, ArticleListState>(
      builder: (context, state) {
        final cubit = context.read<ArticleListCubit>();
        final languageCode = ArticleFormat.languageCode(
          context,
          state.language,
        );
        final isBlog = state.type == ArticleType.blog;
        return Scaffold(
          appBar: AppTopBar(
            title: isBlog ? strings.blogs : strings.news,
            showBack: true,
          ),
          body: switch (state.articles) {
            Idle() || Loading() => const LoadingView(),
            Failed(:final failure) => ErrorView(
              message: failure.message,
              onRetry: cubit.load,
            ),
            Loaded() => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ArticleFilterPanel(
                      categories: state.categories,
                      tags: state.tags,
                      selectedCategory: state.categoryKey,
                      selectedTag: state.tagKey,
                      contentLanguageCode: languageCode,
                      onCategory: cubit.setCategory,
                      onTag: cubit.setTag,
                      onLanguage: cubit.setLanguage,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: AdBanner(
                    label: isBlog ? strings.blogsAds : strings.newsAds,
                    height: 70,
                    margin: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                  ),
                ),
                if (state.filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyView(
                      message: strings.noArticles,
                      icon: Icons.article_outlined,
                    ),
                  )
                else if (isBlog)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.xxl,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.lg,
                            crossAxisSpacing: 11,
                            mainAxisExtent: 200,
                          ),
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => BlogCard(
                          article: state.filtered[i],
                          languageCode: languageCode,
                          onTap: () => _open(context, state.filtered[i]),
                        ),
                        childCount: state.filtered.length,
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.xxl,
                    ),
                    sliver: SliverList.separated(
                      itemCount: state.filtered.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, i) => NewsCard(
                        article: state.filtered[i],
                        languageCode: languageCode,
                        onTap: () => _open(context, state.filtered[i]),
                      ),
                    ),
                  ),
              ],
            ),
          },
        );
      },
    );
  }

  void _open(BuildContext context, Article article) =>
      context.push(AppRoutes.contentDetailsPath(article.type.code, article.id));
}
