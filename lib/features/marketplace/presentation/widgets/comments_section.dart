import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product_comment.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';

/// Comment thread + composer (Figma "cmnts" / "no cmnts").
class CommentsSection extends StatelessWidget {
  const CommentsSection({required this.comments, super.key, this.now});

  final List<ProductComment> comments;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (comments.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Column(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 40,
                  color: colors.accent,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  s.noComments,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          for (final c in comments)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: colors.chipBackground,
                    child: Text(
                      c.author.isEmpty ? '?' : c.author[0],
                      style: context.textTheme.labelMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: c.author,
                                style: context.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '  ·  ${MarketplaceFormat.timeAgo(context, c.postedAt, now: now)}',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colors.surfaceVariant,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Text(
                            c.message,
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              s.reply,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.accent,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(Icons.reply, size: 12, color: colors.accent),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: colors.chipBackground,
              child: Icon(
                Icons.person_outline,
                size: 18,
                color: colors.iconMuted,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: TextField(
                style: context.textTheme.bodySmall,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: s.commentHint,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 10,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        size: 18,
                        color: colors.iconMuted,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(Icons.send_rounded, size: 18, color: colors.accent),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
