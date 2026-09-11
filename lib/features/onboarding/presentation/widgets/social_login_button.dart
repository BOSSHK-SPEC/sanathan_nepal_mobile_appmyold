import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// White "Continue with …" button from Figma (`Continue with Google / Centre /
/// Fixed`): 6-px radius, subtle drop shadow, 24-px leading icon and a
/// 20-px medium label. Stays white on both themes as in the design.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
    this.isLoading = false,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: colors.onPrimary,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.17),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: SizedBox(
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 24, height: 24, child: Center(child: icon)),
                const SizedBox(width: 15),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      color: Colors.black.withValues(alpha: 0.54),
                    ),
                  ),
                ),
                if (isLoading) ...[
                  const SizedBox(width: AppSpacing.md),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
