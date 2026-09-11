import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/availability.dart';
import '../cubit/schedule_cubit.dart';
import '../l10n/console_strings.dart';

/// Weekly working hours and days off.
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ScheduleCubit>()..load(),
    child: const _ScheduleView(),
  );
}

class _ScheduleView extends StatelessWidget {
  const _ScheduleView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        final cubit = context.read<ScheduleCubit>();
        final schedule = state.working;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.navSchedule, showBack: true),
          body: SafeArea(
            top: false,
            child:
                state.availability.isLoading &&
                    state.availability.dataOrNull == null
                ? const AppSkeletonList.tiles(count: 5)
                : ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.pageGutter,
                      AppSpacing.md,
                      AppSpacing.pageGutter,
                      AppSpacing.xxxl,
                    ),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: StatTile(
                              label: s.weeklyHours,
                              icon: Icons.schedule_outlined,
                              value: _digits(
                                context,
                                schedule.weeklyHours.toStringAsFixed(1),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: StatTile(
                              label: s.bufferBetween,
                              icon: Icons.timer_outlined,
                              value: s.minutesLabel(
                                _digits(context, schedule.bufferMinutes),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      for (var weekday = 1; weekday <= 7; weekday++)
                        _DayRow(
                          weekday: weekday,
                          windows: schedule.windowsOn(weekday),
                          strings: s,
                          onAdd: () => _addWindow(context, weekday),
                          onRemove: cubit.removeWindow,
                          onCopy: weekday <= 5
                              ? () => cubit.copyToAllWeekdays(weekday)
                              : null,
                        ),
                      const SizedBox(height: AppSpacing.lg),
                      SectionHeader(
                        title: s.blackoutDates,
                        padding: EdgeInsets.zero,
                        trailing: TextButton.icon(
                          onPressed: () => _addBlackout(context),
                          icon: const Icon(Icons.add_rounded, size: 16),
                          label: Text(s.addBlackout),
                        ),
                      ),
                      if (schedule.blackouts.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          child: Text(
                            s.noBlackouts,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        )
                      else
                        for (final blackout in schedule.blackouts)
                          AppCard(
                            elevated: false,
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.event_busy_outlined,
                                  size: 18,
                                  color: colors.iconMuted,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Text(
                                    DateFormat.yMMMEd(
                                      context.languageCode,
                                    ).format(blackout.date),
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                    color: colors.iconMuted,
                                  ),
                                  onPressed: () =>
                                      cubit.removeBlackout(blackout),
                                ),
                              ],
                            ),
                          ),
                      if (state.saveError != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          state.saveError!,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: colors.error,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: colors.divider)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: PrimaryButton(
                  label: s.saveSchedule,
                  height: 46,
                  isLoading: state.saving.isLoading,
                  onPressed: state.hasChanges
                      ? () async {
                          final ok = await cubit.save();
                          if (ok && context.mounted) {
                            AppSnack.success(context, s.scheduleSaved);
                          }
                        }
                      : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _addWindow(BuildContext context, int weekday) async {
    final cubit = context.read<ScheduleCubit>();
    final start = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      helpText: ConsoleStrings.of(context).from,
    );
    if (start == null || !context.mounted) return;
    final end = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: (start.hour + 4) % 24, minute: 0),
      helpText: ConsoleStrings.of(context).to,
    );
    if (end == null) return;

    cubit.addWindow(
      AvailabilityWindow(
        weekday: weekday,
        startMinute: start.hour * 60 + start.minute,
        endMinute: end.hour * 60 + end.minute,
      ),
    );
  }

  Future<void> _addBlackout(BuildContext context) async {
    final cubit = context.read<ScheduleCubit>();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) cubit.addBlackout(BlackoutDate(date: picked));
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({
    required this.weekday,
    required this.windows,
    required this.strings,
    required this.onAdd,
    required this.onRemove,
    this.onCopy,
  });

  final int weekday;
  final List<AvailabilityWindow> windows;
  final ConsoleStrings strings;
  final VoidCallback onAdd;
  final ValueChanged<AvailabilityWindow> onRemove;
  final VoidCallback? onCopy;

  String _time(BuildContext context, int minutes) {
    final text =
        '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
        '${(minutes % 60).toString().padLeft(2, '0')}';
    return context.usesDevanagariDigits ? text.toDevanagariDigits() : text;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      elevated: false,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 44,
                child: Text(
                  strings.weekdayShort(weekday),
                  style: context.textTheme.titleSmall?.copyWith(
                    color: windows.isEmpty
                        ? colors.textMuted
                        : colors.textPrimary,
                  ),
                ),
              ),
              Expanded(
                child: windows.isEmpty
                    ? Text(
                        strings.noWindows,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      )
                    : Wrap(
                        spacing: AppSpacing.xs + 2,
                        runSpacing: AppSpacing.xs,
                        children: [
                          for (final window in windows)
                            InputChip(
                              label: Text(
                                '${_time(context, window.startMinute)}'
                                '–${_time(context, window.endMinute)}',
                                style: context.textTheme.labelSmall,
                              ),
                              onDeleted: () => onRemove(window),
                              deleteIcon: const Icon(
                                Icons.close_rounded,
                                size: 14,
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
              ),
              IconButton(
                icon: Icon(Icons.add_rounded, size: 20, color: colors.accent),
                onPressed: onAdd,
              ),
            ],
          ),
          if (onCopy != null && windows.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onCopy,
                child: Text(
                  strings.copyToWeekdays,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.accent,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
