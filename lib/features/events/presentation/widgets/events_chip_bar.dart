import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/event_category.dart';
import '../cubit/events_list_cubit.dart';
import '../l10n/events_strings.dart';
import 'event_chip_row.dart';

/// Filter chips of the active events tab (Figma "Group 35861" / "Group
/// 35887" – boxed chips flowing over two rows) plus the trailing
/// "नयाँ कार्यक्रम +" / "गर्नु-पर्ने कार्यहरु +" pill on the user tabs.
///
/// * Festivals – All · Important · Government/Public Holidays · one chip per
///   region festival category (Nepal: Hindu … Kirat · Christian; India adds
///   Sikh · Jain).
/// * My Events – All · one chip per personal category.
/// * To-Do – All · one chip per listed to-do (narrows the list to it).
class EventsChipBar extends StatelessWidget {
  const EventsChipBar({required this.state, required this.onNew, super.key});

  final EventsListState state;
  final VoidCallback onNew;

  static const _padding = EdgeInsets.symmetric(horizontal: AppSpacing.md);

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final cubit = context.read<EventsListCubit>();
    switch (state.group) {
      case EventGroup.festival:
        final config = context.regionConfig;
        final cats = config.isIndia
            ? EventCategory.indiaFestivalFilters
            : EventCategory.nepalFestivalFilters;
        final labels = [
          s.filterAll,
          s.filterImportant,
          s.filterHolidays(config),
          ...cats.skip(1).map(s.category_),
        ];
        final selected = state.onlyImportant
            ? 1
            : state.category == null
            ? 0
            : cats.indexOf(state.category!) + 2;
        return EventChipRow(
          labels: labels,
          selectedIndex: selected,
          wrap: true,
          boxed: true,
          padding: _padding,
          onChanged: (i) => i == 0
              ? cubit.selectCategory(null)
              : i == 1
              ? cubit.selectImportant()
              : cubit.selectCategory(cats[i - 2]),
        );
      case EventGroup.personal:
        final cats = EventCategory.forGroup(EventGroup.personal);
        return EventChipRow(
          labels: [s.filterAll, ...cats.map(s.category_)],
          selectedIndex: state.category == null
              ? 0
              : cats.indexOf(state.category!) + 1,
          wrap: true,
          boxed: true,
          padding: _padding,
          onChanged: (i) => cubit.selectCategory(i == 0 ? null : cats[i - 1]),
          trailing: NewItemButton(label: s.newEvent, onTap: onNew),
        );
      case EventGroup.todo:
        final lang = context.languageCode;
        final todos = state.eventList;
        final focused = state.focusedEventId;
        final selected = focused == null
            ? 0
            : todos.indexWhere((e) => e.id == focused) + 1;
        return EventChipRow(
          labels: [
            s.filterAll,
            for (final e in todos) e.title.resolveFor(lang),
          ],
          selectedIndex: selected < 0 ? 0 : selected,
          wrap: true,
          boxed: true,
          padding: _padding,
          onChanged: (i) => cubit.focusEvent(i == 0 ? null : todos[i - 1].id),
          trailing: NewItemButton(label: s.newReminder, onTap: onNew),
        );
    }
  }
}

/// "नयाँ कार्यक्रम +" outlined accent pill (Figma "Group 35891", 62×15).
class NewItemButton extends StatelessWidget {
  const NewItemButton({required this.label, required this.onTap, super.key});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 2, 4, 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: colors.accent),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  gradient: colors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, size: 11, color: colors.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
