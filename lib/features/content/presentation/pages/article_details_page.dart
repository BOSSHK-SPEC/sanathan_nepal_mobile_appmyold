import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/article.dart';
import '../cubit/article_details_cubit.dart';
import '../l10n/content_strings.dart';
import '../widgets/article_format.dart';
import '../widgets/article_tag_chip.dart';
import '../widgets/blog_card.dart';
import '../widgets/content_language_toggle.dart';

/// Blog / News details page (Figma `1509:2943`): hero image, title, meta
/// line, language toggle, body paragraphs, tags, share / like row and a
/// "Recent Posts" grid.
class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({required this.type, required this.id, super.key});

  final ArticleType type;
  final String id;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ArticleDetailsCubit>()..load(id),
    child: _ArticleDetailsView(type: type),
  );
}

class _ArticleDetailsView extends StatelessWidget {
  const _ArticleDetailsView({required this.type});

  final ArticleType type;

  @override
  Widget build(BuildContext context) {
    final strings = ContentStrings.of(context);
    return BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
      builder: (context, state) => Scaffold(
        appBar: AppTopBar(
          title: type == ArticleType.blog ? strings.blogs : strings.news,
          showBack: true,
        ),
        body: switch (state.article) {
          Idle() || Loading() => const LoadingView(),
          Failed(:final failure) => ErrorView(message: failure.message),
          Loaded(:final data) => _Body(article: data, state: state),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.article, required this.state});

  final Article article;
  final ArticleDetailsState state;

  @override
  Widget build(BuildContext context) {
    final related = state.related.dataOrNull ?? const <Article>[];
    final languageCode = ArticleFormat.languageCode(context, state.language);
    final devanagari = ArticleFormat.devanagari(context, state.language);
    final strings = ContentStrings.of(context);
    final colors = context.colors;
    final textTheme = context.textTheme;
    final cubit = context.read<ArticleDetailsCubit>();
    final meta = [
      ArticleFormat.date(
        article.publishedAt,
        languageCode: languageCode,
        calendar: context.traditionalCalendar,
      ),
      '${strings.inCategory} '
          '${article.category.label.forLanguage(languageCode)}',
    ].join(' | ');
    final byline = [
      article.author.forLanguage(languageCode),
      ArticleFormat.readTime(
        article.readTimeMinutes,
        strings.minRead,
        devanagari: devanagari,
      ),
    ].join(' · ');

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xxl,
      ),
      children: [
        AppCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.md,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 348 / 190,
                child: AppImage(
                  article.imageAsset ?? '',
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            article.title.forLanguage(languageCode),
                            style: textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        ContentLanguageToggle(
                          languageCode: languageCode,
                          onChanged: cubit.setLanguage,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      meta,
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 11,
                        color: colors.textMuted,
                      ),
                    ),
                    Text(
                      byline,
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 11,
                        color: colors.textMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    for (final paragraph in article.body) ...[
                      Text(
                        paragraph.forLanguage(languageCode),
                        textAlign: TextAlign.justify,
                        style: textTheme.bodyMedium?.copyWith(
                          height: 1.55,
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    // Tags left, like + share right (Figma "Group 36189" /
                    // "Group 36190"); the actions drop to a new line on
                    // very narrow screens instead of overflowing.
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.xs,
                          children: [
                            ArticleTagChip(
                              label: article.category.label.forLanguage(
                                languageCode,
                              ),
                            ),
                            for (final t in article.tags)
                              ArticleTagChip(
                                label: t.label.forLanguage(languageCode),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _LikeButton(
                              article: article,
                              devanagari: devanagari,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Flexible(
                              child: _ShareButton(
                                article: article,
                                languageCode: languageCode,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (related.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(strings.recentPosts, style: textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: 11,
              mainAxisExtent: 200,
            ),
            itemCount: related.length,
            itemBuilder: (context, i) => BlogCard(
              article: related[i],
              languageCode: languageCode,
              onTap: () => context.push(
                AppRoutes.contentDetailsPath(
                  related[i].type.code,
                  related[i].id,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton({required this.article, required this.devanagari});

  final Article article;
  final bool devanagari;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      toggled: article.isLiked,
      label: ContentStrings.of(context).like,
      child: InkWell(
        onTap: context.read<ArticleDetailsCubit>().toggleLike,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                article.isLiked ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: article.isLiked ? colors.accent : colors.iconMuted,
              ),
              const SizedBox(width: 2),
              Text(
                ArticleFormat.number(article.likes, devanagari: devanagari),
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.article, required this.languageCode});

  final Article article;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final strings = ContentStrings.of(context);
    final colors = context.colors;
    return Semantics(
      button: true,
      child: InkWell(
        onTap: () async {
          final link =
              'https://sanatannepal.app'
              '${AppRoutes.contentDetailsPath(article.type.code, article.id)}';
          await Clipboard.setData(
            ClipboardData(
              text: '${article.title.forLanguage(languageCode)}\n$link',
            ),
          );
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(strings.linkCopied)));
        },
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  strings.sharePost,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    color: colors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(Icons.share_outlined, size: 18, color: colors.accent),
            ],
          ),
        ),
      ),
    );
  }
}
