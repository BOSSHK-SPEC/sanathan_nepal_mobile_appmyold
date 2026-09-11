import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/events_strings.dart';

/// Tiny "Add Event/Reminder 📅" pill (Figma "Group 35869", 50×14).
class AddReminderButton extends StatelessWidget {
  const AddReminderButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    return Semantics(
      button: true,
      label: s.addEventReminder,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: colors.chipBackground,
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(color: colors.accent.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  s.addEventReminder,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.accent,
                    fontSize: 8,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                Icons.event_available_outlined,
                size: 11,
                color: colors.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
