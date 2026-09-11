import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import 'checklist_wrap.dart';
import 'event_date_column.dart';
import 'event_tag.dart';

/// Row of the "My Events" / "To-Do" list (Figma "Group 35904", 340×58):
///
/// * left – title · category tag · "२० दिन बाँकी", then the description and
///   the reminder line (personal events) or the inline checklist (to-dos);
/// * right – [EventDateColumn] and a "more" menu (edit / delete).
class MyEventRow extends StatelessWidget {
  const MyEventRow({
    required this.event,
    super.key,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleChecklist,
    this.onChecklist,
    this.now,
    this.showDivider = true,
  });

  final Event event;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  /// Toggles one checklist item (to-do rows show the checklist inline).
  final ValueChanged<String>? onToggleChecklist;

  /// Opens the checklist popup (personal events show only a counter).
  final VoidCallback? onChecklist;
  final DateTime? now;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final lang = context.languageCode;
    final isTodo = event.group == EventGroup.todo;
    final hasMenu = onEdit != null || onDelete != null;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.sm,
          0,
          AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(bottom: BorderSide(color: colors.divider))
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        event.title.resolveFor(lang),
                        style: context.textTheme.titleSmall,
                      ),
                      if (!isTodo) EventTag(label: s.category_(event.category)),
                      Text(
                        s.daysRemaining(event.daysLeft(now)),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.accent,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  if (isTodo && event.checklist.isNotEmpty)
                    ChecklistWrap(
                      items: event.checklist,
                      onToggle: onToggleChecklist,
                    )
                  else ...[
                    if (!event.description.isEmpty)
                      Text(
                        event.description.resolveFor(lang),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    const SizedBox(height: 4),
                    _ReminderLine(event: event, onChecklist: onChecklist),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            EventDateColumn(
              date: event.date,
              tithi: event.tithi.resolveFor(lang),
            ),
            if (hasMenu)
              _MoreMenu(onEdit: onEdit, onDelete: onDelete)
            else
              const SizedBox(width: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}

/// "अनुस्मारक: 1 day before at 6:00 AM" (alarm) or "No Reminder set…" (info)
/// on a tinted strip, plus the checklist counter when the event has items.
class _ReminderLine extends StatelessWidget {
  const _ReminderLine({required this.event, required this.onChecklist});
  final Event event;
  final VoidCallback? onChecklist;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final reminder = event.reminder;
    final color = reminder != null ? colors.accent : colors.textMuted;
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  reminder != null ? Icons.alarm_on : Icons.info_outline,
                  size: 11,
                  color: color,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    reminder != null
                        ? s.reminderText(
                            reminder.daysBefore,
                            reminder.time.format12h(),
                          )
                        : s.noReminder,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: color,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (event.checklist.isNotEmpty) ...[
          const SizedBox(width: 6),
          _ChecklistCounter(event: event, onTap: onChecklist),
        ],
      ],
    );
  }
}

class _ChecklistCounter extends StatelessWidget {
  const _ChecklistCounter({required this.event, required this.onTap});
  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final done = event.checklist.where((c) => c.isDone).length;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xs),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: colors.chipBackground,
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.checklist_rounded, size: 11, color: colors.accent),
            const SizedBox(width: 2),
            Text(
              EventDateFormat.digits(
                '$done/${event.checklist.length}',
                devanagari: context.usesDevanagariDigits,
              ),
              style: context.textTheme.labelSmall?.copyWith(fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }
}

/// Slim vertical "⋮" handle at the far right (Figma "Group 35912", 10×30).
class _MoreMenu extends StatelessWidget {
  const _MoreMenu({required this.onEdit, required this.onDelete});
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    return Semantics(
      button: true,
      label: s.moreOptions,
      child: PopupMenuButton<String>(
        tooltip: s.moreOptions,
        padding: EdgeInsets.zero,
        iconSize: 16,
        icon: Icon(Icons.more_vert, size: 16, color: colors.iconMuted),
        onSelected: (v) => v == 'edit' ? onEdit?.call() : onDelete?.call(),
        itemBuilder: (_) => [
          if (onEdit != null) PopupMenuItem(value: 'edit', child: Text(s.edit)),
          if (onDelete != null)
            PopupMenuItem(
              value: 'delete',
              child: Text(s.delete, style: TextStyle(color: colors.error)),
            ),
        ],
      ),
    );
  }
}
