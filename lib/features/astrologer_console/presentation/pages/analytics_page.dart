import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/presentation/l10n/astrologers_strings.dart';
import '../../domain/entities/earnings.dart';
import '../cubit/earnings_cubit.dart';
import '../l10n/console_strings.dart';

/// Performance over a range: volume, averages, channel split and trend.
class ConsoleAnalyticsPage extends StatelessWidget {
  const ConsoleAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<EarningsCubit>()..load(),
    child: const _AnalyticsView(),
  );
}

class _AnalyticsView extends StatelessWidget {
  const _AnalyticsView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final a = AstrologersStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<EarningsCubit, EarningsState>(
      builder: (context, state) {
        final cubit = context.read<EarningsCubit>();
        final metrics = state.metrics;
        final totalByChannel = metrics.sessionsByChannel.values.fold<int>(
          0,
          (sum, v) => sum + v,
        );

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.analytics, showBack: true),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.md,
                AppSpacing.pageGutter,
                AppSpacing.xxxl,
              ),
              children: [
                AppSegmentedControl(
                  segments: [
                    for (final range in EarningsRange.values)
                      s.rangeName(range),
                  ],
                  selectedIndex: EarningsRange.values.indexOf(state.range),
                  onChanged: (i) => cubit.setRange(EarningsRange.values[i]),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (metrics.earningsSeries.length > 1) ...[
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.earningsTrend,
                          style: context.textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        SizedBox(
                          height: 88,
                          child: AppSparkline(
                            values: metrics.earningsSeries,
                            strokeWidth: 2.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        label: s.totalSessions,
                        icon: Icons.forum_outlined,
                        value: _digits(context, metrics.totalSessions),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        label: s.totalMinutes,
                        icon: Icons.timer_outlined,
                        value: _digits(context, metrics.totalMinutes),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        label: s.avgSession,
                        icon: Icons.straighten_outlined,
                        value: s.minutesLabel(
                          _digits(
                            context,
                            metrics.averageSessionMinutes.round(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        label: s.avgEarning,
                        icon: Icons.payments_outlined,
                        valueWidget: MoneyText(
                          metrics.averageEarningPerSession,
                          style: context.textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        label: s.acceptanceRate,
                        icon: Icons.task_alt_outlined,
                        value:
                            '${_digits(context, (metrics.acceptanceRate * 100).round())}%',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        label: s.repeatRate,
                        icon: Icons.repeat_rounded,
                        value:
                            '${_digits(context, (metrics.repeatRate * 100).round())}%',
                      ),
                    ),
                  ],
                ),
                if (totalByChannel > 0) ...[
                  const SizedBox(height: AppSpacing.xl),
                  Text(s.byChannel, style: context.textTheme.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  AppCard(
                    child: Column(
                      children: [
                        for (final entry in metrics.sessionsByChannel.entries)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.md,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 78,
                                  child: Text(
                                    a.channelName(
                                      ConsultChannel.fromName(entry.key),
                                    ),
                                    style: context.textTheme.bodySmall,
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.pill,
                                    ),
                                    child: LinearProgressIndicator(
                                      value: entry.value / totalByChannel,
                                      minHeight: 7,
                                      backgroundColor: colors.surfaceVariant,
                                      valueColor: AlwaysStoppedAnimation(
                                        colors.accent,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                SizedBox(
                                  width: 32,
                                  child: Text(
                                    _digits(context, entry.value),
                                    textAlign: TextAlign.end,
                                    style: context.textTheme.labelMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
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

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
