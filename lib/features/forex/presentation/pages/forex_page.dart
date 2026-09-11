import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/forex_cubit.dart';
import '../l10n/forex_strings.dart';
import '../widgets/currency_converter_card.dart';
import '../widgets/forex_rates_table.dart';
import '../widgets/forex_trend_panel.dart';

/// Full forex screen (Figma `580:967` light / `735:3367` dark).
class ForexPage extends StatelessWidget {
  const ForexPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<ForexCubit>()..load(),
    child: const ForexView(),
  );
}

/// Stateless view; expects a [ForexCubit] above it (see [ForexPage]).
class ForexView extends StatelessWidget {
  const ForexView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = ForexStrings.of(context);
    final colors = context.colors;
    return Scaffold(
      appBar: AppTopBar(title: s.title, showBack: true),
      body: BlocBuilder<ForexCubit, ForexState>(
        builder: (context, state) {
          final cubit = context.read<ForexCubit>();
          if (!state.hasRates) {
            return switch (state.rates) {
              Failed(:final failure) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => const LoadingView(),
            };
          }
          final options = [for (final r in state.rateList) r.currency];
          return RefreshIndicator(
            onRefresh: cubit.load,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              children: [
                ForexTrendPanel(
                  state: state,
                  onRangeChanged: cubit.selectRange,
                  onCurrencyChanged: cubit.selectTrendCurrency,
                  chartHeight: 110,
                ),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
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
                    onSwap: cubit.swapCurrencies,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  child: Text(
                    s.selectHomeCurrencies,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  child: ForexRatesTable(
                    rates: state.rateList,
                    favourites: state.favourites,
                    onToggleFavourite: (iso3) => _toggle(context, iso3),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Center(
                  child: Text(
                    s.source(context.regionConfig),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      color: colors.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _toggle(BuildContext context, String iso3) async {
    final ok = await context.read<ForexCubit>().toggleFavourite(iso3);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ForexStrings.of(context).maxFavourites)),
      );
    }
  }
}
