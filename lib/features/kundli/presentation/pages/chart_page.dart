import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/dasha.dart';
import '../../domain/entities/dosha.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';
import '../cubit/chart_cubit.dart';
import '../l10n/kundli_strings.dart';
import '../widgets/kundli_diagram.dart';

/// One cast chart: diagram, planet table, dasha timeline and dosha report.
class ChartPage extends StatelessWidget {
  const ChartPage({required this.profileId, super.key});

  final String profileId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ChartCubit>(param1: profileId)..load(),
    child: const _ChartView(),
  );
}

class _ChartView extends StatelessWidget {
  const _ChartView();

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        final cubit = context.read<ChartCubit>();
        final kundli = state.kundli;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: kundli?.profile.name ?? s.kundli,
            showBack: true,
          ),
          body: SafeArea(
            top: false,
            child: kundli == null
                ? (state.chart.isFailed
                      ? ErrorView(
                          message: state.chart.errorMessage,
                          onRetry: cubit.load,
                        )
                      : const LoadingView())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.pageGutter,
                          vertical: AppSpacing.md,
                        ),
                        child: PillTabs(
                          labels: [s.chart, s.planets, s.dasha, s.dosha],
                          selectedIndex: state.tabIndex,
                          scrollable: true,
                          onChanged: cubit.selectTab,
                        ),
                      ),
                      Expanded(
                        child: switch (state.tab) {
                          ChartTab.chart => _ChartTab(state: state),
                          ChartTab.planets => _PlanetsTab(chart: kundli),
                          ChartTab.dasha => _DashaTab(state: state),
                          ChartTab.dosha => _DoshaTab(state: state),
                        },
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _ChartTab extends StatelessWidget {
  const _ChartTab({required this.state});

  final ChartState state;

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final cubit = context.read<ChartCubit>();
    final chart = state.kundli!;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        AppSegmentedControl(
          segments: [s.northIndian, s.southIndian],
          selectedIndex: state.style == ChartStyle.north ? 0 : 1,
          onChanged: (i) =>
              cubit.setStyle(i == 0 ? ChartStyle.north : ChartStyle.south),
        ),
        const SizedBox(height: AppSpacing.lg),
        KundliDiagram(chart: chart, style: state.style),
        const SizedBox(height: AppSpacing.lg),
        if (!chart.profile.supportsHouses)
          AppCard(
            elevated: false,
            color: context.colors.warning.withValues(alpha: 0.12),
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: context.colors.warning,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    s.noHousesBody,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        AppCard(
          child: KeyValueList(
            divided: true,
            children: [
              KeyValueRow(
                label: s.ascendant,
                value: s.rashiName(chart.ascendant),
              ),
              KeyValueRow(
                label: s.moonSign,
                value: s.rashiName(chart.moonSign),
              ),
              KeyValueRow(label: s.sunSign, value: s.rashiName(chart.sunSign)),
              KeyValueRow(
                label: s.birthStar,
                value:
                    '${s.nakshatraName(chart.janmaNakshatra)} · '
                    '${s.pada} ${_digits(context, chart.positionOf(Graha.moon).pada)}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanetsTab extends StatelessWidget {
  const _PlanetsTab({required this.chart});

  final KundliChart chart;

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final colors = context.colors;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        // Wide table: scrolls horizontally rather than squeezing columns.
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: colors.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 40,
              dataRowMinHeight: 40,
              dataRowMaxHeight: 44,
              columnSpacing: AppSpacing.xl,
              headingTextStyle: context.textTheme.labelMedium?.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w700,
              ),
              columns: [
                DataColumn(label: Text(s.planets)),
                DataColumn(label: Text(s.sign)),
                DataColumn(label: Text(s.degree)),
                if (chart.profile.supportsHouses)
                  DataColumn(label: Text(s.house)),
                DataColumn(label: Text(s.birthStar)),
              ],
              rows: [
                for (final p in chart.positions)
                  DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            Text(
                              s.grahaName(p.graha),
                              style: context.textTheme.bodyMedium,
                            ),
                            if (p.retrograde) ...[
                              const SizedBox(width: 3),
                              Tooltip(
                                message: s.retrograde,
                                child: Text(
                                  '℞',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(color: colors.error),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      DataCell(
                        Text(
                          s.rashiName(p.rashi),
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                      DataCell(
                        Text(
                          p.formattedDegrees,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                      if (chart.profile.supportsHouses)
                        DataCell(
                          Text(
                            _digits(context, p.house),
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                      DataCell(
                        Text(
                          '${s.nakshatraName(p.nakshatra)} '
                          '${_digits(context, p.pada)}',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DashaTab extends StatelessWidget {
  const _DashaTab({required this.state});

  final ChartState state;

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<ChartCubit>();
    final current = state.currentDasha;

    if (state.dashas.isLoading && state.dashaList.isEmpty) {
      return const AppSkeletonList.tiles(count: 5);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        if (current != null) _CurrentDashaCard(period: current, strings: s),
        const SizedBox(height: AppSpacing.lg),
        Text(
          s.vimshottariNote,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final period in state.dashaList)
          _DashaRow(
            period: period,
            strings: s,
            expanded: state.expandedDasha == period.graha.name,
            onTap: () => cubit.expandDasha(period.graha.name),
          ),
      ],
    );
  }
}

class _CurrentDashaCard extends StatelessWidget {
  const _CurrentDashaCard({required this.period, required this.strings});

  final DashaPeriod period;
  final KundliStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final antar = period.currentChild();
    final format = DateFormat.yMMM(context.languageCode);

    return AppCard(
      gradient: colors.cardGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusChip(
            label: strings.currentPeriod,
            tone: StatusTone.accent,
            dense: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${strings.grahaName(period.graha)} ${strings.mahadasha}',
            style: context.textTheme.displaySmall?.copyWith(fontSize: 20),
          ),
          if (antar != null)
            Text(
              '${strings.grahaName(antar.graha)} ${strings.antardasha} · '
              '${format.format(antar.start)} – ${format.format(antar.end)}',
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: period.progress(),
              minHeight: 6,
              backgroundColor: colors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(colors.accent),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${format.format(period.start)} – ${format.format(period.end)}',
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashaRow extends StatelessWidget {
  const _DashaRow({
    required this.period,
    required this.strings,
    required this.expanded,
    required this.onTap,
  });

  final DashaPeriod period;
  final KundliStrings strings;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final format = DateFormat.yMMM(context.languageCode);
    final current = period.isCurrent();
    final past = period.isPast();

    return AppCard(
      onTap: onTap,
      elevated: false,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      color: current ? colors.accent.withValues(alpha: 0.08) : colors.surface,
      border: Border.all(color: current ? colors.accent : colors.border),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  strings.grahaName(period.graha),
                  style: context.textTheme.titleSmall?.copyWith(
                    color: past ? colors.textMuted : colors.textPrimary,
                  ),
                ),
              ),
              Text(
                '${format.format(period.start)} – ${format.format(period.end)}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                expanded
                    ? Icons.expand_less_rounded
                    : Icons.expand_more_rounded,
                size: 18,
                color: colors.iconMuted,
              ),
            ],
          ),
          if (expanded) ...[
            Divider(height: AppSpacing.xl, color: colors.divider),
            for (final child in period.children)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: child.isCurrent()
                            ? colors.accent
                            : colors.divider,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        strings.grahaName(child.graha),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: child.isCurrent()
                              ? colors.accent
                              : colors.textSecondary,
                          fontWeight: child.isCurrent()
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      '${format.format(child.start)} – '
                      '${format.format(child.end)}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _DoshaTab extends StatelessWidget {
  const _DoshaTab({required this.state});

  final ChartState state;

  StatusTone _tone(DoshaSeverity severity) => switch (severity) {
    DoshaSeverity.none => StatusTone.success,
    DoshaSeverity.mild => StatusTone.info,
    DoshaSeverity.moderate => StatusTone.warning,
    DoshaSeverity.high => StatusTone.danger,
  };

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final colors = context.colors;

    if (state.doshas.isLoading && state.doshaList.isEmpty) {
      return const AppSkeletonList.tiles(count: 3);
    }

    if (state.activeDoshas.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_outlined, size: 44, color: colors.success),
              const SizedBox(height: AppSpacing.md),
              Text(s.noDoshaTitle, style: context.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                s.noDoshaBody,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        for (final dosha in state.activeDoshas)
          AppCard(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.doshaName(dosha.kind),
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    StatusChip(
                      label: s.severityName(dosha.severity),
                      tone: _tone(dosha.severity),
                      dense: true,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  s.doshaExplanation(dosha.kind, dosha.severity),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                if (dosha.isCancelled) ...[
                  const SizedBox(height: AppSpacing.sm),
                  StatusChip(
                    label: s.cancelled,
                    tone: StatusTone.success,
                    icon: Icons.shield_outlined,
                    dense: true,
                  ),
                ],
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        PrimaryButton(
          label: s.consultAboutThis,
          height: 46,
          onPressed: () => context.push(AppRoutes.astrologers),
        ),
      ],
    );
  }
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
