import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/live_session_cubit.dart';
import '../l10n/consultation_strings.dart';

/// Live timer and running cost, pinned in the app bar.
///
/// Always visible during a paid session: a per-minute charge that the user
/// cannot see accumulate is the single most common complaint in this
/// category, and the most common reason for a chargeback.
class BillingMeter extends StatelessWidget {
  const BillingMeter({required this.state, super.key, this.compact = false});

  final LiveSessionState state;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final warn = state.isLowBalance;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: (warn ? colors.error : colors.success).withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            warn ? Icons.warning_amber_rounded : Icons.timer_outlined,
            size: 14,
            color: warn ? colors.error : colors.success,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            state.elapsedLabel,
            style: context.textTheme.labelMedium?.copyWith(
              color: warn ? colors.error : colors.success,
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          if (!compact) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(width: 1, height: 12, color: colors.divider),
            const SizedBox(width: AppSpacing.sm),
            MoneyText(
              state.costSoFar,
              style: context.textTheme.labelMedium,
              color: warn ? colors.error : colors.textPrimary,
            ),
          ],
        ],
      ),
    );
  }
}

/// Banner that appears while the balance can still be topped up in time.
class LowBalanceBanner extends StatelessWidget {
  const LowBalanceBanner({
    required this.state,
    required this.onTopUp,
    required this.onEnd,
    super.key,
  });

  final LiveSessionState state;
  final VoidCallback onTopUp;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    if (!state.isLowBalance) return const SizedBox.shrink();

    final colors = context.colors;
    final s = ConsultationStrings.of(context);
    final out = state.isOutOfBalance;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      color: colors.error.withValues(alpha: 0.12),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, size: 20, color: colors.error),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  out ? s.outOfBalanceTitle : s.lowBalanceTitle,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: colors.error,
                  ),
                ),
                Text(
                  s.lowBalanceBody,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          PrimaryButton(
            label: out ? s.topUpNow : s.topUpNow,
            expanded: false,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            onPressed: onTopUp,
          ),
        ],
      ),
    );
  }
}
