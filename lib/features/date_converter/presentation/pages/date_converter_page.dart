import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../domain/entities/conversion_direction.dart';
import '../cubit/date_converter_cubit.dart';
import '../l10n/date_converter_strings.dart';
import '../widgets/conversion_input_card.dart';
import '../widgets/conversion_result_section.dart';
import '../widgets/converted_day_sections.dart';
import '../widgets/difference_card.dart';

/// "मिति परिवर्तन" screen (Figma 555:1891 light / 736:8319 dark).
///
/// Direction radios → wheel pickers → result cards + mini month grid →
/// difference card → events / suva sait / panchanga of the converted day →
/// ads slot.
class DateConverterPage extends StatelessWidget {
  const DateConverterPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<DateConverterCubit>(
    create: (_) => sl<DateConverterCubit>()..convert(),
    child: const _DateConverterView(),
  );
}

class _DateConverterView extends StatelessWidget {
  const _DateConverterView();

  @override
  Widget build(BuildContext context) {
    final strings = DateConverterStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(title: strings.title, showBack: true),
      body: BlocConsumer<DateConverterCubit, DateConverterState>(
        listenWhen: (p, c) => c.result.isFailed && !p.result.isFailed,
        listener: (context, state) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.result.errorMessage ?? strings.conversionFailed,
                ),
              ),
            ),
        builder: (context, state) {
          final cubit = context.read<DateConverterCubit>();
          final isTraditional = state.isTraditionalInput;
          final era = context.traditionalCalendar.eraLabel(
            languageCode: context.languageCode,
          );
          final result = state.result.dataOrNull;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppSpacing.xl,
                  children: [
                    AppRadioOption<ConversionDirection>(
                      value: ConversionDirection.traditionalToGregorian,
                      groupValue: state.direction,
                      label: strings.toGregorian(era),
                      onChanged: cubit.setDirection,
                      textStyle: context.textTheme.bodyMedium,
                    ),
                    AppRadioOption<ConversionDirection>(
                      value: ConversionDirection.gregorianToTraditional,
                      groupValue: state.direction,
                      label: strings.toTraditional(era),
                      onChanged: cubit.setDirection,
                      textStyle: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                ConversionInputCard(
                  key: ValueKey(state.direction),
                  isTraditional: isTraditional,
                  input: state.input,
                  daysInMonth: cubit.daysInMonth(state.input),
                  minYear: cubit.minYear,
                  maxYear: cubit.maxYear,
                  onYear: cubit.setYear,
                  onMonth: cubit.setMonth,
                  onDay: cubit.setDay,
                  onCancel: cubit.reset,
                  onConvert: cubit.convert,
                  busy: state.result.isLoading,
                ),
                const SizedBox(height: AppSpacing.xxl),
                if (result != null) ...[
                  ConversionResultSection(result: result),
                  const SizedBox(height: AppSpacing.lg),
                  DifferenceCard(result: result),
                  const SizedBox(height: AppSpacing.lg),
                  ConvertedDaySections(date: result.ad),
                  const SizedBox(height: AppSpacing.lg),
                  AdBanner(label: strings.ads, margin: EdgeInsets.zero),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
