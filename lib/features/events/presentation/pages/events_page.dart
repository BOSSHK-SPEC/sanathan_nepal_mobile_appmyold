import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../cubit/events_list_cubit.dart';
import '../l10n/events_strings.dart';
import '../widgets/delete_event_dialog.dart';
import '../widgets/events_chip_bar.dart';
import '../widgets/events_header_card.dart';
import '../widgets/events_list_body.dart';
import '../widgets/events_tab_strip.dart';

/// Events page (Figma "Events Page" 625:1213 / 645:1936).
///
/// Top → bottom: "View calendar" link, today + month-grid header card, the
/// tab strip (Festivals · My Events · To-Do), the tab's filter chips (with the
/// "New Event +" / "New Reminder +" pill on the user tabs) and the list.
class EventsPage extends StatelessWidget {
  const EventsPage({super.key, this.initialGroup = EventGroup.festival});

  final EventGroup initialGroup;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<EventsListCubit>()..load(group: initialGroup),
    child: const _EventsView(),
  );
}

class _EventsView extends StatelessWidget {
  const _EventsView();

  Future<void> _openCreate(BuildContext context, {Event? template}) async {
    final saved = await context.push<Event>(
      AppRoutes.eventCreate,
      extra: template,
    );
    if (saved != null && context.mounted) {
      await context.read<EventsListCubit>().load(group: saved.group);
    }
  }

  Future<void> _openDetails(BuildContext context, Event event) async {
    await context.push(AppRoutes.eventDetailsPath(event.id));
    if (context.mounted) await context.read<EventsListCubit>().load();
  }

  Future<void> _delete(BuildContext context, Event event) async {
    final ok = await DeleteEventDialog.confirm(context);
    if (ok && context.mounted) {
      await context.read<EventsListCubit>().delete(event.id);
    }
  }

  Event _template(EventsListState state, [Event? from]) => Event(
    id: '',
    title: from?.title ?? LocalizedText.empty,
    description: from?.description ?? LocalizedText.empty,
    date: from?.date ?? DateTime.now(),
    category: state.group == EventGroup.todo
        ? EventCategory.todo
        : EventCategory.personal,
  );

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final cubit = context.watch<EventsListCubit>();
    final state = cubit.state;
    return BlocListener<EventsListCubit, EventsListState>(
      listenWhen: (p, c) =>
          c.actionFailure != null && p.actionFailure != c.actionFailure,
      listener: (context, state) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.actionFailure!.message))),
      child: Scaffold(
        appBar: AppTopBar(title: s.pageTitle, showBack: true),
        body: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => context.push(AppRoutes.patro),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Icons.calendar_month_outlined, size: 16),
                label: Text(
                  s.viewCalendar,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const EventsHeaderCard(),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: EventsTabStrip(
                labels: [s.tabFestivals, s.tabMyEvents, s.tabTodo],
                selectedIndex: EventGroup.values.indexOf(state.group),
                onChanged: (i) => cubit.selectGroup(EventGroup.values[i]),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            EventsChipBar(
              state: state,
              onNew: () => _openCreate(context, template: _template(state)),
            ),
            const SizedBox(height: AppSpacing.sm),
            switch (state.events) {
              Idle() || Loading() when state.eventList.isEmpty =>
                const SizedBox(height: 200, child: LoadingView()),
              Failed(:final failure) when state.eventList.isEmpty => SizedBox(
                height: 200,
                child: ErrorView(message: failure.message, onRetry: cubit.load),
              ),
              _ => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: EventsListBody(
                  state: state,
                  onTap: (e) => _openDetails(context, e),
                  onAddReminder: (e) =>
                      _openCreate(context, template: _template(state, e)),
                  onEdit: (e) => _openCreate(context, template: e),
                  onDelete: (e) => _delete(context, e),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
