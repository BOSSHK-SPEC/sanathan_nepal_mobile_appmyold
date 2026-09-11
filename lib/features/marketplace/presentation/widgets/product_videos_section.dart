import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'product_photo.dart';

/// "Product Videos" card (Figma dark Product Details "Group 36319"): a
/// 260×340 poster with a play badge, the seller row ("Dr. Uttam Upadhyaya ·
/// @uttam_guru . 1 hour ago") and a caption. Videos are links only – tapping
/// the poster reports [onPlay].
class ProductVideosSection extends StatelessWidget {
  const ProductVideosSection({
    required this.product,
    required this.onPlay,
    super.key,
    this.now,
  });

  final Product product;
  final ValueChanged<String> onPlay;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    if (product.videos.isEmpty) return const SizedBox.shrink();
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final t = context.textTheme;
    final seller = product.seller;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.productVideos,
            style: t.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          Divider(height: AppSpacing.lg, color: colors.divider),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 260),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    button: true,
                    label: s.productVideos,
                    child: GestureDetector(
                      onTap: () => onPlay(product.videos.first),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ProductPhoto(
                              product.primaryImage,
                              width: double.infinity,
                              height: 180,
                              iconSize: 48,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.35),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_circle_outline,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: colors.chipBackground,
                        child: Icon(
                          Icons.person_outline,
                          size: 18,
                          color: colors.iconMuted,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seller.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: t.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${seller.handle ?? ''} · ${MarketplaceFormat.timeAgo(context, product.postedAt, now: now)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: t.labelSmall?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    product.summaryFor(languageCode: context.languageCode),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: t.bodySmall?.copyWith(color: colors.textSecondary),
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
