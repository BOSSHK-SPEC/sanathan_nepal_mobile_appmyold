import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_all.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../utils/payment_rails.dart';

/// Key/value line used in the cart, checkout and confirmation summaries.
class SummaryRow extends StatelessWidget {
  const SummaryRow({
    required this.label,
    required this.value,
    super.key,
    this.valueWidget,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final Widget? valueWidget;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = context.textTheme.bodySmall?.copyWith(
      color: emphasize ? colors.textPrimary : colors.textSecondary,
      fontWeight: emphasize ? FontWeight.w600 : FontWeight.w400,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          valueWidget ??
              Text(value, style: style?.copyWith(color: colors.textPrimary)),
        ],
      ),
    );
  }
}

/// "SECURE PAYMENTS PROVIDED BY" + wallet / card badges.
class SecurePaymentsFooter extends StatelessWidget {
  const SecurePaymentsFooter({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (final (i, badge) in _badges(context.regionConfig).indexed) ...[
              if (i > 0) const SizedBox(width: AppSpacing.sm),
              _Badge(text: badge, color: _badgeColors(colors)[i % 3]),
            ],
          ],
        ),
      ],
    );
  }
}

/// Badge labels for the region's non-cash rails ("eSewa Khalti VISA" /
/// "UPI VISA NetBanking").
List<String> _badges(RegionConfig config) => [
  for (final rail in config.paymentRails) ?rail.badge,
];

List<Color> _badgeColors(AppColors colors) => [
  colors.success,
  colors.primary,
  colors.info,
];

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 56,
    height: 30,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.xs),
      border: Border.all(color: context.colors.border),
    ),
    child: Text(
      text,
      style: context.textTheme.labelSmall?.copyWith(
        color: color,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
