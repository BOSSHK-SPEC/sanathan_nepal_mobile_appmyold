import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../domain/entities/product_filter.dart';
import '../l10n/marketplace_strings.dart';

/// "Sort by : ○ Latest ○ Price Low to High ○ Price High to Low".
class SortByRow extends StatelessWidget {
  const SortByRow({required this.value, required this.onChanged, super.key});

  final ProductSort value;
  final ValueChanged<ProductSort> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final style = context.textTheme.labelSmall?.copyWith(
      color: context.colors.textPrimary,
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(s.sortBy, style: context.textTheme.labelSmall),
          const SizedBox(width: AppSpacing.xs),
          for (final entry in {
            ProductSort.latest: s.latest,
            ProductSort.priceLowToHigh: s.priceLowToHigh,
            ProductSort.priceHighToLow: s.priceHighToLow,
          }.entries)
            AppRadioOption<ProductSort>(
              value: entry.key,
              groupValue: value,
              label: entry.value,
              onChanged: onChanged,
              textStyle: style,
            ),
        ],
      ),
    );
  }
}
