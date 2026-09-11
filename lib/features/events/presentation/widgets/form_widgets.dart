import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Small bold section label used above form fields ("कार्यक्रम मिति").
class FormLabel extends StatelessWidget {
  const FormLabel(this.text, {super.key, this.icon});
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 12, color: context.colors.accent),
          const SizedBox(width: 4),
        ],
        Text(
          text,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

/// Bordered value box that opens a picker on tap ("२०७९-१२-०२", "12:00 AM").
class PickerBox extends StatelessWidget {
  const PickerBox({
    required this.value,
    required this.onTap,
    super.key,
    this.icon,
    this.width,
    this.height = 32,
  });

  final String value;
  final VoidCallback onTap;
  final IconData? icon;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                value,
                style: context.textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (icon != null) Icon(icon, size: 14, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}

/// Compact numeric stepper box (days before reminder).
class NumberBox extends StatelessWidget {
  const NumberBox({
    required this.value,
    required this.onChanged,
    super.key,
    this.min = 0,
    this.max = 365,
    this.formatter,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final String Function(int)? formatter;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            icon: Icons.remove,
            onTap: value > min ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 28,
            child: Text(
              formatter?.call(value) ?? '$value',
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium,
            ),
          ),
          _StepButton(
            icon: Icons.add,
            onTap: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 26,
      height: 32,
      child: Icon(
        icon,
        size: 14,
        color: onTap == null ? context.colors.textMuted : context.colors.accent,
      ),
    ),
  );
}
