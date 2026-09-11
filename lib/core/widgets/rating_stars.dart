import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

/// Five-star rating row.
///
/// Read-only by default and renders fractional ratings with a half star;
/// passing [onChanged] turns it into a tappable 1–5 input.
///
/// Replaces the three feature-local copies that used to live in
/// marketplace / appointment / profile.
class RatingStars extends StatelessWidget {
  const RatingStars({
    required this.rating,
    super.key,
    this.size = 16,
    this.spacing = 2,
    this.onChanged,
    this.color,
    this.inactiveColor,
  });

  final double rating;
  final double size;
  final double spacing;

  /// When non-null the row becomes an input and reports 1–5.
  final ValueChanged<int>? onChanged;
  final Color? color;
  final Color? inactiveColor;

  bool get _interactive => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final active = color ?? colors.warning;
    final inactive = inactiveColor ?? colors.iconMuted.withValues(alpha: 0.4);

    return Semantics(
      label: _interactive ? 'Rating' : null,
      value: '${rating.toStringAsFixed(1)} out of 5',
      slider: _interactive,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (i) {
          final IconData icon;
          if (rating >= i + 1) {
            icon = Icons.star_rounded;
          } else if (rating > i) {
            icon = Icons.star_half_rounded;
          } else {
            icon = Icons.star_outline_rounded;
          }
          final star = Icon(
            icon,
            size: size,
            color: rating > i ? active : inactive,
          );
          return Padding(
            padding: EdgeInsets.only(right: i == 4 ? 0 : spacing),
            child: _interactive
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged!(i + 1),
                    child: star,
                  )
                : star,
          );
        }),
      ),
    );
  }
}

/// Compact "4.8 ★ (120)" summary used on cards where a full row is too wide.
class RatingSummary extends StatelessWidget {
  const RatingSummary({
    required this.rating,
    super.key,
    this.reviewCount,
    this.size = 14,
    this.style,
  });

  final double rating;
  final int? reviewCount;
  final double size;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = style ?? context.textTheme.labelMedium;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: size, color: colors.warning),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: text?.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: 3),
          Text(
            '($reviewCount)',
            style: text?.copyWith(color: colors.textMuted),
          ),
        ],
      ],
    );
  }
}
