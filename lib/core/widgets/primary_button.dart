import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Gradient pill button ("Button/Primary" in Figma).
///
/// Light: orange→yellow, Dark: violet→magenta – both come from
/// [AppColors.primaryGradient] so callers never pick colours themselves.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.expanded = true,
    this.height = 42,
    this.isLoading = false,
    this.icon,
    this.radius = AppRadius.pill,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expanded;
  final double height;
  final bool isLoading;
  final Widget? icon;
  final double radius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = onPressed != null && !isLoading;
    final child = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.onPrimary,
            ),
          )
        else ...[
          if (icon != null) ...[icon!, const SizedBox(width: AppSpacing.sm)],
          // Flexible so a long label shrinks to the space it has instead of
          // overflowing the row — non-expanded buttons inside a Column get
          // whatever width the parent allows, which may be less than the
          // label's natural size.
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.textTheme.labelLarge?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ],
    );
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: height,
          decoration: BoxDecoration(
            gradient: colors.primaryGradient,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(radius),
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}

/// Bordered secondary button.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.expanded = true,
    this.height = 42,
    this.icon,
    this.radius = AppRadius.pill,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expanded;
  final double height;
  final Widget? icon;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: height,
      width: expanded ? double.infinity : null,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          side: BorderSide(color: colors.accent),
        ),
        icon: icon ?? const SizedBox.shrink(),
        label: Text(label),
      ),
    );
  }
}
