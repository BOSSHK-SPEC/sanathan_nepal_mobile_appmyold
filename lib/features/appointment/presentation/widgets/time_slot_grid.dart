import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/time_slot.dart';
import 'appointment_format.dart';

/// 5-column grid of small time-slot pills (Figma "Button/Primary" 50×25):
/// selected = gradient, available = outlined, taken = muted.
class TimeSlotGrid extends StatelessWidget {
  const TimeSlotGrid({
    required this.slots,
    required this.selectedId,
    required this.onSelected,
    super.key,
  });

  final List<TimeSlot> slots;
  final String? selectedId;
  final ValueChanged<TimeSlot> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fmt = AppointmentFormat.of(context);
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final s in slots)
          () {
            final selected = s.id == selectedId;
            return InkWell(
              onTap: s.available ? () => onSelected(s) : null,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                width: 60,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: selected ? colors.primaryGradient : null,
                  color: selected
                      ? null
                      : s.available
                      ? colors.surface
                      : colors.chipBackground,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: selected
                      ? null
                      : Border.all(
                          color: s.available ? colors.accent : colors.border,
                        ),
                ),
                child: Text(
                  fmt.slotLabel(s),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? colors.onPrimary
                        : s.available
                        ? colors.textPrimary
                        : colors.textMuted,
                    decoration: s.available ? null : TextDecoration.lineThrough,
                  ),
                ),
              ),
            );
          }(),
      ],
    );
  }
}
