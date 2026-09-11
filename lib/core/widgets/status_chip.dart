import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Semantic tone for a [StatusChip]. Keeps status colour out of call sites
/// so appointments, orders, payouts, KYC and sessions all read the same.
enum StatusTone { neutral, info, success, warning, danger, accent }

/// Pill that encodes a state in both colour and words.
///
/// ```dart
/// StatusChip(label: 'Pending review', tone: StatusTone.warning)
/// ```
class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.label,
    super.key,
    this.tone = StatusTone.neutral,
    this.icon,
    this.dense = false,
    this.filled = true,
  });

  final String label;
  final StatusTone tone;
  final IconData? icon;

  /// Tighter padding and smaller type, for use inside dense list rows.
  final bool dense;

  /// `false` renders an outlined chip on a transparent ground.
  final bool filled;

  Color _foreground(BuildContext context) {
    final colors = context.colors;
    return switch (tone) {
      StatusTone.neutral => colors.textSecondary,
      StatusTone.info => colors.info,
      StatusTone.success => colors.success,
      StatusTone.warning => colors.warning,
      StatusTone.danger => colors.error,
      StatusTone.accent => colors.accent,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = _foreground(context);
    final bg = tone == StatusTone.neutral
        ? colors.chipBackground
        : fg.withValues(alpha: context.isDark ? 0.18 : 0.12);

    final textStyle =
        (dense ? context.textTheme.labelSmall : context.textTheme.labelMedium)
            ?.copyWith(color: fg, fontWeight: FontWeight.w600, height: 1.2);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? AppSpacing.sm : AppSpacing.md,
        vertical: dense ? 2 : AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: filled ? bg : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: filled ? null : Border.all(color: fg.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: dense ? 11 : 13, color: fg),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(label, style: textStyle),
        ],
      ),
    );
  }
}

/// Small coloured dot + label, for presence and inline states where a full
/// pill is too heavy.
class StatusDot extends StatelessWidget {
  const StatusDot({
    required this.label,
    super.key,
    this.tone = StatusTone.neutral,
    this.size = 7,
  });

  final String label;
  final StatusTone tone;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = switch (tone) {
      StatusTone.neutral => colors.textMuted,
      StatusTone.info => colors.info,
      StatusTone.success => colors.success,
      StatusTone.warning => colors.warning,
      StatusTone.danger => colors.error,
      StatusTone.accent => colors.accent,
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.xs + 2),
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
