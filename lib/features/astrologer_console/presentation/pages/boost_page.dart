import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/boost.dart';
import '../cubit/boost_cubit.dart';
import '../l10n/console_strings.dart';

/// Buy visibility, and see whether it paid for itself.
///
/// Every plan shows a cost per thousand estimated views so two plans with
/// different durations are actually comparable, and every finished campaign
/// shows cost per consultation — the only number that says whether the
/// spend was worth it.
class ConsoleBoostPage extends StatelessWidget {
  const ConsoleBoostPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ConsoleBoostCubit>()..load(),
    child: const _BoostView(),
  );
}

class _BoostView extends StatelessWidget {
  const _BoostView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ConsoleBoostCubit, ConsoleBoostState>(
      builder: (context, state) {
        final cubit = context.read<ConsoleBoostCubit>();

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.boost, showBack: true),
          body: SafeArea(
            top: false,
            child: state.plans.isLoading && state.allPlans.isEmpty
                ? const AppSkeletonList.tiles(count: 4)
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.pageGutter),
                    children: [
                      Text(
                        s.boostBody,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      if (state.active.isNotEmpty) ...[
                        Text(
                          s.activeBoosts,
                          style: context.textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        for (final campaign in state.active)
                          _CampaignCard(
                            campaign: campaign,
                            strings: s,
                            active: true,
                          ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      Text(s.choosePlan, style: context.textTheme.titleSmall),
                      const SizedBox(height: AppSpacing.sm),
                      for (final plan in state.allPlans)
                        _PlanCard(
                          plan: plan,
                          strings: s,
                          selected: state.selectedPlanId == plan.id,
                          onTap: () => cubit.select(plan.id),
                        ),
                      if (state.cannotAfford) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          s.cannotAfford,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: colors.error,
                          ),
                        ),
                      ],
                      if (state.buyError != null) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          state.buyError!,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: colors.error,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      PrimaryButton(
                        label: s.buyBoost,
                        height: 46,
                        isLoading: state.buying.isLoading,
                        onPressed: state.canBuy
                            ? () async {
                                final ok = await cubit.buy();
                                if (ok && context.mounted) {
                                  AppSnack.success(context, s.boostBought);
                                }
                              }
                            : null,
                      ),
                      if (state.past.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.xxl),
                        Text(s.pastBoosts, style: context.textTheme.titleSmall),
                        const SizedBox(height: AppSpacing.sm),
                        for (final campaign in state.past)
                          _CampaignCard(
                            campaign: campaign,
                            strings: s,
                            active: false,
                          ),
                      ],
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.strings,
    required this.selected,
    required this.onTap,
  });

  final BoostPlan plan;
  final ConsoleStrings strings;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      onTap: onTap,
      elevated: false,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      color: selected ? colors.accent.withValues(alpha: 0.08) : colors.surface,
      border: Border.all(
        color: selected ? colors.accent : colors.border,
        width: selected ? 1.5 : 1,
      ),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 20,
            color: selected ? colors.accent : colors.iconMuted,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        strings.placementName(plan.placement),
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    if (plan.popular) ...[
                      const SizedBox(width: AppSpacing.sm),
                      StatusChip(
                        label: strings.popular,
                        tone: StatusTone.accent,
                        dense: true,
                      ),
                    ],
                  ],
                ),
                Text(
                  '${_digits(context, plan.days)} ${strings.daysLabel} · '
                  '${strings.estimatedImpressions} '
                  '~${_compact(context, plan.estimatedImpressions)}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MoneyText(plan.price, style: context.textTheme.titleSmall),
              Row(
                children: [
                  MoneyText(
                    plan.pricePerDay,
                    style: context.textTheme.labelSmall,
                    color: colors.textMuted,
                  ),
                  Text(
                    ' ${strings.perDay}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  const _CampaignCard({
    required this.campaign,
    required this.strings,
    required this.active,
  });

  final BoostCampaign campaign;
  final ConsoleStrings strings;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      border: active ? Border.all(color: colors.accent) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  strings.placementName(campaign.placement),
                  style: context.textTheme.titleSmall,
                ),
              ),
              if (active)
                StatusChip(
                  label:
                      '${_digits(context, campaign.daysRemaining())} '
                      '${strings.daysLeft}',
                  tone: StatusTone.accent,
                  dense: true,
                )
              else
                MoneyText(
                  campaign.spent,
                  style: context.textTheme.labelMedium,
                  color: colors.textMuted,
                ),
            ],
          ),
          if (active) ...[
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: campaign.progress,
                minHeight: 5,
                backgroundColor: colors.surfaceVariant,
                valueColor: AlwaysStoppedAnimation(colors.accent),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _Metric(
                label: strings.impressions,
                value: _compact(context, campaign.impressions),
              ),
              _Metric(
                label: strings.profileViews,
                value: _compact(context, campaign.profileViews),
              ),
              _Metric(
                label: strings.consultationsFromBoost,
                value: _digits(context, campaign.consultations),
              ),
            ],
          ),
          if (!active && campaign.consultations > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Divider(color: colors.divider),
            KeyValueRow(
              label: strings.costPerConsultation,
              emphasised: true,
              valueWidget: MoneyText(
                campaign.costPerConsultation,
                style: context.textTheme.titleSmall,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textTheme.headlineSmall?.copyWith(
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.textMuted,
          ),
        ),
      ],
    ),
  );
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}

/// 10 400 → "10.4k", so a metric row never wraps.
String _compact(BuildContext context, int value) {
  final text = value >= 1000
      ? '${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k'
      : '$value';
  return context.usesDevanagariDigits ? text.toDevanagariDigits() : text;
}
