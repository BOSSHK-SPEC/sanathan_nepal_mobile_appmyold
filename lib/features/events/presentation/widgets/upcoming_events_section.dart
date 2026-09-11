import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/event.dart';
import '../cubit/upcoming_events_cubit.dart';
import '../l10n/events_strings.dart';
import 'event_chip_row.dart';

/// Compact events block for the Home page (Figma Home `364:609` → "EVENTS").
///
/// Self-contained: creates its own [UpcomingEventsCubit] from `sl`, so the
/// Home feature can just drop it into its column:
///
/// ```dart
/// const UpcomingEventsSection()
/// ```
///
/// * Header "कार्यक्रमहरू" + pills `All events | Government holidays | My events`
/// * chips `बिदा` / `ब्रत`
/// * dot-list of the next [maxItems] events (tap → details)
/// * featured card (image + title + description) for the first event.
///
/// Tapping the title navigates to [AppRoutes.events]; override with [onSeeAll].
class UpcomingEventsSection extends StatelessWidget {
  const UpcomingEventsSection({
    super.key,
    this.maxItems = 4,
    this.onSeeAll,
    this.onEventTap,
  });

  final int maxItems;
  final VoidCallback? onSeeAll;
  final ValueChanged<Event>? onEventTap;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        UpcomingEventsCubit(getEvents: sl(), limit: maxItems)..load(),
    child: _SectionBody(
      onSeeAll: onSeeAll ?? () => context.push(AppRoutes.events),
      onEventTap:
          onEventTap ?? (e) => context.push(AppRoutes.eventDetailsPath(e.id)),
    ),
  );
}

class _SectionBody extends StatelessWidget {
  const _SectionBody({required this.onSeeAll, required this.onEventTap});
  final VoidCallback onSeeAll;
  final ValueChanged<Event> onEventTap;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final lang = context.languageCode;
    final cubit = context.watch<UpcomingEventsCubit>();
    final state = cubit.state;
    final featured = state.featured;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  s.homeSectionTitle,
                  style: context.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: EventChipRow(
                  padding: EdgeInsets.zero,
                  labels: [
                    s.homeAllEvents,
                    s.filterHolidays(context.regionConfig),
                    s.homeMyEvents,
                  ],
                  selectedIndex: UpcomingScope.values.indexOf(state.scope),
                  onChanged: (i) => cubit.selectScope(UpcomingScope.values[i]),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(width: 16, height: 2, color: colors.accent),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              EventChip(
                label: s.holiday,
                selected: state.onlyHolidays,
                color: colors.holiday,
                onTap: cubit.toggleHolidays,
              ),
              const SizedBox(width: 6),
              EventChip(
                label: s.vrat,
                selected: state.onlyVrat,
                color: colors.today,
                onTap: cubit.toggleVrat,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (state.events.isLoading && state.eventList.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Center(
                child: SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else ...[
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: 4,
              children: [
                for (final e in state.eventList)
                  _DotItem(
                    label: e.title.resolveFor(lang),
                    color: colors.accent,
                    onTap: () => onEventTap(e),
                  ),
                if (state.eventList.isEmpty)
                  _DotItem(label: s.noEvents, color: colors.textMuted),
              ],
            ),
            if (featured != null) ...[
              const SizedBox(height: AppSpacing.sm),
              GestureDetector(
                onTap: () => onEventTap(featured),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImage(
                      featured.imagePath ??
                          'assets/images/events/${featured.id}.png',
                      width: 105,
                      height: 60,
                      radius: AppRadius.sm,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            featured.title.resolveFor(lang),
                            style: context.textTheme.titleSmall,
                          ),
                          Text(
                            featured.description.resolveFor(lang),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _DotItem extends StatelessWidget {
  const _DotItem({required this.label, required this.color, this.onTap});
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label, style: context.textTheme.labelSmall),
      ],
    ),
  );
}
