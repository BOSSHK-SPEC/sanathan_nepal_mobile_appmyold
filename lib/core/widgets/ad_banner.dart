import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Placeholder ad slot – grey rounded box with chevrons and an uppercase label
/// (Figma: "HOME BELOW EVENT ADS", "PATRO PAGE ADS", "SETTING TAB ADS").
class AdBanner extends StatelessWidget {
  const AdBanner({
    required this.label,
    super.key,
    this.height = 110,
    this.margin = AppSpacing.page,
    this.showArrows = true,
    this.onPrevious,
    this.onNext,
  });

  final String label;
  final double height;
  final EdgeInsets margin;
  final bool showArrows;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: margin,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: colors.adBanner,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          children: [
            if (showArrows)
              IconButton(
                onPressed: onPrevious,
                icon: Icon(Icons.chevron_left, color: colors.textPrimary),
              ),
            Expanded(
              child: Center(
                child: Text(
                  label.toUpperCase(),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (showArrows)
              IconButton(
                onPressed: onNext,
                icon: Icon(Icons.chevron_right, color: colors.textPrimary),
              ),
          ],
        ),
      ),
    );
  }
}
