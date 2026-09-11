import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../cubit/consult_intake_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/consult_format.dart';

/// Confirm birth details, pick a channel and see the cost before starting.
class ConsultIntakePage extends StatelessWidget {
  const ConsultIntakePage({
    required this.astrologerId,
    super.key,
    this.channel,
  });

  final String astrologerId;
  final ConsultChannel? channel;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        GetIt.I<ConsultIntakeCubit>(param1: astrologerId, param2: channel)
          ..load(),
    child: const _IntakeView(),
  );
}

class _IntakeView extends StatefulWidget {
  const _IntakeView();

  @override
  State<_IntakeView> createState() => _IntakeViewState();
}

class _IntakeViewState extends State<_IntakeView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _question = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _place.dispose();
    _question.dispose();
    super.dispose();
  }

  IconData _channelIcon(ConsultChannel c) => switch (c) {
    ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
    ConsultChannel.voice => Icons.call_outlined,
    ConsultChannel.video => Icons.videocam_outlined,
  };

  Future<void> _pickDate(BuildContext context) async {
    final cubit = context.read<ConsultIntakeCubit>();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: cubit.state.intake.birthDate ?? DateTime(now.year - 25),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) cubit.setBirthDate(picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final cubit = context.read<ConsultIntakeCubit>();
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null && context.mounted) {
      cubit.setBirthTime(picked.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<ConsultIntakeCubit, ConsultIntakeState>(
      listenWhen: (p, n) => p.starting != n.starting,
      listener: (context, state) {
        if (state.starting.isFailed) {
          AppSnack.error(
            context,
            state.starting.errorMessage ?? context.l10n.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ConsultIntakeCubit>();
        final astrologer = state.provider;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.startConsultation, showBack: true),
          body: SafeArea(
            top: false,
            child: astrologer == null
                ? (state.astrologer.isFailed
                      ? ErrorView(
                          message: state.astrologer.errorMessage,
                          onRetry: cubit.load,
                        )
                      : const LoadingView())
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.pageGutter),
                    children: [
                      Row(
                        children: [
                          AppAvatar(
                            source: astrologer.avatarAsset,
                            name: astrologer.name.en,
                            size: 46,
                            verified: astrologer.isVerified,
                            online: astrologer.isOnline,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  astrologer.name.forLanguage(
                                    context.languageCode,
                                  ),
                                  style: context.textTheme.headlineSmall,
                                ),
                                Text(
                                  astrologer.headline.forLanguage(
                                    context.languageCode,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        s.consultationType,
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          for (final channel in astrologer.channels) ...[
                            Expanded(
                              child: _ChannelCard(
                                icon: _channelIcon(channel),
                                label: channel.name,
                                rate: astrologer.rateFor(channel)!,
                                selected: state.intake.channel == channel,
                                onTap: () => cubit.setChannel(channel),
                              ),
                            ),
                            if (channel != astrologer.channels.last)
                              const SizedBox(width: AppSpacing.sm),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Text(s.yourDetails, style: context.textTheme.titleSmall),
                      const SizedBox(height: AppSpacing.sm),
                      AppTextField(
                        controller: _name,
                        label: s.whoIsThisFor,
                        hint: s.namePlaceholder,
                        required: true,
                        onChanged: cubit.setName,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _PickerField(
                        label: s.dateOfBirth,
                        required: true,
                        value: state.intake.birthDate == null
                            ? null
                            : DateFormat.yMMMd(
                                context.languageCode,
                              ).format(state.intake.birthDate!),
                        placeholder: s.selectDate,
                        icon: Icons.calendar_today_outlined,
                        onTap: () => _pickDate(context),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _PickerField(
                        label: s.timeOfBirth,
                        required: !state.intake.birthTimeUnknown,
                        enabled: !state.intake.birthTimeUnknown,
                        value: state.intake.birthTime,
                        placeholder: s.selectDate,
                        icon: Icons.schedule_outlined,
                        onTap: () => _pickTime(context),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      LabeledToggle(
                        label: s.timeUnknown,
                        value: state.intake.birthTimeUnknown,
                        onChanged: (v) => cubit.setBirthTimeUnknown(unknown: v),
                      ),
                      if (state.intake.birthTimeUnknown)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xs),
                          child: Text(
                            s.timeUnknownNote,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        controller: _place,
                        label: s.placeOfBirth,
                        hint: s.placePlaceholder,
                        required: true,
                        onChanged: cubit.setBirthPlace,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      AppTextField(
                        controller: _question,
                        label: '${s.yourQuestion} (${s.questionOptional})',
                        hint: s.questionPlaceholder,
                        maxLines: 4,
                        minLines: 3,
                        onChanged: cubit.setQuestion,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _CostCard(state: state),
                    ],
                  ),
          ),
          bottomNavigationBar: astrologer == null
              ? null
              : _StartBar(state: state),
        );
      },
    );
  }
}

class _ChannelCard extends StatelessWidget {
  const _ChannelCard({
    required this.icon,
    required this.label,
    required this.rate,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final double rate;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      onTap: onTap,
      elevated: false,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      color: selected ? colors.accent.withValues(alpha: 0.08) : colors.surface,
      border: Border.all(
        color: selected ? colors.accent : colors.border,
        width: selected ? 1.5 : 1,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
            color: selected ? colors.accent : colors.iconMuted,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: selected ? colors.accent : colors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          const SizedBox(height: 2),
          MoneyText(
            rate,
            style: context.textTheme.labelSmall,
            color: colors.textMuted,
          ),
        ],
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.placeholder,
    required this.icon,
    required this.onTap,
    this.value,
    this.required = false,
    this.enabled = true,
  });

  final String label;
  final String? value;
  final String placeholder;
  final IconData icon;
  final VoidCallback onTap;
  final bool required;
  final bool enabled;

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: enabled ? 1 : 0.5,
    child: AppTextField(
      label: label,
      required: required,
      readOnly: true,
      enabled: enabled,
      hint: value ?? placeholder,
      onTap: enabled ? onTap : null,
      suffix: Icon(icon, size: 18, color: context.colors.iconMuted),
    ),
  );
}

class _CostCard extends StatelessWidget {
  const _CostCard({required this.state});

  final ConsultIntakeState state;

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;
    final rate = RegionFormat.money(
      state.ratePerMinute,
      config: context.regionConfig,
      languageCode: context.languageCode,
    );

    return AppCard(
      elevated: false,
      color: colors.surfaceVariant,
      child: KeyValueList(
        divided: true,
        children: [
          KeyValueRow(label: s.ratePerMinute, value: '$rate/min'),
          KeyValueRow(
            label: s.yourBalance,
            valueWidget: MoneyText(
              state.balance,
              style: context.textTheme.bodyMedium,
            ),
          ),
          KeyValueRow(
            label: s.youCanTalkFor,
            emphasised: true,
            value: s.minutesLabel(
              consultDigits(context, state.affordableMinutes),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartBar extends StatelessWidget {
  const _StartBar({required this.state});

  final ConsultIntakeState state;

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<ConsultIntakeCubit>();

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: state.hasEnoughBalance
              ? PrimaryButton(
                  label: s.startNow,
                  height: 46,
                  isLoading: state.starting.isLoading,
                  onPressed: state.canStart
                      ? () async {
                          final session = await cubit.start();
                          if (session != null && context.mounted) {
                            context.pushReplacement(
                              AppRoutes.consultQueuePath(session.id),
                            );
                          }
                        }
                      : null,
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      s.notEnoughBalance,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: colors.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PrimaryButton(
                      label: s.addMoney,
                      height: 46,
                      onPressed: () => context.push(AppRoutes.walletTopUp),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
