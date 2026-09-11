import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Tiny rounded label chip used for categories & tags
/// (Figma "Rectangle 1060": 40×14, accent fill, 6–7px caps text).
class ArticleTagChip extends StatelessWidget {
  const ArticleTagChip({
    required this.label,
    super.key,
    this.filled = true,
    this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final chip = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: filled ? colors.chipSelected : colors.chipBackground,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.labelSmall?.copyWith(
          fontSize: 9,
          height: 1.2,
          fontWeight: FontWeight.w600,
          color: filled ? colors.onChipSelected : colors.textSecondary,
        ),
      ),
    );
    if (onTap == null) return chip;
    return GestureDetector(onTap: onTap, child: chip);
  }
}
