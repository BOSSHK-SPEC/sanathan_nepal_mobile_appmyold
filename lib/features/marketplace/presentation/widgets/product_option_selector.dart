import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../utils/marketplace_format.dart';

/// "Caret : 7" + a row of selectable boxes (Figma light Product Details).
class ProductOptionSelector extends StatelessWidget {
  const ProductOptionSelector({
    required this.name,
    required this.values,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String name;
  final List<String> values;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$name : ${MarketplaceFormat.digits(context, selected ?? '')}',
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final v in values)
              GestureDetector(
                onTap: () => onSelected(v),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 40),
                  height: 35,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: v == selected
                        ? colors.chipSelected
                        : colors.chipBackground,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: v == selected ? colors.accent : colors.border,
                    ),
                  ),
                  child: Center(
                    widthFactor: 1,
                    child: Text(
                      MarketplaceFormat.digits(context, v),
                      style: context.textTheme.labelLarge?.copyWith(
                        color: v == selected
                            ? colors.onChipSelected
                            : colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
