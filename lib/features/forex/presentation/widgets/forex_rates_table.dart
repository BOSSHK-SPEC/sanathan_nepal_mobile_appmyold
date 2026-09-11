import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/forex_rate.dart';
import '../l10n/forex_strings.dart';
import 'currency_flag.dart';
import 'forex_format.dart';

/// मुद्रा / खरिद / बिक्री table (Figma "CURRENCY TABLE"). When
/// [favourites] and [onToggleFavourite] are provided every row gets a
/// heart toggle for pinning to the home page.
class ForexRatesTable extends StatelessWidget {
  const ForexRatesTable({
    required this.rates,
    super.key,
    this.favourites = const [],
    this.onToggleFavourite,
  });

  final List<ForexRate> rates;
  final List<String> favourites;
  final ValueChanged<String>? onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ForexStrings.of(context);
    final dv = context.usesDevanagariDigits;
    final headerStyle = context.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: colors.textPrimary,
    );
    final showHeart = onToggleFavourite != null;

    return Column(
      children: [
        Container(
          height: 22,
          decoration: BoxDecoration(
            color: colors.chipBackground,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          child: _Row(
            leading: showHeart ? const SizedBox(width: 22) : null,
            flag: const SizedBox(width: 20),
            name: Text(s.currency, style: headerStyle),
            buy: Text(s.buy, style: headerStyle),
            sell: Text(s.sell, style: headerStyle),
          ),
        ),
        for (final (i, r) in rates.indexed)
          Container(
            height: 24,
            decoration: BoxDecoration(
              color: i.isOdd ? colors.surfaceVariant : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: _Row(
              leading: showHeart
                  ? _Heart(
                      selected: favourites.contains(r.currency.iso3),
                      onTap: () => onToggleFavourite!(r.currency.iso3),
                    )
                  : null,
              flag: CurrencyFlag(r.currency, width: 20),
              name: Text(
                ForexFormat.digits(
                  r.currency.displayName(languageCode: context.languageCode),
                  devanagari: dv,
                ),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              buy: Text(
                ForexFormat.rate(r.buy, devanagari: dv),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              sell: Text(
                ForexFormat.rate(r.sell, devanagari: dv),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.flag,
    required this.name,
    required this.buy,
    required this.sell,
    this.leading,
  });
  final Widget? leading;
  final Widget flag;
  final Widget name;
  final Widget buy;
  final Widget sell;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    child: Row(
      children: [
        ?leading,
        flag,
        const SizedBox(width: AppSpacing.md),
        Expanded(flex: 5, child: name),
        Expanded(flex: 3, child: Center(child: buy)),
        Expanded(flex: 3, child: Center(child: sell)),
      ],
    ),
  );
}

class _Heart extends StatelessWidget {
  const _Heart({required this.selected, required this.onTap});
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: SizedBox(
      width: 22,
      child: Icon(
        selected ? Icons.favorite : Icons.favorite_border,
        size: 12,
        color: selected ? context.colors.accent : context.colors.iconMuted,
      ),
    ),
  );
}
