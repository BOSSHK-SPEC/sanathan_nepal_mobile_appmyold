import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../cubit/events_list_cubit.dart';
import '../l10n/events_strings.dart';
import 'checklist_popup.dart';
import 'festival_tile.dart';
import 'my_event_row.dart';

/// Non-scrolling body of the active events tab (embedded in the page's
/// scroll view): festival rows, or the "My Events" / "To-Do" card with its
/// column header and divider-separated rows.
class EventsListBody extends StatelessWidget {
  const EventsListBody({
    required this.state,
    required this.onTap,
    super.key,
    this.onAddReminder,
    this.onEdit,
    this.onDelete,
  });

  final EventsListState state;
  final ValueChanged<Event> onTap;
  final ValueChanged<Event>? onAddReminder;
  final ValueChanged<Event>? onEdit;
  final ValueChanged<Event>? onDelete;

  void _showChecklist(BuildContext context, Event event) {
    final cubit = context.read<EventsListCubit>();
    ChecklistPopup.show(
      context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<EventsListCubit, EventsListState>(
          builder: (context, st) {
            final current = st.eventList.firstWhere(
              (e) => e.id == event.id,
              orElse: () => event,
            );
            return ChecklistPopup(
              items: current.checklist,
              title: current.title.resolveFor(context.languageCode),
              onToggle: (itemId) => cubit.toggleChecklist(event.id, itemId),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final events = state.visibleEvents;
    if (events.isEmpty) {
      return SizedBox(
        height: 160,
        child: EmptyView(message: s.noEvents, icon: Icons.event_busy_outlined),
      );
    }
    if (state.group == EventGroup.festival) {
      return Column(
        children: [
          for (final event in events)
            FestivalTile(
              event: event,
              onTap: () => onTap(event),
              onAddReminder: onAddReminder == null
                  ? null
                  : () => onAddReminder!(event),
            ),
        ],
      );
    }
    final cubit = context.read<EventsListCubit>();
    return MyEventsCard(
      title: state.group == EventGroup.todo ? s.todoLists : s.myEvents,
      children: [
        for (var i = 0; i < events.length; i++)
          MyEventRow(
            event: events[i],
            showDivider: i != events.length - 1,
            onTap: () => onTap(events[i]),
            onEdit: onEdit == null ? null : () => onEdit!(events[i]),
            onDelete: onDelete == null ? null : () => onDelete!(events[i]),
            onChecklist: () => _showChecklist(context, events[i]),
            onToggleChecklist: (itemId) =>
                cubit.toggleChecklist(events[i].id, itemId),
          ),
      ],
    );
  }
}

/// Bordered card with the "मेरो कार्यक्रमहरू … मिति" column header strip
/// (Figma "Rectangle 1069" + "Rectangle 2227") wrapping [MyEventRow]s.
class MyEventsCard extends StatelessWidget {
  const MyEventsCard({
    required this.title,
    required this.children,
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
  });

  final String title;
  final List<Widget> children;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final style = context.textTheme.labelSmall?.copyWith(
      color: colors.textSecondary,
      fontWeight: FontWeight.w600,
    );
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 25,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            color: colors.surfaceVariant,
            child: Row(
              children: [
                Expanded(child: Text(title, style: style)),
                SizedBox(
                  width: 74 + 32,
                  child: Text(s.date, style: style),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
