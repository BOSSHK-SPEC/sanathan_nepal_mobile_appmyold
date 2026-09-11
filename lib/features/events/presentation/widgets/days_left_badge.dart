import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';

/// "२० दिन बाँकी" badge on the accent gradient.
///
/// * default – number and caption side by side (details app bar, 50×20);
/// * [stacked] – big number over the caption (festival rows, 44×34);
/// * [compact] – single small pill "20 Days Remaining".
class DaysLeftBadge extends StatelessWidget {
  const DaysLeftBadge({
    required this.days,
    super.key,
    this.compact = false,
    this.stacked = false,
  });

  final int days;
  final bool compact;
  final bool stacked;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final devanagari = context.usesDevanagariDigits;
    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          gradient: colors.primaryGradient,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Text(
          s.daysRemaining(days),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    final number = Text(
      EventDateFormat.digits('$days', devanagari: devanagari),
      style: context.textTheme.headlineSmall?.copyWith(
        color: colors.onPrimary,
        height: 1.1,
      ),
    );
    final caption = Text(
      s.daysLeftLabel,
      maxLines: 1,
      style: context.textTheme.labelSmall?.copyWith(
        color: colors.onPrimary,
        fontSize: 8,
        height: 1.1,
      ),
    );
    return Container(
      constraints: stacked
          ? const BoxConstraints(minWidth: 44, maxWidth: 60)
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        gradient: colors.primaryGradient,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: stacked
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [number, caption],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  number,
                  const SizedBox(width: 3),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: caption,
                  ),
                ],
              ),
      ),
    );
  }
}
