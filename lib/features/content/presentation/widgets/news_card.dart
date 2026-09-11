import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/article.dart';
import 'article_format.dart';
import 'article_tag_chip.dart';

/// Full-width news card (Figma `1506:2821`: 350×238 – image 120h, 2-line
/// title, 3-line excerpt, date + tag chips).
class NewsCard extends StatelessWidget {
  const NewsCard({
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
            aspectRatio: 348 / 120,
            child: AppImage(
              article.imageAsset ?? '',
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm + 2,
              AppSpacing.sm,
              AppSpacing.sm + 2,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title.forLanguage(languageCode),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  article.excerpt.forLanguage(languageCode),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    height: 1.35,
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                // Date left, tag chips right (Figma "Group 36146/36169");
                // chips wrap under the date when there is no room.
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
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
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        for (final tag in article.tags)
                          ArticleTagChip(
                            label: tag.label.forLanguage(languageCode),
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
    );
  }
}
