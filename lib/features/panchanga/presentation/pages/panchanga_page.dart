import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/panchanga_cubit.dart';
import '../l10n/panchanga_strings.dart';
import '../widgets/panchanga_day_header.dart';
import '../widgets/panchanga_table.dart';
import '../widgets/suva_sait_section.dart';

/// "Panchanga & Suva Sait" page (Figma `580:2131` light / `735:5025` dark),
/// top to bottom: day header with month grid → "शुभ साइत तथा मुहूर्तहरू"
/// panel (tabs, today's saits, monthly / yearly tables) → ad → "पञ्चाङ्ग"
/// title + full expandable panchanga table.
class PanchangaPage extends StatelessWidget {
  const PanchangaPage({super.key, this.initialDate});

  /// Day to open on (defaults to today).
  final DateTime? initialDate;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        sl<PanchangaCubit>()
          ..selectDate(initialDate ?? DateTime.now(), force: true),
    child: const PanchangaView(),
  );
}

/// Cubit-agnostic body of [PanchangaPage] (expects a [PanchangaCubit] above).
class PanchangaView extends StatelessWidget {
  const PanchangaView({super.key, this.showCalendar = true});

  /// Show the compact month grid in the header (needs a `CalendarCubit`
  /// registration in GetIt).
  final bool showCalendar;

  @override
  Widget build(BuildContext context) {
    final s = PanchangaStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(
        title: s.pageTitleFor(context.regionConfig),
        showBack: true,
      ),
      body: BlocBuilder<PanchangaCubit, PanchangaState>(
        builder: (context, state) {
          final cubit = context.read<PanchangaCubit>();
          final p = state.panchanga.dataOrNull;
          return RefreshIndicator(
            onRefresh: cubit.load,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.sm,
                AppSpacing.pageGutter,
                AppSpacing.xxl,
              ),
              children: [
                PanchangaDayHeader(
                  date: state.date,
                  panchanga: p,
                  showCalendar: showCalendar,
                ),
                const SizedBox(height: AppSpacing.md),
                SuvaSaitSection(
                  cubit: cubit,
                  full: true,
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: AppSpacing.md),
                AdBanner(label: s.panchangaAds, margin: EdgeInsets.zero),
                const SizedBox(height: AppSpacing.md),
                Text(
                  s.panchanga,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (state.panchanga case Failed(:final failure))
                  ErrorView(message: failure.message, onRetry: cubit.load)
                else if (p == null)
                  const LoadingView(height: 240)
                else
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: state.isLoading ? 0.6 : 1,
                    child: PanchangaTable(key: ValueKey(p.date), panchanga: p),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
