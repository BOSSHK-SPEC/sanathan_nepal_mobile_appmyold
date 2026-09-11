import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';

/// Rounded settings card: bold title (+ optional switch) · divider · body.
class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({
    required this.title,
    required this.children,
    super.key,
    this.enabled,
    this.onEnabledChanged,
  });

  final String title;
  final List<Widget> children;

  /// When non-null a switch is shown in the header.
  final bool? enabled;
  final ValueChanged<bool>? onEnabledChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimmed = enabled == false;
    return AppCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.sm,
      ),
      padding: EdgeInsets.zero,
      gradient: context.isDark ? colors.cardGradient : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (enabled != null)
                  SizedBox(
                    height: 24,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: enabled!,
                        onChanged: onEnabledChanged,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.divider),
          Opacity(
            opacity: dimmed ? 0.5 : 1,
            child: IgnorePointer(
              ignoring: dimmed,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
