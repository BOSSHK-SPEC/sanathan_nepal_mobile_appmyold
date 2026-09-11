import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/console_pricing.dart';
import '../../../astrologers/presentation/l10n/astrologers_strings.dart';
import '../cubit/pricing_cubit.dart';
import '../l10n/console_strings.dart';

/// Per-channel rates, with the net-after-commission shown live.
///
/// An astrologer setting a rate is really deciding what they take home, so
/// the net is next to every input rather than buried in a help page.
class ConsolePricingPage extends StatelessWidget {
  const ConsolePricingPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PricingCubit>()..load(),
    child: const _PricingView(),
  );
}

class _PricingView extends StatelessWidget {
  const _PricingView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final a = AstrologersStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<PricingCubit, PricingState>(
      builder: (context, state) {
        final cubit = context.read<PricingCubit>();
        final pricing = state.working;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.pricing, showBack: true),
          body: SafeArea(
            child: state.pricing.isLoading && state.pricing.dataOrNull == null
                ? const LoadingView()
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.pageGutter),
                    children: [
                      Text(
                        s.ratesNote,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      for (final channel in ConsultChannel.values) ...[
                        _RateField(
                          channel: channel,
                          label: a.channelName(channel),
                          rate: pricing.rateFor(channel),
                          netPerMinute: pricing.netPerMinute(channel),
                          onChanged: (v) => cubit.setRate(channel, v),
                          strings: s,
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        s.freeFirstMinutes,
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        s.freeMinutesNote,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: [
                          for (final minutes in [0, 1, 2, 3, 5])
                            ChoiceChip(
                              label: Text(
                                minutes == 0
                                    ? s.notOffered
                                    : s.minutesLabel(_digits(context, minutes)),
                              ),
                              selected: pricing.freeFirstMinutes == minutes,
                              onSelected: (_) => cubit.setFreeMinutes(minutes),
                            ),
                        ],
                      ),
                      if (state.saveError != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          state.saveError!,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: colors.error,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: colors.divider)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: PrimaryButton(
                  label: s.savePricing,
                  height: 46,
                  isLoading: state.saving.isLoading,
                  onPressed: state.canSave && state.hasChanges
                      ? () async {
                          final ok = await cubit.save();
                          if (ok && context.mounted) {
                            AppSnack.success(context, s.pricingSaved);
                          }
                        }
                      : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RateField extends StatelessWidget {
  const _RateField({
    required this.channel,
    required this.label,
    required this.rate,
    required this.netPerMinute,
    required this.onChanged,
    required this.strings,
  });

  final ConsultChannel channel;
  final String label;
  final double? rate;
  final double netPerMinute;
  final ValueChanged<double?> onChanged;
  final ConsoleStrings strings;

  /// The length of a slot a seeker can book in advance. It has to match the
  /// server's `SLOT_MINUTES`, which is what the booking is actually priced by.
  static const int bookedSittingMinutes = 30;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tooHigh = rate != null && rate! > ConsolePricing.maxRatePerMinute;

    return AppCard(
      elevated: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            // The saved rate goes in the field, not the hint. As a hint it
            // vanished the moment anyone typed, so an astrologer charging ₹100
            // opened the screen to what looked like an empty form.
            initialValue: rate == null || rate! <= 0
                ? ''
                : rate!.toStringAsFixed(0),
            label: label,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            // The hint is now what it should always have been: guidance for an
            // empty field, not the value itself.
            hint: strings.notOffered,
            onChanged: (v) => onChanged(double.tryParse(v)),
            prefix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                context.regionConfig.symbolFor(context.languageCode),
                style: context.textTheme.titleMedium,
              ),
            ),
          ),
          if (tooHigh) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              strings.rateTooHigh(
                RegionFormat.money(
                  ConsolePricing.maxRatePerMinute,
                  config: context.regionConfig,
                  languageCode: context.languageCode,
                ),
              ),
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.error,
              ),
            ),
          ],
          if (rate != null && rate! > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 13,
                  color: colors.success,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${strings.youKeep} ',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                MoneyText(
                  netPerMinute,
                  decimals: 1,
                  style: context.textTheme.labelMedium,
                  color: colors.success,
                ),
                Text(
                  strings.perMinute,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            // What this rate becomes when somebody books ahead. The per-minute
            // figure alone hid the size of the number a seeker is shown.
            Text(
              strings.bookedSittingCosts(
                RegionFormat.money(
                  rate! * bookedSittingMinutes,
                  config: context.regionConfig,
                  languageCode: context.languageCode,
                ),
                context.usesDevanagariDigits
                    ? '$bookedSittingMinutes'.toDevanagariDigits()
                    : '$bookedSittingMinutes',
              ),
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
