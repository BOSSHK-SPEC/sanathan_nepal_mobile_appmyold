import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/presentation/l10n/astrologers_strings.dart';
import '../cubit/work_preferences_cubit.dart';
import '../l10n/console_strings.dart';

/// When work is allowed to interrupt, and which work is offered at all.
///
/// Deliberately not folded into the seeker's notification settings: those
/// are about content the app sends, these decide whether a paid request
/// reaches the astrologer. Every control saves on change.
class WorkSettingsPage extends StatelessWidget {
  const WorkSettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<WorkPreferencesCubit>()..load(),
    child: const _WorkSettingsView(),
  );
}

class _WorkSettingsView extends StatelessWidget {
  const _WorkSettingsView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final a = AstrologersStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<WorkPreferencesCubit, WorkPreferencesState>(
      listenWhen: (p, c) => c.saveError != null && p.saveError != c.saveError,
      listener: (context, state) => AppSnack.error(context, state.saveError!),
      builder: (context, state) {
        final cubit = context.read<WorkPreferencesCubit>();
        final prefs = state.working;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.workSettings, showBack: true),
          body: SafeArea(
            top: false,
            child: !state.isReady
                ? const AppSkeletonList.tiles(count: 6)
                : ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.pageGutter,
                      AppSpacing.md,
                      AppSpacing.pageGutter,
                      AppSpacing.xxxl,
                    ),
                    children: [
                      SectionHeader(title: s.alerts),
                      AppCard(
                        child: Column(
                          children: [
                            _SwitchRow(
                              label: s.newRequestAlerts,
                              note: s.newRequestAlertsNote,
                              value: prefs.newRequestAlerts,
                              onChanged: cubit.setNewRequestAlerts,
                            ),
                            // The sound and ring options only mean anything
                            // when request alerts are on at all.
                            _SwitchRow(
                              label: s.alertSound,
                              value: prefs.alertSound,
                              enabled: prefs.newRequestAlerts,
                              onChanged: cubit.setAlertSound,
                            ),
                            _SwitchRow(
                              label: s.ringUntilAnswered,
                              note: s.ringUntilAnsweredNote,
                              value: prefs.ringUntilAnswered,
                              enabled: prefs.newRequestAlerts,
                              onChanged: cubit.setRingUntilAnswered,
                            ),
                            _SwitchRow(
                              label: s.scheduleReminders,
                              value: prefs.scheduleReminders,
                              onChanged: cubit.setScheduleReminders,
                            ),
                            _SwitchRow(
                              label: s.payoutAlerts,
                              value: prefs.payoutAlerts,
                              onChanged: cubit.setPayoutAlerts,
                            ),
                            _SwitchRow(
                              label: s.reviewAlerts,
                              value: prefs.reviewAlerts,
                              onChanged: cubit.setReviewAlerts,
                            ),
                            _SwitchRow(
                              label: s.marketingAlerts,
                              value: prefs.marketingAlerts,
                              onChanged: cubit.setMarketingAlerts,
                              last: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      SectionHeader(title: s.quietHours),
                      AppCard(
                        child: Column(
                          children: [
                            _SwitchRow(
                              label: s.quietHours,
                              note: s.quietHoursNote,
                              value: prefs.quietHoursEnabled,
                              onChanged: cubit.setQuietHoursEnabled,
                              last: !prefs.quietHoursEnabled,
                            ),
                            if (prefs.quietHoursEnabled)
                              Row(
                                children: [
                                  Expanded(
                                    child: _TimeField(
                                      label: s.quietFrom,
                                      minuteOfDay: prefs.quietStartMinute,
                                      onChanged: (m) =>
                                          cubit.setQuietWindow(startMinute: m),
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: _TimeField(
                                      label: s.quietTo,
                                      minuteOfDay: prefs.quietEndMinute,
                                      onChanged: (m) =>
                                          cubit.setQuietWindow(endMinute: m),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      SectionHeader(title: s.requestRouting),
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.channelsYouAccept,
                              style: context.textTheme.titleSmall,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            FilterChipGroup<ConsultChannel>(
                              options: ConsultChannel.values,
                              labelOf: a.channelName,
                              // Empty means all, so show all as selected —
                              // otherwise "accepting everything" looks like
                              // "accepting nothing".
                              selected: prefs.acceptedChannels.isEmpty
                                  ? ConsultChannel.values.toSet()
                                  : prefs.acceptedChannels,
                              onChanged: (next) {
                                for (final channel in ConsultChannel.values) {
                                  final was = prefs.acceptsChannel(channel);
                                  if (was != next.contains(channel)) {
                                    cubit.toggleChannel(channel);
                                  }
                                }
                              },
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            _StepperRow(
                              label: s.maxQueueLength,
                              note: s.maxQueueLengthNote,
                              value: prefs.maxQueueLength == 0
                                  ? s.noQueueCap
                                  : s.peopleWaiting(prefs.maxQueueLength),
                              onDecrement: prefs.maxQueueLength == 0
                                  ? null
                                  : () => cubit.setMaxQueueLength(
                                      prefs.maxQueueLength - 1,
                                    ),
                              onIncrement: prefs.maxQueueLength >= 20
                                  ? null
                                  : () => cubit.setMaxQueueLength(
                                      prefs.maxQueueLength + 1,
                                    ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            _StepperRow(
                              label: s.autoDeclineAfter,
                              note: s.autoDeclineAfterNote,
                              value: s.seconds(prefs.autoDeclineAfterSeconds),
                              onDecrement: prefs.autoDeclineAfterSeconds <= 15
                                  ? null
                                  : () => cubit.setAutoDeclineAfter(
                                      prefs.autoDeclineAfterSeconds - 15,
                                    ),
                              onIncrement: prefs.autoDeclineAfterSeconds >= 120
                                  ? null
                                  : () => cubit.setAutoDeclineAfter(
                                      prefs.autoDeclineAfterSeconds + 15,
                                    ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _SwitchRow(
                              label: s.autoAcceptRepeat,
                              note: s.autoAcceptRepeatNote,
                              value: prefs.autoAcceptRepeatClients,
                              onChanged: cubit.setAutoAcceptRepeatClients,
                              last: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

/// A [ToggleRow] with the divider the settings cards use between rows.
class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.note,
    this.enabled = true,
    this.last = false,
  });

  final String label;
  final String? note;
  final bool value;
  final bool enabled;
  final bool last;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ToggleRow(
        label: label,
        note: note,
        value: value,
        enabled: enabled,
        onChanged: onChanged,
      ),
      if (!last) Divider(color: context.colors.divider, height: 1),
    ],
  );
}

/// A labelled value with minus/plus, for the two numeric limits.
///
/// A slider would imply a continuous range; both of these move in meaningful
/// discrete steps, and the current value has to stay readable.
class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    this.note,
  });

  final String label;
  final String? note;
  final String value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline_rounded),
              color: colors.accent,
              onPressed: onDecrement,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 72),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: context.textTheme.labelLarge?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded),
              color: colors.accent,
              onPressed: onIncrement,
            ),
          ],
        ),
        if (note != null)
          Text(
            note!,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
      ],
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.minuteOfDay,
    required this.onChanged,
  });

  final String label;
  final int minuteOfDay;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay(hour: minuteOfDay ~/ 60, minute: minuteOfDay % 60);
    return AppTextField(
      label: label,
      readOnly: true,
      controller: TextEditingController(text: time.format(context)),
      suffix: const Icon(Icons.schedule_rounded, size: 18),
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (picked != null) onChanged(picked.hour * 60 + picked.minute);
      },
    );
  }
}
