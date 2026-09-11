import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/event.dart';
import '../cubit/day_events_cubit.dart';
import '../l10n/events_strings.dart';
import 'add_reminder_button.dart';
import 'events_list_body.dart';
import 'festival_tile.dart';
import 'my_event_row.dart';

/// Reusable "कार्यक्रमहरू" block for one day (date converter result, calendar
/// popups…): festival rows, the "My Events" card and – when [showTodos] –
/// the "To-Do" card of that date, plus an "Add Event/Reminder" pill that
/// opens the new-event form pre-filled with [date].
///
/// Self-contained: creates its own [DayEventsCubit] from `sl` (re-created
/// whenever [date] changes) and navigates to the event details on tap.
///
/// ```dart
/// EventsForDateSection(date: result.ad, showTodos: true)
/// ```
class EventsForDateSection extends StatelessWidget {
  const EventsForDateSection({
    required this.date,
    super.key,
    this.showTodos = true,
    this.showHeader = true,
    this.padding = AppSpacing.page,
    this.onEventTap,
    this.onAddReminder,
  });

  final DateTime date;
  final bool showTodos;
  final bool showHeader;
  final EdgeInsets padding;

  /// Defaults to pushing the event details route.
  final ValueChanged<Event>? onEventTap;

  /// Defaults to pushing [AppRoutes.eventCreate] with [date] as `extra`.
  final VoidCallback? onAddReminder;

  @override
  Widget build(BuildContext context) => BlocProvider<DayEventsCubit>(
    key: ValueKey(DateTime(date.year, date.month, date.day)),
    create: (_) => sl<DayEventsCubit>()..load(date),
    child: _Body(
      showTodos: showTodos,
      showHeader: showHeader,
      padding: padding,
      onEventTap:
          onEventTap ?? (e) => context.push(AppRoutes.eventDetailsPath(e.id)),
      onAddReminder:
          onAddReminder ??
          () => context.push(
            AppRoutes.eventCreate,
            extra: DateTime(date.year, date.month, date.day),
          ),
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body({
    required this.showTodos,
    required this.showHeader,
    required this.padding,
    required this.onEventTap,
    required this.onAddReminder,
  });
  final bool showTodos;
  final bool showHeader;
  final EdgeInsets padding;
  final ValueChanged<Event> onEventTap;
  final VoidCallback onAddReminder;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    return BlocConsumer<DayEventsCubit, DayEventsState>(
      listenWhen: (p, c) =>
          c.actionFailure != null && p.actionFailure != c.actionFailure,
      listener: (context, state) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.actionFailure!.message))),
      builder: (context, state) {
        final cubit = context.read<DayEventsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showHeader)
              SectionHeader(
                title: s.homeSectionTitle,
                padding: EdgeInsets.symmetric(
                  horizontal: padding.left,
                  vertical: AppSpacing.xs,
                ),
                trailing: AddReminderButton(onTap: onAddReminder),
              ),
            Padding(
              padding: padding,
              child: switch (state.events) {
                Idle() || Loading() when state.eventList.isEmpty =>
                  const LoadingView(height: 60),
                Failed(:final failure) when state.eventList.isEmpty => Text(
                  failure.message,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.error,
                  ),
                ),
                _
                    when state.eventList.isEmpty ||
                        (!showTodos &&
                            state.festivals.isEmpty &&
                            state.personal.isEmpty) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xs,
                    ),
                    child: Text(
                      s.noEvents,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                _ => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final e in state.festivals)
                      FestivalTile(
                        event: e,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        onTap: () => onEventTap(e),
                        onAddReminder: onAddReminder,
                      ),
                    if (state.personal.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      MyEventsCard(
                        title: s.myEvents,
                        margin: EdgeInsets.zero,
                        children: _rows(state.personal, cubit),
                      ),
                    ],
                    if (showTodos && state.todos.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      MyEventsCard(
                        title: s.todoLists,
                        margin: EdgeInsets.zero,
                        children: _rows(state.todos, cubit),
                      ),
                    ],
                  ],
                ),
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _rows(List<Event> events, DayEventsCubit cubit) => [
    for (var i = 0; i < events.length; i++)
      MyEventRow(
        event: events[i],
        showDivider: i != events.length - 1,
        onTap: () => onEventTap(events[i]),
        onToggleChecklist: (itemId) =>
            cubit.toggleChecklist(events[i].id, itemId),
      ),
  ];
}
