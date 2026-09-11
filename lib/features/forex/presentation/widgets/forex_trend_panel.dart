import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/currency.dart';
import '../../domain/entities/forex_range.dart';
import '../cubit/forex_cubit.dart';
import '../l10n/forex_strings.dart';
import 'currency_dropdown.dart';
import 'forex_format.dart';
import 'forex_range_selector.dart';
import 'forex_trend_chart.dart';

/// Trend block shared by the page and the home section: "USD TO NRS - TREND"
/// title (tap to change currency), publication date, range selector +
/// legend, and the line chart.
class ForexTrendPanel extends StatelessWidget {
  const ForexTrendPanel({
    required this.state,
    required this.onRangeChanged,
    required this.onCurrencyChanged,
    super.key,
    this.chartHeight = 96,
  });

  final ForexState state;
  final ValueChanged<ForexRange> onRangeChanged;
  final ValueChanged<String> onCurrencyChanged;
  final double chartHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ForexStrings.of(context);
    final config = context.regionConfig;
    final date = state.ratesDate;
    final options = [for (final r in state.rateList) r.currency];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: options.isEmpty
                  ? null
                  : () async {
                      final picked = await showModalBottomSheet<Currency>(
                        context: context,
                        useSafeArea: true,
                        showDragHandle: true,
                        backgroundColor: colors.surface,
                        builder: (_) => CurrencyPickerSheet(
                          options: options,
                          selected: state.trendCurrency,
                        ),
                      );
                      if (picked != null) onCurrencyChanged(picked.iso3);
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    s.trendTitle(
                      state.trendIso3,
                      ForexFormat.localLabel(config),
                    ),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 14,
                    color: colors.iconMuted,
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (date != null)
              Flexible(
                child: Text(
                  ForexFormat.publishedDate(
                    date,
                    calendar: config.calendar,
                    languageCode: context.languageCode,
                  ),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    color: colors.accent,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ForexRangeSelector(range: state.range, onChanged: onRangeChanged),
        const SizedBox(height: AppSpacing.sm),
        if (state.history.isLoading && state.historyPoints.isEmpty)
          SizedBox(
            height: chartHeight,
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          )
        else
          ForexTrendChart(
            points: state.historyPoints,
            range: state.range,
            height: chartHeight,
          ),
      ],
    );
  }
}
