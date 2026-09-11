import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../region/region_format.dart';

/// Renders an amount in the active region's currency.
///
/// Always use this (or [RegionFormat.money] directly) instead of writing
/// `'रु. $amount'` — it handles the symbol, lakh/crore grouping and
/// Devanagari digits for Nepali and Hindi.
class MoneyText extends StatelessWidget {
  const MoneyText(
    this.amount, {
    super.key,
    this.style,
    this.decimals = 0,
    this.color,
    this.signed = false,
    this.toneBySign = false,
    this.strikethrough = false,
    this.maxLines = 1,
  });

  final num amount;
  final TextStyle? style;
  final int decimals;
  final Color? color;

  /// Prefix an explicit `+` on positive amounts (ledgers, wallet credits).
  final bool signed;

  /// Colour credits green and debits red. Ignored when [color] is given.
  final bool toneBySign;

  /// For struck-through original prices next to a discount.
  final bool strikethrough;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final formatted = RegionFormat.money(
      amount.abs(),
      config: context.regionConfig,
      languageCode: context.languageCode,
      decimals: decimals,
    );

    final sign = switch (amount) {
      < 0 => '-',
      > 0 when signed => '+',
      _ => '',
    };

    final resolved =
        color ??
        (toneBySign ? (amount < 0 ? colors.error : colors.success) : null);

    return Text(
      '$sign$formatted',
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: (style ?? context.textTheme.titleMedium)?.copyWith(
        color: resolved,
        fontFeatures: const [FontFeature.tabularFigures()],
        decoration: strikethrough ? TextDecoration.lineThrough : null,
        decorationColor: resolved ?? colors.textMuted,
      ),
    );
  }
}
