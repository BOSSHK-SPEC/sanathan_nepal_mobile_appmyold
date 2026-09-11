import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'product_photo.dart';

/// Photo strip for the seller form.
///
/// Photos are **optional**: a listing published without one renders a themed
/// category placeholder, and the server accepts an empty image list. The
/// header says so outright rather than leaving a seller to discover it by
/// trying to publish — an unmarked media field reads as required, and a seller
/// with no picture to hand simply abandons the form.
///
/// Two ways to discard, because they answer different intents: the badge on a
/// thumbnail removes the one that is wrong, and "Remove all" clears a set
/// picked for the wrong listing without six separate taps.
class ProductImagePicker extends StatelessWidget {
  const ProductImagePicker({
    required this.images,
    required this.onAdd,
    required this.onRemove,
    super.key,
    this.onRemoveAll,
    this.maxImages = 6,
  });

  final List<String> images;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  /// Clears every photo. Hidden when null or when there is nothing to clear.
  final VoidCallback? onRemoveAll;
  final int maxImages;

  /// Large enough to hold a 48×48 remove target inside its own bounds, so the
  /// target never overlaps the neighbouring thumbnail and steal its taps.
  static const double _tile = 84;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${s.photos} (${MarketplaceFormat.digits(context, images.length)}/${MarketplaceFormat.digits(context, maxImages)})',
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s.photosOptional,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (images.isNotEmpty && onRemoveAll != null)
              TextButton.icon(
                onPressed: onRemoveAll,
                icon: Icon(Icons.delete_sweep_outlined, size: 18, color: colors.error),
                label: Text(
                  s.removeAllPhotos,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.error,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (var i = 0; i < images.length; i++)
              _Thumbnail(
                source: images[i],
                // 1-based for the reader: "photo 1 of 3", not "photo 0".
                position: i + 1,
                total: images.length,
                onRemove: () => onRemove(i),
              ),
            if (images.length < maxImages) _AddTile(onTap: onAdd),
          ],
        ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.source,
    required this.position,
    required this.total,
    required this.onRemove,
  });

  final String source;
  final int position;
  final int total;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);

    return Semantics(
      label: '${s.photos} $position/$total',
      child: SizedBox(
        width: ProductImagePicker._tile,
        height: ProductImagePicker._tile,
        child: Stack(
          children: [
            Positioned.fill(
              child: ProductPhoto(
                source,
                radius: AppRadius.md,
                iconSize: 28,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              // 48×48 of hit area around a 22px visual: the old badge was 18px
              // with no padding, well under any usable target, and sat outside
              // the tile where it could overlap the next thumbnail.
              child: Tooltip(
                message: s.removePhoto,
                child: Semantics(
                  button: true,
                  label: '${s.removePhoto} $position',
                  child: InkWell(
                    onTap: onRemove,
                    customBorder: const CircleBorder(),
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(child: _RemoveBadge()),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemoveBadge extends StatelessWidget {
  const _RemoveBadge();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: colors.error,
        shape: BoxShape.circle,
        border: Border.all(color: colors.surface, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(Icons.close_rounded, size: 13, color: colors.onPrimary),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);

    return Semantics(
      button: true,
      label: s.addPhoto,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          width: ProductImagePicker._tile,
          height: ProductImagePicker._tile,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: colors.accent),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo_outlined,
                size: 22,
                color: colors.accent,
              ),
              const SizedBox(height: 4),
              Text(
                s.addPhoto,
                textAlign: TextAlign.center,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
