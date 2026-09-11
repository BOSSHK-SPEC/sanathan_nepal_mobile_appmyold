import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/weather_bundle.dart';
import '../cubit/weather_cubit.dart';
import '../l10n/weather_strings.dart';
import 'temperature_curve.dart';
import 'weather_format.dart';
import 'weather_icon.dart';

/// Compact weather card for the Home page (Figma "WEATHER" 340×115):
/// location, current temperature + condition, H/L, and a 5-hour strip with
/// icon, temperature, precipitation and a temperature curve.
///
/// Usage: `const WeatherSummaryCard()` – it creates and loads its own
/// [WeatherCubit] from GetIt. Pass [cubit] to reuse an existing one (e.g. in
/// tests). Tapping navigates to [AppRoutes.weather] unless [onTap] is given.
class WeatherSummaryCard extends StatelessWidget {
  const WeatherSummaryCard({
    super.key,
    this.cubit,
    this.onTap,
    this.hourCount = 5,
    this.margin = AppSpacing.page,
  });

  final WeatherCubit? cubit;
  final VoidCallback? onTap;

  /// Number of hourly columns shown on the right (design: 5).
  final int hourCount;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final body = BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final bundle = state.weather.dataOrNull;
        if (bundle == null) {
          return SizedBox(
            height: 115,
            child: switch (state.weather) {
              Failed(:final failure) => ErrorView(
                message: failure.message,
                onRetry: context.read<WeatherCubit>().load,
              ),
              _ => const LoadingView(),
            },
          );
        }
        return _SummaryBody(bundle: bundle, hourCount: hourCount);
      },
    );
    final card = Padding(
      padding: margin,
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        onTap: onTap ?? () => context.push(AppRoutes.weather),
        child: body,
      ),
    );
    if (cubit != null) {
      return BlocProvider.value(value: cubit!, child: card);
    }
    return BlocProvider(create: (_) => sl<WeatherCubit>()..load(), child: card);
  }
}

class _SummaryBody extends StatelessWidget {
  const _SummaryBody({required this.bundle, required this.hourCount});
  final WeatherBundle bundle;
  final int hourCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dv = context.usesDevanagariDigits;
    final s = WeatherStrings.of(context);
    final current = bundle.current;
    final today = bundle.today;
    final hours = bundle.upcomingHours(count: hourCount);
    final hl = today == null
        ? ''
        : ' ${s.high}:${WeatherFormat.degrees(today.maxTemperature, devanagari: dv)}'
              ' ${s.low}:${WeatherFormat.degrees(today.minTemperature, devanagari: dv)}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column
        SizedBox(
          width: 96,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bundle.location.displayName(languageCode: context.languageCode),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Flexible(
                    child: _Fit(
                      Text(
                        WeatherFormat.degrees(
                          current.temperature,
                          devanagari: dv,
                        ),
                        style: context.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(width: 1, height: 20, color: colors.divider),
                  const SizedBox(width: AppSpacing.xs),
                  WeatherIcon(
                    current.condition,
                    isDay: current.isDay,
                    size: 26,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${current.condition.label(languageCode: context.languageCode)}$hl',
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Right hourly panel
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.xs,
              AppSpacing.sm,
              AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    for (final h in hours)
                      Expanded(
                        child: Column(
                          children: [
                            _Fit(
                              Text(
                                WeatherFormat.clock(h.time, devanagari: dv),
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.textPrimary,
                                ),
                              ),
                            ),
                            WeatherIcon(h.condition, isDay: h.isDay, size: 24),
                            _Fit(
                              Text(
                                WeatherFormat.celsius(
                                  h.temperature,
                                  devanagari: dv,
                                ),
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                TemperatureCurve(
                  values: [for (final h in hours) h.temperature],
                  color: colors.accent,
                ),
                Row(
                  children: [
                    for (final h in hours)
                      Expanded(
                        child: _Fit(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const WeatherGlyph('droplet', size: 8),
                              const SizedBox(width: 2),
                              Text(
                                WeatherFormat.percent(
                                  h.precipitationProbability,
                                  devanagari: dv,
                                ),
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontSize: 9,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  width: 56,
                  height: 2,
                  decoration: BoxDecoration(
                    color: colors.textMuted,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Scales its child down when the column is narrower than the text.
class _Fit extends StatelessWidget {
  const _Fit(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) =>
      FittedBox(fit: BoxFit.scaleDown, child: child);
}
