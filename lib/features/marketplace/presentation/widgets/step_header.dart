import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// One step of [StepHeader].
class StepItem {
  const StepItem({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

/// Two/three-step progress header (Figma "Header": ○ Select your Product ——
/// ○ Checkout). Completed steps show a tick, the active one is filled.
class StepHeader extends StatelessWidget {
  const StepHeader({
    required this.steps,
    required this.activeIndex,
    super.key,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    this.onStepTap,
  });

  final List<StepItem> steps;
  final int activeIndex;
  final EdgeInsets padding;
  final ValueChanged<int>? onStepTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.md),
        ),
      ),
      child: Row(
        children: [
          for (var i = 0; i < steps.length; i++) ...[
            if (i > 0)
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  color: i <= activeIndex ? colors.accent : colors.divider,
                ),
              ),
            Flexible(
              flex: 3,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onStepTap == null ? null : () => onStepTap!(i),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i <= activeIndex
                            ? colors.accent
                            : Colors.transparent,
                        border: Border.all(
                          color: i <= activeIndex
                              ? colors.accent
                              : colors.textMuted,
                        ),
                      ),
                      child: Icon(
                        i < activeIndex ? Icons.check : steps[i].icon,
                        size: 13,
                        color: i <= activeIndex
                            ? colors.onPrimary
                            : colors.textMuted,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        steps[i].label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: i == activeIndex
                              ? colors.accent
                              : colors.textSecondary,
                          fontWeight: i == activeIndex
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
