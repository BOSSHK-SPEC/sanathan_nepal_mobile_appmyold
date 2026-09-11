import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/notification_settings.dart';
import '../l10n/notifications_strings.dart';

/// Row "label ………… [switch]" used inside settings cards.
class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 30,
    child: Row(
      children: [
        Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
        Transform.scale(
          scale: 0.75,
          child: Switch(value: value, onChanged: onChanged),
        ),
      ],
    ),
  );
}

/// Small check box + label ("Daily", "Monthly", "Yearly").
class SettingsCheckOption extends StatelessWidget {
  const SettingsCheckOption({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: value ? colors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: value ? colors.accent : colors.textMuted,
                ),
              ),
              child: value
                  ? Icon(Icons.check, size: 12, color: colors.onPrimary)
                  : null,
            ),
            const SizedBox(width: 6),
            Text(label, style: context.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

/// Bordered box showing a time; opens the platform time picker on tap.
class SettingsTimeBox extends StatelessWidget {
  const SettingsTimeBox({
    required this.time,
    required this.onChanged,
    super.key,
    this.width = 110,
  });

  final NotificationTime time;
  final ValueChanged<NotificationTime> onChanged;
  final double width;

  Future<void> _pick(BuildContext context) async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: time.hour, minute: time.minute),
    );
    if (t != null) onChanged(NotificationTime(hour: t.hour, minute: t.minute));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: () => _pick(context),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        width: width,
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                time.format12h(),
                style: context.textTheme.bodyMedium,
              ),
            ),
            Icon(Icons.access_time, size: 14, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}

/// Bordered numeric box with −/+ steppers ("Remind me before [1] Days").
class SettingsNumberBox extends StatelessWidget {
  const SettingsNumberBox({
    required this.value,
    required this.onChanged,
    super.key,
    this.max = 60,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int max;

  @override
  Widget build(BuildContext context) {
    final s = NotificationsStrings.of(context);
    final colors = context.colors;
    return Container(
      height: 34,
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Step(
            icon: Icons.remove,
            onTap: value > 0 ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 24,
            child: Text(
              s.digits(value),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
          ),
          _Step(
            icon: Icons.add,
            onTap: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 24,
      height: 34,
      child: Icon(
        icon,
        size: 14,
        color: onTap == null ? context.colors.textMuted : context.colors.accent,
      ),
    ),
  );
}

/// "Remind me before [N] Days at [12:00 AM]" row.
class RemindBeforeRow extends StatelessWidget {
  const RemindBeforeRow({
    required this.days,
    required this.time,
    required this.onDaysChanged,
    required this.onTimeChanged,
    super.key,
  });

  final int days;
  final NotificationTime time;
  final ValueChanged<int> onDaysChanged;
  final ValueChanged<NotificationTime> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    final s = NotificationsStrings.of(context);
    final colors = context.colors;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          s.remindMeBefore,
          style: context.textTheme.bodyMedium?.copyWith(color: colors.accent),
        ),
        SettingsNumberBox(value: days, onChanged: onDaysChanged),
        Text(s.daysAt, style: context.textTheme.bodyMedium),
        SettingsTimeBox(time: time, onChanged: onTimeChanged),
      ],
    );
  }
}
