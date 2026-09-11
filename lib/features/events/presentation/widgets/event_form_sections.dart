import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/labeled_toggle.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/event_category.dart';
import '../cubit/event_form_cubit.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import 'form_widgets.dart';

/// Category dropdown for personal events.
class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    required this.value,
    required this.onChanged,
    super.key,
  });
  final EventCategory value;
  final ValueChanged<EventCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final cats = EventCategory.forGroup(EventGroup.personal);
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: AppRadius.input,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EventCategory>(
          value: cats.contains(value) ? value : cats.first,
          isExpanded: true,
          style: context.textTheme.bodyMedium,
          items: [
            for (final c in cats)
              DropdownMenuItem(value: c, child: Text(s.category_(c))),
          ],
          onChanged: (c) => c == null ? null : onChanged(c),
        ),
      ),
    );
  }
}

/// "दोहोर्याउनुहोस्" – repeats yes/no + frequency dropdown.
class RepeatSection extends StatelessWidget {
  const RepeatSection({
    required this.state,
    required this.onRepeatsChanged,
    required this.onRepeatChanged,
    super.key,
  });

  final EventFormState state;
  final ValueChanged<bool> onRepeatsChanged;
  final ValueChanged<EventRepeat> onRepeatChanged;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(s.repeat),
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: AppSpacing.xs,
                children: [
                  AppRadioOption<bool>(
                    value: true,
                    groupValue: state.repeats,
                    label: s.repeatYes,
                    textStyle: context.textTheme.labelSmall,
                    onChanged: onRepeatsChanged,
                  ),
                  AppRadioOption<bool>(
                    value: false,
                    groupValue: state.repeats,
                    label: s.repeatNo,
                    textStyle: context.textTheme.labelSmall,
                    onChanged: onRepeatsChanged,
                  ),
                ],
              ),
            ),
            Container(
              width: 140,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.border),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<EventRepeat>(
                  value: state.repeat,
                  isExpanded: true,
                  isDense: true,
                  style: context.textTheme.labelMedium,
                  items: [
                    for (final r in EventRepeat.values.skip(1))
                      DropdownMenuItem(value: r, child: Text(s.repeatLabel(r))),
                  ],
                  onChanged: state.repeats
                      ? (r) => r == null ? null : onRepeatChanged(r)
                      : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// "To Do List" – add-item field + list of items.
class ChecklistSection extends StatelessWidget {
  const ChecklistSection({
    required this.state,
    required this.controller,
    required this.onAdd,
    required this.onToggle,
    required this.onRemove,
    super.key,
  });

  final EventFormState state;
  final TextEditingController controller;
  final VoidCallback onAdd;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(s.todoList),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: controller,
                hint: s.newListItem,
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            PrimaryButton(
              label: s.add,
              expanded: false,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              onPressed: onAdd,
            ),
          ],
        ),
        for (final item in state.checklist)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Row(
              children: [
                InkWell(
                  onTap: () => onToggle(item.id),
                  child: Icon(
                    item.isDone
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    size: 16,
                    color: item.isDone ? colors.accent : colors.textMuted,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    item.label,
                    style: context.textTheme.labelMedium?.copyWith(
                      decoration: item.isDone
                          ? TextDecoration.lineThrough
                          : null,
                      color: item.isDone
                          ? colors.textMuted
                          : colors.textPrimary,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => onRemove(item.id),
                  child: Icon(Icons.close, size: 14, color: colors.textMuted),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// "सूचना [15] दिन पहिले [12:00 AM]" reminder row with enable toggle.
class ReminderSection extends StatelessWidget {
  const ReminderSection({
    required this.state,
    required this.onEnabledChanged,
    required this.onDaysChanged,
    required this.onPickTime,
    super.key,
  });

  final EventFormState state;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onDaysChanged;
  final VoidCallback onPickTime;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final devanagari = context.usesDevanagariDigits;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledToggle(
          label: s.reminderLabel,
          value: state.reminderEnabled,
          onChanged: onEnabledChanged,
        ),
        if (state.reminderEnabled)
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(s.remindBefore, style: context.textTheme.labelMedium),
              NumberBox(
                value: state.reminderDays,
                onChanged: onDaysChanged,
                formatter: (v) =>
                    EventDateFormat.digits('$v', devanagari: devanagari),
              ),
              Text(s.daysAt, style: context.textTheme.labelMedium),
              PickerBox(
                value: state.reminderTime.format12h(),
                width: 110,
                icon: Icons.access_time,
                onTap: onPickTime,
              ),
            ],
          ),
      ],
    );
  }
}
