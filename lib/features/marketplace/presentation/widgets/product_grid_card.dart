import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'product_photo.dart';
import '../../../../core/widgets/rating_stars.dart';

/// 170×212 product card (Figma "Group 36258"): photo with heart / checkbox,
/// stats strip (views, likes, stars), title, description, price | condition,
/// location and a seller / time-ago footer.
class ProductGridCard extends StatelessWidget {
  const ProductGridCard({
    required this.product,
    required this.onTap,
    super.key,
    this.onFavourite,
    this.selectable = false,
    this.selected = false,
    this.onSelectedChanged,
    this.onEdit,
    this.onDelete,
    this.now,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback? onFavourite;

  /// When true a checkbox replaces the heart (Boost "select your product").
  final bool selectable;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;

  /// Seller actions – when either is set a "more" menu (Edit / Delete) is
  /// shown on the photo ("My Products & Services").
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final lang = context.languageCode;
    final condition = product.condition == ProductCondition.used
        ? s.used
        : s.brandNew;
    return GestureDetector(
      onTap: selectable ? () => onSelectedChanged?.call(!selected) : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: selectable && selected ? colors.accent : colors.border,
            width: selectable && selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductPhoto(
                  product.primaryImage,
                  width: double.infinity,
                  height: 95,
                  radius: AppRadius.xs,
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: selectable
                      ? _SelectBox(selected: selected)
                      : _HeartButton(
                          active: product.isFavourite,
                          onTap: onFavourite,
                        ),
                ),
                if (onEdit != null || onDelete != null)
                  Positioned(
                    top: 3,
                    left: 3,
                    child: _OwnerMenu(
                      onEdit: onEdit,
                      onDelete: onDelete,
                      editLabel: s.edit,
                      deleteLabel: s.delete,
                    ),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _StatsStrip(product: product),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              product.titleFor(languageCode: lang),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              product.summaryFor(languageCode: lang),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 9,
                height: 1.15,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '${MarketplaceFormat.priceOf(context, product.price)} | $condition',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: colors.accent,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.location_on, size: 8, color: colors.accent),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    product.locationFor(languageCode: lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 8,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Divider(height: 8, thickness: 1, color: colors.divider),
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.seller.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  MarketplaceFormat.timeAgo(
                    context,
                    product.postedAt,
                    now: now,
                  ),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 8,
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsStrip extends StatelessWidget {
  const _StatsStrip({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = context.textTheme.labelSmall?.copyWith(
      fontSize: 8,
      color: colors.onPrimary,
      fontWeight: FontWeight.w600,
    );
    return Container(
      height: 14,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.black.withValues(alpha: 0.45),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    size: 9,
                    color: colors.onPrimary,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    MarketplaceFormat.countOf(context, product.views),
                    style: style,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(Icons.favorite_border, size: 9, color: colors.onPrimary),
                  const SizedBox(width: 2),
                  Text(
                    MarketplaceFormat.countOf(context, product.likes),
                    style: style,
                  ),
                ],
              ),
            ),
          ),
          RatingStars(rating: product.rating, size: 8),
        ],
      ),
    );
  }
}

/// Edit / Delete popup shown on the seller's own cards.
class _OwnerMenu extends StatelessWidget {
  const _OwnerMenu({
    required this.editLabel,
    required this.deleteLabel,
    this.onEdit,
    this.onDelete,
  });
  final String editLabel;
  final String deleteLabel;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return PopupMenuButton<VoidCallback>(
      tooltip: editLabel,
      padding: EdgeInsets.zero,
      onSelected: (action) => action(),
      itemBuilder: (_) => [
        if (onEdit != null)
          PopupMenuItem(
            value: onEdit,
            height: 36,
            child: Row(
              children: [
                Icon(Icons.edit_outlined, size: 16, color: colors.icon),
                const SizedBox(width: AppSpacing.sm),
                Text(editLabel),
              ],
            ),
          ),
        if (onDelete != null)
          PopupMenuItem(
            value: onDelete,
            height: 36,
            child: Row(
              children: [
                Icon(
                  Icons.delete_outline_rounded,
                  size: 16,
                  color: colors.error,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(deleteLabel),
              ],
            ),
          ),
      ],
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.more_horiz, size: 12, color: colors.textPrimary),
      ),
    );
  }
}

class _HeartButton extends StatelessWidget {
  const _HeartButton({required this.active, this.onTap});
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          active ? Icons.favorite : Icons.favorite_border,
          size: 11,
          color: active ? colors.error : colors.textPrimary,
        ),
      ),
    );
  }
}

class _SelectBox extends StatelessWidget {
  const _SelectBox({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? colors.accent : colors.surface,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: selected ? colors.accent : colors.border),
      ),
      child: selected
          ? Icon(Icons.check, size: 14, color: colors.onChipSelected)
          : null,
    );
  }
}
