import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../astrologers/presentation/widgets/talk_to_astrologer_section.dart';
import '../../../events/presentation/widgets/upcoming_events_section.dart';
import '../../../forex/presentation/widgets/forex_section.dart';
import '../../../horoscope/presentation/widgets/horoscope_section.dart';
import '../../../panchanga/presentation/cubit/panchanga_cubit.dart';
import '../../../panchanga/presentation/widgets/panchanga_section.dart';
import '../../../panchanga/presentation/widgets/suva_sait_section.dart';
import '../../../weather/presentation/widgets/weather_summary_card.dart';
import '../cubit/home_cubit.dart';
import '../l10n/home_strings.dart';
import '../widgets/home_calendar_header.dart';

/// Home tab (Figma 364:609 light / 645:955 dark).
///
/// A vertical composition of self-contained feature sections; each section
/// owns its own cubit so Home stays a thin orchestrator (SRP/OCP).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<HomeCubit>(
    create: (_) => sl<HomeCubit>()..load(),
    child: const HomeView(),
  );
}

/// Testable body of [HomePage] (expects [HomeCubit] above).
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final PanchangaCubit _panchangaCubit = sl<PanchangaCubit>()..load();

  @override
  void dispose() {
    _panchangaCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = HomeStrings.of(context);
    final colors = context.colors;
    return Scaffold(
      appBar: AppTopBar(title: s.title),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.xxl,
            ),
            children: [
              HomeCalendarHeader(
                now: state.now,
                metalRates: state.metalRates.dataOrNull,
              ),
              const SizedBox(height: AppSpacing.lg),
              WeatherSummaryCard(onTap: () => context.push(AppRoutes.weather)),
              _rule(colors),
              const TalkToAstrologerSection(),
              _rule(colors),
              HoroscopeSection(onSeeAll: () => context.go(AppRoutes.horoscope)),
              _rule(colors),
              UpcomingEventsSection(
                onSeeAll: () => context.push(AppRoutes.events),
              ),
              _rule(colors),
              SuvaSaitSection(
                cubit: _panchangaCubit,
                maxItems: 3,
                onMore: () => context.push(AppRoutes.panchanga),
              ),
              _rule(colors),
              ForexSection(onMoreTap: () => context.push(AppRoutes.forex)),
              _rule(colors),
              PanchangaSection(
                cubit: _panchangaCubit,
                onSeeAll: () => context.push(AppRoutes.panchanga),
              ),
              const SizedBox(height: AppSpacing.xl),
              AdBanner(label: context.l10n.homeBelowEventAds, height: 70),
            ],
          );
        },
      ),
    );
  }

  Widget _rule(AppColors colors) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.pageGutter,
      vertical: AppSpacing.md,
    ),
    child: Divider(height: 1, color: colors.divider),
  );
}
