import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Rounded popup shell (Figma OTP popups are 300 × 344) with optional back and
/// close buttons in the top corners.
class AuthPopupCard extends StatelessWidget {
  const AuthPopupCard({
    required this.child,
    super.key,
    this.onClose,
    this.onBack,
    this.width = 300,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.xl,
      AppSpacing.xs,
      AppSpacing.xl,
      AppSpacing.xl,
    ),
  });

  final Widget child;
  final VoidCallback? onClose;
  final VoidCallback? onBack;
  final double width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (onBack != null)
                  IconButton(
                    onPressed: onBack,
                    icon: Icon(Icons.arrow_back, color: colors.icon, size: 20),
                  ),
                const Spacer(),
                if (onClose != null)
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: colors.icon,
                      size: 20,
                    ),
                  ),
              ],
            ),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}
