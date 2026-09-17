import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/section_chevron_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/currency.dart';
import '../cubit/forex_cubit.dart';
import '../l10n/forex_strings.dart';
import 'currency_converter_card.dart';
import 'currency_dropdown.dart';
import 'forex_format.dart';
import 'forex_rates_table.dart';
import 'forex_trend_panel.dart';

/// Compact forex block for the Home page (Figma "FOREX SECTION" 340×312):
/// header with pinned rates, trend chart, converter, pinned-currency table,
/// "select currency" dropdown and a "more info" link to [AppRoutes.forex].
///
/// Usage: `const ForexSection()` – creates and loads its own [ForexCubit]
/// from GetIt. Pass [cubit] to reuse one (e.g. tests); [onMoreTap] overrides
/// the default navigation.
class ForexSection extends StatelessWidget {
  const ForexSection({
    super.key,
    this.cubit,
    this.onMoreTap,
    this.margin = AppSpacing.page,
  });

  final ForexCubit? cubit;
  final VoidCallback? onMoreTap;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final body = Padding(
      padding: margin,
      child: AppCard(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: BlocBuilder<ForexCubit, ForexState>(
          builder: (context, state) => _SectionBody(
            state: state,
            onMoreTap: onMoreTap ?? () => context.push(AppRoutes.forex),
          ),
        ),
      ),
    );
    if (cubit != null) return BlocProvider.value(value: cubit!, child: body);
    return BlocProvider(create: (_) => sl<ForexCubit>()..load(), child: body);
  }
}

class _SectionBody extends StatelessWidget {
  const _SectionBody({required this.state, required this.onMoreTap});
  final ForexState state;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ForexStrings.of(context);
    final dv = context.usesDevanagariDigits;
    final cubit = context.read<ForexCubit>();

    if (!state.hasRates) {
      return SizedBox(
        height: 120,
        child: switch (state.rates) {
          Failed(:final failure) => ErrorView(
            message: failure.message,
            onRetry: cubit.load,
          ),
          _ => const LoadingView(),
        },
      );
    }

    final headerRates = state.favouriteRates
        .take(3)
        .map(
          (r) =>
              '${_short(r.currency)} '
              '${ForexFormat.rate(r.buy, devanagari: dv)}',
        )
        .join(' | ');
    final options = [for (final r in state.rateList) r.currency];
    final unpinned = [
      for (final r in state.rateList)
        if (!state.favourites.contains(r.currency.iso3)) r.currency,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(s.title, style: context.textTheme.headlineSmall),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                headerRates,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                  fontSize: 9,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            // A `>` rather than the accent rule, like Panchanga, Events and
            // Suva Sait: the rule read as decoration, so the full forex page
            // (every currency, longer trends) went undiscovered.
            SectionChevronButton(onPressed: onMoreTap),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ForexTrendPanel(
          state: state,
          onRangeChanged: cubit.selectRange,
          onCurrencyChanged: cubit.selectTrendCurrency,
          chartHeight: 80,
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: CurrencyConverterCard(
            from: state.currency(state.fromIso3),
            to: state.currency(state.toIso3),
            amount: state.amount,
            conversion: state.conversion,
            options: options,
            local: state.local,
            onFromChanged: (c) => cubit.setFromCurrency(c.iso3),
            onToChanged: (c) => cubit.setToCurrency(c.iso3),
            onAmountChanged: cubit.setAmount,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: ForexRatesTable(rates: state.favouriteRates),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: CurrencyDropdown(
                value: null,
                hint: s.selectCurrencyToShow,
                options: unpinned,
                showFlag: false,
                onChanged: (c) => _pin(context, c),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            TextButton(
              onPressed: onMoreTap,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                s.moreForexInfo,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w600,
                  fontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pin(BuildContext context, Currency c) async {
    final ok = await context.read<ForexCubit>().toggleFavourite(c.iso3);
    if (!ok && context.mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(ForexStrings.of(context).maxFavourites)),
      );
    }
  }

  /// Figma header abbreviations: "USD | UK | AUD".
  static String _short(Currency c) => c.iso3 == 'GBP' ? 'UK' : c.iso3;
}
