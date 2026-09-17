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
import '../widgets/date_detail_sheet.dart';
import '../widgets/event_detail_sheet.dart';
import '../widgets/month_calendar_view.dart';
import '../widgets/patro_legend.dart';
import '../widgets/vrat_day_card.dart';

/// Patro screen (Figma 320:361 / 320:1250 / 331:2221 / 320:825): the month
/// grid with its legend, then the month's events and vrat days, filterable to
/// holidays or vrat only.
class PatroPage extends StatelessWidget {
  const PatroPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<CalendarCubit>(
    create: (_) => sl<CalendarCubit>()..load(),
    child: const _PatroView(),
  );
}

/// Which items the month list shows.
enum _ListFilter { all, holidays, vrat }

/// One row of the month list: an event, or a vrat day.
sealed class _ListItem {
  const _ListItem(this.date);
  final DateTime date;
}

final class _EventItem extends _ListItem {
  _EventItem(this.event, this.day) : super(day.ad);
  final CalendarEvent event;
  final CalendarDay day;
}

final class _VratItem extends _ListItem {
  _VratItem(this.day) : super(day.ad);
  final CalendarDay day;
}

class _PatroView extends StatefulWidget {
  const _PatroView();

  @override
  State<_PatroView> createState() => _PatroViewState();
}

class _PatroViewState extends State<_PatroView> {
  // View state only — which list to show — so it lives with the view rather
  // than in the cubit that loads the month.
  _ListFilter _filter = _ListFilter.all;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = CalendarStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(title: strings.title, showBack: true),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          final items = _items(state);
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const MonthCalendarView(showViewToggle: true),
                      const SizedBox(height: AppSpacing.sm),
                      const PatroLegend(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(strings.events, style: context.textTheme.titleSmall),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.xs,
                        children: [
                          for (final filter in _ListFilter.values)
                            ChoiceChip(
                              label: Text(_label(strings, filter)),
                              selected: _filter == filter,
                              onSelected: (_) =>
                                  setState(() => _filter = filter),
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (items.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    color: colors.surfaceVariant,
                    padding: const EdgeInsets.fromLTRB(6, 10, 6, 40),
                    child: Text(
                      _filter == _ListFilter.vrat
                          ? strings.noVratDays
                          : strings.noEvents,
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
                      itemCount: items.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, i) => switch (items[i]) {
                        _EventItem(:final event, :final day) =>
                          CalendarEventCard(
                            event: event,
                            day: day,
                            onTap: () => EventDetailSheet.show(
                              context,
                              event: event,
                              day: day,
                            ),
                          ),
                        _VratItem(:final day) => VratDayCard(
                          day: day,
                          onTap: () => DateDetailSheet.show(context, day),
                        ),
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

  /// The month's events and vrat days under the active filter, by date, an
  /// event before a vrat on the same day.
  List<_ListItem> _items(CalendarState state) {
    final days = state.days;
    final items = <_ListItem>[
      if (_filter != _ListFilter.vrat)
        for (final event in state.events)
          if (_filter == _ListFilter.all || event.isHoliday)
            _EventItem(event, _dayFor(days, event)),
      if (_filter != _ListFilter.holidays)
        for (final day in days)
          if (day.isCurrentMonth && (day.exactPanchanga?.isVrat ?? false))
            _VratItem(day),
    ];
    return items..sort((a, b) {
      final byDate = a.date.compareTo(b.date);
      if (byDate != 0) return byDate;
      return (a is _EventItem ? 0 : 1).compareTo(b is _EventItem ? 0 : 1);
    });
  }

  static String _label(CalendarStrings strings, _ListFilter filter) =>
      switch (filter) {
        _ListFilter.all => strings.filterAll,
        _ListFilter.holidays => strings.holiday,
        _ListFilter.vrat => strings.vratDays,
      };

  static CalendarDay _dayFor(List<CalendarDay> days, CalendarEvent e) =>
      days.firstWhere((d) => e.isOn(d.ad), orElse: () => days.first);
}
