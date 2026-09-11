import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/marketplace_strings.dart';
import 'cart_icon_button.dart';
import 'product_photo.dart';

/// Top of the details page (Figma "Ellipse 3917" / "pearl" / "Frame 3861"):
/// a large tinted circle behind the 315×250 hero image, a back arrow and
/// bag badge on the top row, share / heart (and edit for the seller's own
/// listing) beside the photo, then a strip of 60 px thumbnails.
class ProductHero extends StatelessWidget {
  const ProductHero({
    required this.images,
    required this.selectedIndex,
    required this.onSelected,
    required this.isFavourite,
    required this.onFavourite,
    required this.onShare,
    super.key,
    this.onEdit,
    this.maxThumbnails = 6,
  });

  final List<String> images;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool isFavourite;
  final VoidCallback onFavourite;
  final VoidCallback onShare;

  /// Shown only when the viewer owns the listing.
  final VoidCallback? onEdit;
  final int maxThumbnails;

  static const double heroWidth = 315;
  static const double heroHeight = 250;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final current = images.isEmpty
        ? ''
        : images[selectedIndex.clamp(0, images.length - 1)];
    final thumbs = images.take(maxThumbnails).toList();
    return Column(
      children: [
        SizedBox(
          height: heroHeight + 96,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              // Ellipse 3917 – 595 px circle peeking in from the top.
              Positioned(
                top: -330,
                child: IgnorePointer(
                  child: Container(
                    width: 595,
                    height: 595,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: colors.cardGradient,
                    ),
                  ),
                ),
              ),
              // Back arrow (Vector 5) + bag badge (Group 21).
              Positioned(
                top: AppSpacing.md,
                left: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Row(
                  children: [
                    IconButton(
                      tooltip: MaterialLocalizations.of(
                        context,
                      ).backButtonTooltip,
                      icon: Icon(Icons.arrow_back_ios_new, color: colors.icon),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    const Spacer(),
                    const CartIconButton(),
                  ],
                ),
              ),
              // Hero photo ("pearl" 315×250).
              Positioned(
                top: 60,
                child: Container(
                  width: heroWidth,
                  height: heroHeight,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ProductPhoto(
                    current,
                    width: heroWidth,
                    height: heroHeight,
                    fit: BoxFit.contain,
                    iconSize: 72,
                  ),
                ),
              ),
              // Share / heart / edit column on the right edge of the photo.
              Positioned(
                top: 72,
                right: 22,
                child: Column(
                  children: [
                    _RoundAction(
                      icon: Icons.share_outlined,
                      label: s.share,
                      onTap: onShare,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _RoundAction(
                      icon: isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      label: s.favourite,
                      color: isFavourite ? colors.error : null,
                      onTap: onFavourite,
                    ),
                    if (onEdit != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      _RoundAction(
                        icon: Icons.edit_outlined,
                        label: s.edit,
                        onTap: onEdit!,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        // Frame 3861 – thumbnail strip.
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: thumbs.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, i) => Semantics(
              button: true,
              selected: i == selectedIndex,
              child: GestureDetector(
                onTap: () => onSelected(i),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: i == selectedIndex ? colors.accent : colors.border,
                      width: i == selectedIndex ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ProductPhoto(thumbs[i], iconSize: 24),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.92),
            shape: BoxShape.circle,
            border: Border.all(color: colors.border),
          ),
          child: Icon(icon, size: 17, color: color ?? colors.icon),
        ),
      ),
    );
  }
}
