import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/gun_milan.dart';
import '../cubit/gun_milan_cubit.dart';
import '../l10n/kundli_strings.dart';

/// Ashtakoota matching: pick two saved charts, then read the 36-point score.
///
/// Input and result share a route deliberately — changing one chart and
/// re-scoring is the main thing people do here, and a separate result page
/// would make that a two-step round trip every time.
class GunMilanPage extends StatelessWidget {
  const GunMilanPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<GunMilanCubit>()..load(),
    child: const _GunMilanView(),
  );
}

class _GunMilanView extends StatelessWidget {
  const _GunMilanView();

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.gunMilan, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<GunMilanCubit, GunMilanState>(
          builder: (context, state) {
            final cubit = context.read<GunMilanCubit>();

            if (state.profiles.isLoading && state.charts.isEmpty) {
              return const AppSkeletonList.tiles(count: 3);
            }
            if (!state.hasEnoughCharts) {
              return _NeedCharts(strings: s);
            }

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                _ChartPicker(
                  label: s.bride,
                  icon: Icons.female_rounded,
                  charts: state.charts,
                  selectedId: state.brideId,
                  strings: s,
                  onSelected: cubit.selectBride,
                ),
                const SizedBox(height: AppSpacing.md),
                _ChartPicker(
                  label: s.groom,
                  icon: Icons.male_rounded,
                  charts: state.charts,
                  selectedId: state.groomId,
                  strings: s,
                  onSelected: cubit.selectGroom,
                ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: s.checkMatch,
                  height: 46,
                  isLoading: state.result.isLoading,
                  onPressed: state.canMatch ? cubit.match : null,
                ),
                if (state.result.isFailed) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    state.result.errorMessage ??
                        context.l10n.somethingWentWrong,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ],
                if (state.score != null) ...[
                  const SizedBox(height: AppSpacing.xxl),
                  _ScoreDial(result: state.score!, strings: s),
                  const SizedBox(height: AppSpacing.xl),
                  if (state.score!.blockers.isNotEmpty)
                    AppCard(
                      elevated: false,
                      color: colors.error.withValues(alpha: 0.1),
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.error_outline_rounded,
                                size: 18,
                                color: colors.error,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  s.blockingTitle,
                                  style: context.textTheme.titleSmall?.copyWith(
                                    color: colors.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            s.blockingBody,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  _ManglikCard(result: state.score!, strings: s),
                  const SizedBox(height: AppSpacing.lg),
                  Text(s.kootaBreakdown, style: context.textTheme.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  AppCard(
                    child: Column(
                      children: [
                        for (final score in state.score!.scores)
                          _KootaRow(score: score, strings: s),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: s.consultAstrologer,
                    height: 46,
                    onPressed: () => context.push(AppRoutes.astrologers),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ChartPicker extends StatelessWidget {
  const _ChartPicker({
    required this.label,
    required this.icon,
    required this.charts,
    required this.selectedId,
    required this.strings,
    required this.onSelected,
  });

  final String label;
  final IconData icon;
  final List<BirthProfile> charts;
  final String? selectedId;
  final KundliStrings strings;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final selected = charts.where((c) => c.id == selectedId).firstOrNull;

    return AppCard(
      onTap: () => _pick(context),
      elevated: false,
      border: Border.all(
        color: selected == null ? colors.border : colors.accent,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.accent.withValues(alpha: 0.12),
            ),
            child: Icon(icon, size: 20, color: colors.accent),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                Text(
                  selected?.name ?? strings.selectChart,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: selected == null
                        ? colors.textMuted
                        : colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.expand_more_rounded, color: colors.iconMuted),
        ],
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final picked = await AppBottomSheet.show<String>(
      context,
      builder: (sheetContext) => AppBottomSheet(
        title: label,
        scrollable: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final chart in charts)
              ListTile(
                leading: AppAvatar(name: chart.name, size: 36),
                title: Text(chart.name, style: context.textTheme.titleSmall),
                subtitle: Text(
                  strings.relationName(chart.relation),
                  style: context.textTheme.labelSmall,
                ),
                trailing: chart.id == selectedId
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: context.colors.accent,
                      )
                    : null,
                onTap: () => Navigator.of(sheetContext).pop(chart.id),
              ),
          ],
        ),
      ),
    );
    if (picked != null) onSelected(picked);
  }
}

class _ScoreDial extends StatelessWidget {
  const _ScoreDial({required this.result, required this.strings});

  final GunMilanResult result;
  final KundliStrings strings;

  Color _tint(BuildContext context) => switch (result.verdict) {
    MatchVerdict.excellent || MatchVerdict.good => context.colors.success,
    MatchVerdict.average => context.colors.warning,
    MatchVerdict.poor => context.colors.error,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tint = _tint(context);
    final digits = context.usesDevanagariDigits;
    final points = digits
        ? '${result.total}'.toDevanagariDigits()
        : '${result.total}';

    return Column(
      children: [
        SizedBox(
          width: 168,
          height: 168,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: result.ratio,
                  strokeWidth: 12,
                  strokeCap: StrokeCap.round,
                  backgroundColor: colors.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation(tint),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    points,
                    style: context.textTheme.displayLarge?.copyWith(
                      color: tint,
                      fontSize: 46,
                      height: 1,
                    ),
                  ),
                  Text(
                    strings.outOf36,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          strings.verdictName(result.verdict),
          style: context.textTheme.displaySmall?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          strings.verdictBody(result.verdict),
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _ManglikCard extends StatelessWidget {
  const _ManglikCard({required this.result, required this.strings});

  final GunMilanResult result;
  final KundliStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bride = result.brideManglik.isPresent;
    final groom = result.groomManglik.isPresent;

    final (label, tone) = switch ((bride, groom)) {
      (true, true) => (strings.manglikBoth, StatusTone.info),
      (false, false) => (strings.manglikNeither, StatusTone.success),
      _ => (strings.manglikOneSided, StatusTone.warning),
    };

    return AppCard(
      elevated: false,
      color: colors.surfaceVariant,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.manglikStatus,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                Text(label, style: context.textTheme.titleSmall),
              ],
            ),
          ),
          StatusChip(
            label: result.manglikMismatch
                ? strings.severityName(
                    bride
                        ? result.brideManglik.severity
                        : result.groomManglik.severity,
                  )
                : strings.severityName(
                    bride
                        ? result.brideManglik.severity
                        : result.brideManglik.severity,
                  ),
            tone: tone,
            dense: true,
          ),
        ],
      ),
    );
  }
}

class _KootaRow extends StatelessWidget {
  const _KootaRow({required this.score, required this.strings});

  final KootaScore score;
  final KundliStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final digits = context.usesDevanagariDigits;
    String n(int value) => digits ? '$value'.toDevanagariDigits() : '$value';

    final tint = score.isBlocking
        ? colors.error
        : score.ratio >= 0.75
        ? colors.success
        : score.ratio >= 0.4
        ? colors.warning
        : colors.error;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.kootaName(score.koota),
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  strings.kootaMeaning(score.koota),
                  maxLines: 2,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: score.ratio,
                minHeight: 7,
                backgroundColor: colors.surfaceVariant,
                valueColor: AlwaysStoppedAnimation(tint),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          SizedBox(
            width: 46,
            child: Text(
              '${n(score.points)}/${n(score.maxPoints)}',
              textAlign: TextAlign.end,
              style: context.textTheme.labelMedium?.copyWith(
                color: tint,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NeedCharts extends StatelessWidget {
  const _NeedCharts({required this.strings});

  final KundliStrings strings;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 44,
            color: context.colors.textMuted,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(strings.needTwoCharts, style: context.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            strings.needTwoChartsBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: strings.newChart,
            expanded: false,
            onPressed: () => context.push(AppRoutes.kundliNew),
          ),
        ],
      ),
    ),
  );
}
