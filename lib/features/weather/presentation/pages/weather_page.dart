import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/weather_cubit.dart';
import '../l10n/weather_strings.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/weather_details_card.dart';
import '../widgets/weather_format.dart';
import '../widgets/weather_header.dart';
import '../widgets/weather_stats_chips.dart';

/// Full weather screen.
///
/// Laid out like the app's other data screens — Forex, Panchanga, the date
/// converter: an [AppTopBar], one [ListView] at the standard page gutter, and
/// [SectionHeader]-titled cards. It used to build its own full-bleed gradient
/// hero with a bare back arrow and no title, which is the chrome this app
/// reserves for profile screens, and scrolled through a `CustomScrollView`
/// nothing else uses.
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<WeatherCubit>()..load(),
    child: const WeatherView(),
  );
}

/// Stateless view; expects a [WeatherCubit] above it (see [WeatherPage]).
class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = WeatherStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(
        title: s.title,
        showBack: true,
        actions: [
          BlocBuilder<WeatherCubit, WeatherState>(
            buildWhen: (p, n) => p.weather.isLoading != n.weather.isLoading,
            builder: (context, state) => IconButton(
              tooltip: s.useMyLocation,
              // Disabled mid-request so a second tap cannot queue another
              // location lookup on top of the one in flight.
              onPressed: state.weather.isLoading
                  ? null
                  : context.read<WeatherCubit>().load,
              icon: const Icon(Icons.my_location_outlined),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          final cubit = context.read<WeatherCubit>();
          final bundle = state.weather.dataOrNull;

          // Stale data stays on screen while refreshing; only a first load
          // with nothing to show gets the spinner.
          if (bundle == null) {
            return switch (state.weather) {
              Failed(:final failure) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => const LoadingView(),
            };
          }

          return RefreshIndicator(
            onRefresh: cubit.refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.md,
                AppSpacing.pageGutter,
                AppSpacing.xxl,
              ),
              children: [
                if (bundle.isFallback) ...[
                  _OfflineBanner(text: s.offlineData),
                  const SizedBox(height: AppSpacing.md),
                ],
                WeatherHeader(bundle: bundle, onLocationTap: cubit.load),
                const SizedBox(height: AppSpacing.md),
                WeatherStatsChips(current: bundle.current),
                SectionHeader(
                  title: s.today,
                  trailing: Text(
                    WeatherFormat.digits(
                      '${s.monthShort(bundle.current.time.month)}, '
                      '${bundle.current.time.day}',
                      devanagari: context.usesDevanagariDigits,
                    ),
                    style: context.textTheme.titleSmall,
                  ),
                ),
                HourlyForecastCard(
                  hours: bundle.upcomingHours(count: 24),
                  selectedIndex: state.selectedHourIndex,
                  onSelected: cubit.selectHour,
                ),
                SectionHeader(title: s.nextForecast),
                DailyForecastCard(days: bundle.daily),
                SectionHeader(title: s.details),
                WeatherDetailsCard(bundle: bundle),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Shown when the forecast on screen is the cached one because the network
/// (or the upstream) could not be reached.
class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_off_outlined, size: 16, color: colors.warning),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(text, style: context.textTheme.labelMedium)),
        ],
      ),
    );
  }
}
