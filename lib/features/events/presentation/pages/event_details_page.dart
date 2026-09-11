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
import '../cubit/event_details_cubit.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import '../widgets/days_left_badge.dart';
import '../widgets/delete_event_dialog.dart';
import '../widgets/festival_details_body.dart';
import '../widgets/personal_event_details_body.dart';

/// Event details (Figma "Events Details" 657:1584 light / 700:2286 dark).
///
/// Festivals show the Video · Description · How-to-celebrate · Places card;
/// personal events / to-dos show their details, checklist and edit/delete.
class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    key: ValueKey(eventId),
    create: (_) => sl<EventDetailsCubit>()..load(eventId),
    child: _DetailsView(eventId: eventId),
  );
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({required this.eventId});

  final String eventId;

  Future<void> _edit(BuildContext context, Event event) async {
    final saved = await context.push<Event>(
      AppRoutes.eventCreate,
      extra: event,
    );
    if (saved != null && context.mounted) {
      context.read<EventDetailsCubit>().refreshWith(saved);
    }
  }

  Future<void> _delete(BuildContext context) async {
    final ok = await DeleteEventDialog.confirm(context);
    if (ok && context.mounted) await context.read<EventDetailsCubit>().delete();
  }

  Future<void> _addReminder(BuildContext context, Event event) => context.push(
    AppRoutes.eventCreate,
    extra: Event(
      id: '',
      title: event.title,
      description: event.description,
      date: event.date,
      category: EventCategory.personal,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    return BlocConsumer<EventDetailsCubit, EventDetailsState>(
      listenWhen: (p, c) =>
          p.deletion != c.deletion || p.actionFailure != c.actionFailure,
      listener: (context, state) {
        if (state.isDeleted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.eventDeleted)));
          context.pop();
          return;
        }
        final failure = state.deletion.failureOrNull ?? state.actionFailure;
        if (failure != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        }
      },
      builder: (context, state) {
        final event = state.event.dataOrNull;
        return Scaffold(
          appBar: AppTopBar(
            title: event?.title.resolveFor(context.languageCode) ?? '',
            showBack: true,
            actions: [
              if (event != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: Center(child: DaysLeftBadge(days: event.daysLeft())),
                ),
            ],
          ),
          body: switch (state.event) {
            Failed(:final failure) when event == null => ErrorView(
              message: failure.message,
              onRetry: () => context.read<EventDetailsCubit>().load(eventId),
            ),
            _ when event == null => const LoadingView(),
            _ =>
              event.isMine
                  ? PersonalEventDetailsBody(
                      event: event,
                      onToggleChecklist: (id) =>
                          context.read<EventDetailsCubit>().toggleChecklist(id),
                      onEdit: () => _edit(context, event),
                      onDelete: () => _delete(context),
                    )
                  : FestivalDetailsBody(
                      event: event,
                      // Panchanga & Suva Sait of the festival day.
                      onPanchanga: () => context.push(
                        '${AppRoutes.panchanga}'
                        '?date=${EventDateFormat.adIso(event.date)}',
                      ),
                      onAddReminder: () => _addReminder(context, event),
                    ),
          },
        );
      },
    );
  }
}
