import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// One selectable option of a [FormChoiceRow].
class FormChoice<T> {
  const FormChoice(this.value, this.label);
  final T value;
  final String label;
}

/// Labelled row of pill chips (Condition: Brand New / Used, Listing type:
/// Product / Service, expiry days …) used by the seller form.
class FormChoiceRow<T> extends StatelessWidget {
  const FormChoiceRow({
    required this.label,
    required this.choices,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final List<FormChoice<T>> choices;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final c in choices)
              ChoiceChip(
                label: Text(c.label),
                selected: c.value == value,
                showCheckmark: false,
                selectedColor: colors.chipSelected,
                backgroundColor: colors.chipBackground,
                side: BorderSide(
                  color: c.value == value ? colors.accent : colors.border,
                ),
                labelStyle: context.textTheme.labelMedium?.copyWith(
                  color: c.value == value
                      ? colors.onChipSelected
                      : colors.textPrimary,
                ),
                visualDensity: VisualDensity.compact,
                onSelected: (_) => onChanged(c.value),
              ),
          ],
        ),
      ],
    );
  }
}
