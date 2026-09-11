import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import 'checklist_popup.dart';
import 'event_tag.dart';

/// Body of the details page for user events and to-dos.
class PersonalEventDetailsBody extends StatelessWidget {
  const PersonalEventDetailsBody({
    required this.event,
    required this.onToggleChecklist,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Event event;
  final ValueChanged<String> onToggleChecklist;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final lang = context.languageCode;
    final e = event;
    final reminder = e.reminder;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.md,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  EventTag(label: s.category_(e.category)),
                  const Spacer(),
                  if (e.repeat != EventRepeat.none)
                    Row(
                      children: [
                        Icon(Icons.repeat, size: 12, color: colors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          s.repeatLabel(e.repeat),
                          style: context.textTheme.labelSmall,
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                e.title.resolveFor(lang),
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              _InfoRow(
                icon: Icons.calendar_today_outlined,
                text: EventDateFormat.detailsLine(
                  e.date,
                  config: context.regionConfig,
                  languageCode: lang,
                  weekdays: s.weekdays,
                  tithi: e.tithi.resolveFor(lang),
                ),
              ),
              if (e.time != null)
                _InfoRow(icon: Icons.access_time, text: e.time!.format12h()),
              if (!e.location.isEmpty)
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  text: e.location.resolveFor(lang),
                ),
              _InfoRow(
                icon: reminder != null ? Icons.alarm_on : Icons.info_outline,
                text: reminder != null
                    ? s.reminderText(
                        reminder.daysBefore,
                        reminder.time.format12h(),
                      )
                    : s.noReminder,
                color: reminder != null ? colors.accent : colors.textMuted,
              ),
              if (!e.description.isEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  e.description.resolveFor(lang),
                  style: context.textTheme.bodySmall?.copyWith(height: 1.5),
                ),
              ],
            ],
          ),
        ),
        if (e.checklist.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          AppCard(
            padding: EdgeInsets.zero,
            child: ChecklistPopup(
              title: s.checklist,
              items: e.checklist,
              onToggle: onToggleChecklist,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: s.delete,
                height: 38,
                icon: Icon(
                  Icons.delete_outline,
                  size: 16,
                  color: colors.accent,
                ),
                onPressed: onDelete,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: PrimaryButton(
                label: s.edit,
                height: 38,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: colors.onPrimary,
                ),
                onPressed: onEdit,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text, this.color});
  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.colors.textSecondary;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 13, color: c),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.labelSmall?.copyWith(color: c),
            ),
          ),
        ],
      ),
    );
  }
}
