import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';

/// Section card with a title and its rows (Figma "… Notification Setting").
class NotificationSection extends StatelessWidget {
  const NotificationSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.xs),
        ...children,
      ],
    ),
  );
}

/// "Notification Time   [06:30 AM]" row opening a time picker.
class TimeRow extends StatelessWidget {
  const TimeRow({
    required this.label,
    required this.minutes,
    required this.onChanged,
    super.key,
  });

  final String label;
  final int minutes;
  final ValueChanged<int> onChanged;

  static String format(BuildContext context, int minutes) {
    final t = TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
    final text = MaterialLocalizations.of(context).formatTimeOfDay(t);
    return context.usesDevanagariDigits ? text.toDevanagariDigits() : text;
  }

  Future<void> _pick(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
    );
    if (picked != null) onChanged(picked.hour * 60 + picked.minute);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label, style: context.textTheme.bodyMedium)),
          const SizedBox(width: AppSpacing.sm),
          _ChipButton(
            icon: Icons.access_time,
            label: format(context, minutes),
            onTap: () => _pick(context),
            color: colors.chipBackground,
          ),
        ],
      ),
    );
  }
}

/// "Remind me before [–] 1 [+] days at [06:30 AM]" row.
class RemindBeforeRow extends StatelessWidget {
  const RemindBeforeRow({
    required this.remindLabel,
    required this.daysAtLabel,
    required this.days,
    required this.minutes,
    required this.onDaysChanged,
    required this.onMinutesChanged,
    super.key,
    this.maxDays = 30,
  });

  final String remindLabel;
  final String daysAtLabel;
  final int days;
  final int minutes;
  final ValueChanged<int> onDaysChanged;
  final ValueChanged<int> onMinutesChanged;
  final int maxDays;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dayText = context.usesDevanagariDigits
        ? '$days'.toDevanagariDigits()
        : '$days';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.xs,
        children: [
          Text(remindLabel, style: context.textTheme.bodyMedium),
          Container(
            decoration: BoxDecoration(
              color: colors.chipBackground,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StepButton(
                  icon: Icons.remove,
                  onTap: days > 0 ? () => onDaysChanged(days - 1) : null,
                ),
                Text(dayText, style: context.textTheme.titleSmall),
                _StepButton(
                  icon: Icons.add,
                  onTap: days < maxDays ? () => onDaysChanged(days + 1) : null,
                ),
              ],
            ),
          ),
          Text(daysAtLabel, style: context.textTheme.bodyMedium),
          _ChipButton(
            icon: Icons.access_time,
            label: TimeRow.format(context, minutes),
            color: colors.chipBackground,
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: minutes ~/ 60,
                  minute: minutes % 60,
                ),
              );
              if (picked != null) {
                onMinutesChanged(picked.hour * 60 + picked.minute);
              }
            },
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
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: Icon(icon, size: 16),
    visualDensity: VisualDensity.compact,
    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
    padding: EdgeInsets.zero,
  );
}

class _ChipButton extends StatelessWidget {
  const _ChipButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.pill),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: context.colors.accent),
          const SizedBox(width: AppSpacing.xs),
          Text(label, style: context.textTheme.labelMedium),
        ],
      ),
    ),
  );
}
