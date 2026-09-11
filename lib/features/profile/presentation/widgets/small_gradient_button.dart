import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Compact gradient chip-button (Figma "Button/Primary" 20–30px tall) used
/// for Call / Chat / Accept / Cancel / Complete actions on cards.
class SmallGradientButton extends StatelessWidget {
  const SmallGradientButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.height = 24,
    this.outlined = false,
    this.color,
    this.radius = AppRadius.sm,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double height;

  /// Renders as a bordered pill (e.g. "Cancel Order").
  final bool outlined;

  /// Solid colour override (e.g. status green for "Completed").
  final Color? color;

  /// Corner radius (use [AppRadius.pill] for pill buttons).
  final double radius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = outlined ? colors.accent : colors.onPrimary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            gradient: outlined || color != null ? null : colors.primaryGradient,
            color: color,
            border: outlined ? Border.all(color: colors.accent) : null,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 12, color: fg),
                const SizedBox(width: 3),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: fg,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
