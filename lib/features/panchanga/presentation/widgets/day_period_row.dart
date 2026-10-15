import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/time_window.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';
import 'panchanga_table_widgets.dart';

/// One period as a row of the panchanga table: the same alternating tint,
/// hairline column rule and bold label the rest of the app's tables use.
class DayPeriodRow extends StatelessWidget {
  const DayPeriodRow({
    required this.window,
    required this.isCurrent,
    required this.tinted,
    super.key,
  });

  final TimeWindow window;
  final bool isCurrent;

  /// Alternating row tint, as in [PanchangaSubTable].
  final bool tinted;

  static Color qualityColor(AppColors colors, ChoghadiyaQuality quality) =>
      switch (quality) {
        ChoghadiyaQuality.good => colors.success,
        ChoghadiyaQuality.neutral => colors.textMuted,
        ChoghadiyaQuality.bad => colors.holiday,
      };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;
    final s = PanchangaStrings.of(context);
    final devanagari = context.usesDevanagariDigits;
    final tint = qualityColor(colors, window.quality);
    // Kaal windows carry no segment name of their own; theirs comes from the
    // kind ("Rahu Kaal"), while a Choghadiya or hora is named.
    final label = window.nameEn.isEmpty
        ? s.kaalLabel(window.kind)
        : window.name(nepali: context.isNepali || context.isHindi);

    return Semantics(
      container: true,
      selected: isCurrent,
      child: Container(
        color: isCurrent
            ? colors.accent.withValues(alpha: 0.08)
            : tinted
            ? colors.chipBackground
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 96,
              child: Text(
                PanchangaFormat.range(
                  window.start,
                  window.end,
                  devanagari: devanagari,
                ),
                style: text.labelSmall?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w400,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            const PanchangaHairline(vertical: true, length: 16),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
            ),
            Expanded(
              child: Text(
                label,
                style: text.labelMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
            if (isCurrent)
              Container(
                margin: const EdgeInsets.only(right: AppSpacing.xs),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: colors.accent,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: Text(
                  s.nowLabel,
                  style: text.labelSmall?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            Text(
              s.qualityLabel(window.quality),
              style: text.labelSmall?.copyWith(
                color: tint,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
