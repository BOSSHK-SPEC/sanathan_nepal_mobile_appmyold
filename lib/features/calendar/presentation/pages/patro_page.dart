import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../cubit/calendar_cubit.dart';
import '../l10n/calendar_strings.dart';
import '../widgets/calendar_event_card.dart';
import '../widgets/event_detail_sheet.dart';
import '../widgets/month_calendar_view.dart';

/// Patro screen (Figma 320:361 / 320:1250 / 331:2221 / 320:825).
class PatroPage extends StatelessWidget {
  const PatroPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<CalendarCubit>(
    create: (_) => sl<CalendarCubit>()..load(),
    child: const _PatroView(),
  );
}

class _PatroView extends StatelessWidget {
  const _PatroView();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = CalendarStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(title: strings.title, showBack: true),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          final events = state.events;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const MonthCalendarView(showViewToggle: true),
                      const SizedBox(height: AppSpacing.xxl),
                      Row(
                        children: [
                          Expanded(
                            child: AdBanner(
                              label: strings.patroAds,
                              height: 81,
                              margin: EdgeInsets.zero,
                              showArrows: false,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: AdBanner(
                              label: strings.patroAds,
                              height: 81,
                              margin: EdgeInsets.zero,
                              showArrows: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: colors.surfaceVariant,
                  padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
                  child: Text(
                    strings.events,
                    style: context.textTheme.titleSmall,
                  ),
                ),
              ),
              if (events.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    color: colors.surfaceVariant,
                    padding: const EdgeInsets.fromLTRB(6, 10, 6, 40),
                    child: Text(
                      strings.noEvents,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                )
              else
                DecoratedSliver(
                  decoration: BoxDecoration(color: colors.surfaceVariant),
                  sliver: SliverPadding(
                    padding: const EdgeInsets.fromLTRB(6, 10, 6, 40),
                    sliver: SliverList.separated(
                      itemCount: events.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, i) {
                        final event = events[i];
                        final day = _dayFor(state.days, event);
                        return CalendarEventCard(
                          event: event,
                          day: day,
                          onTap: () => EventDetailSheet.show(
                            context,
                            event: event,
                            day: day,
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  static CalendarDay _dayFor(List<CalendarDay> days, CalendarEvent e) =>
      days.firstWhere((d) => e.isOn(d.ad), orElse: () => days.first);
}
