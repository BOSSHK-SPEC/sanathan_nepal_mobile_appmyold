import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Radio + label pair matching Figma "active select / select" (16×16 ring
/// with orange/magenta filled dot when selected).
class AppRadioOption<T> extends StatelessWidget {
  const AppRadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    super.key,
    this.textStyle,
  });

  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T> onChanged;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final selected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? colors.accent : colors.textMuted,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: selected ? 8 : 0,
                  height: selected ? 8 : 0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.accent,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: textStyle ?? context.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
