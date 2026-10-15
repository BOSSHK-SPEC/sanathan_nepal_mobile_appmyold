import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_segmented_control.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/entities/time_window.dart';
import '../cubit/day_periods_cubit.dart';
import '../l10n/panchanga_strings.dart';
import '../widgets/day_arc.dart';
import '../widgets/day_factors_card.dart';
import '../widgets/day_period_row.dart';
import '../widgets/panchanga_format.dart';

/// Choghadiya, hora and the kaal windows for one day.
///
/// Every division on this page is a fraction of the same sunrise and sunset,
/// so they are shown together rather than as three separate calculators — and
/// they always agree with the times the panchanga page printed.
class DayPeriodsPage extends StatelessWidget {
  const DayPeriodsPage({super.key, this.initialDate, this.cubit});

  final DateTime? initialDate;

  /// Injected by tests; production builds one from the registered use case.
  final DayPeriodsCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DayPeriodsCubit>(
      create: (_) =>
          (cubit ?? sl<DayPeriodsCubit>(param1: initialDate))..load(),
      child: const _DayPeriodsView(),
    );
  }
}

class _DayPeriodsView extends StatefulWidget {
  const _DayPeriodsView();

  @override
  State<_DayPeriodsView> createState() => _DayPeriodsViewState();
}

class _DayPeriodsViewState extends State<_DayPeriodsView> {
  Timer? _timer;
  AppLifecycleListener? _lifecycle;

  @override
  void initState() {
    super.initState();
    // A minute is the finest this screen ever shows, so it is also how often
    // the "now" marker needs to move.
    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => context.read<DayPeriodsCubit>().tick(),
    );
    // A screen left open overnight would otherwise still be pointing at last
    // evening when it comes back.
    _lifecycle = AppLifecycleListener(
      onResume: () => context.read<DayPeriodsCubit>().tick(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _lifecycle?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = PanchangaStrings.of(context);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.dayPeriods, showBack: true),
      body: BlocBuilder<DayPeriodsCubit, DayPeriodsState>(
        builder: (context, state) {
          final cubit = context.read<DayPeriodsCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: AppSegmentedControl(
                  segments: [s.choghadiya, s.hora, s.kaalWindows],
                  selectedIndex: state.view.index,
                  onChanged: (i) =>
                      cubit.selectView(DayPeriodView.values[i]),
                ),
              ),
              Expanded(
                child: switch (state.today) {
                  Loading() || Idle() => const LoadingView(),
                  Failed(:final failure) => ErrorView(
                    message: failure.message,
                    onRetry: cubit.load,
                  ),
                  Loaded(:final data) => _Periods(state: state, today: data),
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Periods extends StatelessWidget {
  const _Periods({required this.state, required this.today});

  final DayPeriodsState state;
  final Panchanga today;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = PanchangaStrings.of(context);
    final devanagari = context.usesDevanagariDigits;
    final current = state.currentWindow;
    final night = state.nightSection;

    String span(DateTime a, DateTime b) =>
        PanchangaFormat.range(a, b, devanagari: devanagari);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.xxl,
      ),
      children: [
        _Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  child: DayArc(
                    day: state.daySection,
                    night: night,
                    now: state.now,
                    sunrise: today.sunrise,
                    sunset: today.sunset,
                    nextSunrise: state.nextSunrise,
                  ),
                ),
                if (current != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  _NowLine(window: current, now: state.now),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _SectionTitle(label: s.dayFactors, detail: ''),
        _Card(child: DayFactorsCard(state: state)),
        const SizedBox(height: AppSpacing.md),
        _SectionTitle(
          label: s.dayHalf,
          detail: span(today.sunrise, today.sunset),
        ),
        _Card(child: _Rows(windows: state.daySection, current: current)),
        if (state.expectsNight) ...[
          const SizedBox(height: AppSpacing.md),
          _SectionTitle(
            label: s.nightHalf,
            detail: state.nextSunrise == null
                ? ''
                : span(today.sunset, state.nextSunrise!),
          ),
          _Card(
            child: night.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      s.nightUnavailable,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  )
                : _Rows(windows: night, current: current),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 12,
              color: today.isApproximate ? colors.warning : colors.textMuted,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                today.isApproximate ? s.approximateNote : s.periodsNote,
                style: context.textTheme.labelSmall?.copyWith(
                  color: today.isApproximate
                      ? colors.warning
                      : colors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// The table card the rest of the panchanga screens use.
class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: child,
    );
  }
}

class _Rows extends StatelessWidget {
  const _Rows({required this.windows, required this.current});

  final List<TimeWindow> windows;
  final TimeWindow? current;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < windows.length; i++)
        DayPeriodRow(
          window: windows[i],
          isCurrent: identical(windows[i], current),
          tinted: i.isEven,
        ),
    ],
  );
}

/// What is running now, under the ring.
class _NowLine extends StatelessWidget {
  const _NowLine({required this.window, required this.now});

  final TimeWindow window;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;
    final s = PanchangaStrings.of(context);
    final devanagari = context.usesDevanagariDigits;
    final tint = DayPeriodRow.qualityColor(colors, window.quality);
    final left = window.end.difference(now);
    final label = window.nameEn.isEmpty
        ? s.kaalLabel(window.kind)
        : window.name(nepali: context.isNepali || context.isHindi);

    return Row(
      children: [
        Container(width: 3, height: 34, color: tint),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${s.nowLabel} · ${s.qualityLabel(window.quality)}',
                style: text.labelSmall?.copyWith(color: colors.textSecondary),
              ),
              Text(
                label,
                style: text.titleMedium?.copyWith(
                  color: tint,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              PanchangaFormat.digits(
                '${left.inHours}h ${(left.inMinutes % 60)}m',
                devanagari: devanagari,
              ),
              style: text.titleMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            Text(
              '${s.until} '
              '${PanchangaFormat.hm(window.end, devanagari: devanagari)}',
              style: text.labelSmall?.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}

/// Bold section heading above a card, as on the panchanga page.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label, required this.detail});

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            detail,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
