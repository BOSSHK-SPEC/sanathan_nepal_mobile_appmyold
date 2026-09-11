import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/panchanga_cubit.dart';
import '../l10n/sait_strings.dart';
import 'panchanga_format.dart';
import 'sait_month_table.dart';

/// Full "शुभ साइत तथा मुहूर्तहरू" panel of the Panchanga page (Figma
/// "SUVA SAIT"): title + मासिक/वार्षिक tabs, today's saits as bullets (or the
/// "आज कुनै शुभ साइत … फेला परेन" line), month/year navigator and the
/// category × dates table. Expects a [PanchangaCubit] above.
class SuvaSaitPanel extends StatelessWidget {
  const SuvaSaitPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final config = context.regionConfig;
    final devanagari = context.usesDevanagariDigits;
    final calendar = context.traditionalCalendar;
    final s = SaitStrings.of(context);
    return BlocBuilder<PanchangaCubit, PanchangaState>(
      builder: (context, state) {
        final cubit = context.read<PanchangaCubit>();
        final saits = state.allSaits;
        final today = state.saitsToday;
        final selected = calendar.fromGregorian(state.date);
        final highlight =
            selected.year == state.saitYear && selected.month == state.saitMonth
            ? selected.day
            : null;
        final monthName = calendar.monthName(
          state.saitMonth,
          languageCode: context.languageCode,
        );
        final yearLabel = PanchangaFormat.digits(
          '${state.saitYear}',
          devanagari: devanagari,
        );
        final yearly = state.saitView == SaitView.yearly;
        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  Text(
                    s.title(config),
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _ViewTabs(view: state.saitView, onChanged: cubit.setSaitView),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              if (state.saits case Failed(:final failure))
                ErrorView(message: failure.message, onRetry: cubit.load)
              else if (state.saits.isLoading && saits.isEmpty)
                const LoadingView(height: 80)
              else if (saits.isEmpty)
                // The tables below browse published windows; with none there
                // is nothing to page through, so the month/year navigator and
                // the grid are left out rather than shown empty.
                _Bullet(text: s.noSaitsPublished(config))
              else ...[
                if (today.isEmpty)
                  _Bullet(text: s.noSaitToday(config))
                else
                  for (final sait in today)
                    _Bullet(text: sait.title(nepali: devanagari)),
                const SizedBox(height: AppSpacing.md),
                _NavRow(
                  previousLabel: yearly
                      ? s.previousYear(config)
                      : s.previousMonth(config),
                  nextLabel: yearly ? s.nextYear(config) : s.nextMonth(config),
                  title: yearly
                      ? s.yearTitle(yearLabel, config)
                      : s.monthTitle(monthName, config),
                  onPrevious: yearly
                      ? cubit.previousSaitYear
                      : cubit.previousSaitMonth,
                  onNext: yearly ? cubit.nextSaitYear : cubit.nextSaitMonth,
                ),
                const SizedBox(height: AppSpacing.sm),
                SaitMonthTable(
                  saits: saits,
                  year: state.saitYear,
                  month: state.saitMonth,
                  highlightDay: highlight,
                  monthStrip: yearly
                      ? SaitMonthStrip(
                          calendar: calendar,
                          selectedMonth: state.saitMonth,
                          onSelect: (m) => cubit.selectSaitMonth(
                            year: state.saitYear,
                            month: m,
                          ),
                        )
                      : null,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// "मासिक शुभ साइत | वार्षिक शुभ साइत" text tabs (Figma "TAB").
class _ViewTabs extends StatelessWidget {
  const _ViewTabs({required this.view, required this.onChanged});
  final SaitView view;
  final ValueChanged<SaitView> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final config = context.regionConfig;
    final s = SaitStrings.of(context);
    Widget tab(SaitView v, String label) {
      final selected = v == view;
      return InkWell(
        onTap: () => onChanged(v),
        borderRadius: BorderRadius.circular(AppRadius.xs),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? colors.accent : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: selected ? colors.accent : colors.textSecondary,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.sm,
      children: [
        tab(SaitView.monthly, s.monthlyTab(config)),
        tab(SaitView.yearly, s.yearlyTab(config)),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6, right: AppSpacing.sm),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: context.colors.accent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        Expanded(child: Text(text, style: context.textTheme.bodySmall)),
      ],
    ),
  );
}

/// "‹ अघिल्लो महिना   फागुन महिनाको शुभ साइत   आगामी महिना ›".
class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.previousLabel,
    required this.nextLabel,
    required this.title,
    required this.onPrevious,
    required this.onNext,
  });
  final String previousLabel;
  final String nextLabel;
  final String title;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final small = context.textTheme.labelSmall?.copyWith(
      color: colors.textSecondary,
    );
    return Row(
      children: [
        Flexible(
          child: InkWell(
            onTap: onPrevious,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_left, size: 14, color: colors.accent),
                Flexible(
                  child: Text(
                    previousLabel,
                    style: small,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Flexible(
          child: InkWell(
            onTap: onNext,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    nextLabel,
                    style: small,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.chevron_right, size: 14, color: colors.accent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
