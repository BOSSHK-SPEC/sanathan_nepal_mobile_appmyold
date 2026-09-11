import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/article.dart';
import 'article_format.dart';
import 'article_tag_chip.dart';

/// Grid card for a blog post (Figma "Group 36154": 170×190 – image 100h,
/// title, 2-line excerpt, date + category chip).
class BlogCard extends StatelessWidget {
  const BlogCard({
    required this.article,
    required this.languageCode,
    required this.onTap,
    super.key,
  });

  final Article article;

  /// Content language code (may differ from the app locale).
  final String languageCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.md,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 168 / 100,
            child: AppImage(
              article.imageAsset ?? '',
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm + 2,
                AppSpacing.sm,
                AppSpacing.sm + 2,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title.forLanguage(languageCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      article.excerpt.forLanguage(languageCode),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 11,
                        height: 1.35,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  // Date left, category chip right; on narrow columns the
                  // chip drops below the date instead of overflowing.
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: AppSpacing.xs,
                    runSpacing: 2,
                    children: [
                      Text(
                        ArticleFormat.date(
                          article.publishedAt,
                          languageCode: languageCode,
                          calendar: context.traditionalCalendar,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      ArticleTagChip(
                        label: article.category.label.forLanguage(languageCode),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
