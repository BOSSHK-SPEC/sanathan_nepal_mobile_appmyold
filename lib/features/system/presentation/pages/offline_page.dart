import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../l10n/system_strings.dart';

/// Full-screen offline state, for the cases where a screen genuinely has
/// nothing to show without the network.
class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final s = SystemStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off_rounded, size: 56, color: colors.textMuted),
              const SizedBox(height: AppSpacing.xl),
              Text(
                s.offlineTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                s.offlineBody,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.textMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.offline_bolt_outlined,
                      size: 16,
                      color: colors.accent,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        s.offlineStillWorks,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: s.retry,
                  expanded: false,
                  onPressed: onRetry,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
