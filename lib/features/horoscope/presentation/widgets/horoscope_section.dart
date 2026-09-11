import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/horoscope_period.dart';
import '../cubit/horoscope_cubit.dart';
import '../l10n/horoscope_strings.dart';
import 'horoscope_media_card.dart';
import 'stay_informed_card.dart';
import 'zodiac_sign_dropdown.dart';
import 'zodiac_sign_header.dart';

/// Compact horoscope block for the Home page (Figma `364:609`):
/// section header → period tabs → selected sign header → prediction text →
/// media card → "stay informed" card.
///
/// Provides its own [HoroscopeCubit] from GetIt unless [cubit] is passed.
class HoroscopeSection extends StatelessWidget {
  const HoroscopeSection({
    super.key,
    this.cubit,
    this.showHeader = true,
    this.showStayInformed = true,
    this.onSeeAll,
    this.onStayInformedTap,
    this.padding = AppSpacing.page,
  });

  /// Optional externally-owned cubit (e.g. shared with the tab page).
  final HoroscopeCubit? cubit;
  final bool showHeader;
  final bool showStayInformed;

  /// Defaults to `context.go(AppRoutes.horoscope)`.
  final VoidCallback? onSeeAll;
  final VoidCallback? onStayInformedTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final body = _HoroscopeSectionBody(
      showHeader: showHeader,
      showStayInformed: showStayInformed,
      onSeeAll: onSeeAll,
      onStayInformedTap: onStayInformedTap,
      padding: padding,
    );
    if (cubit != null) return BlocProvider.value(value: cubit!, child: body);
    return BlocProvider(
      create: (_) => sl<HoroscopeCubit>()..load(),
      child: body,
    );
  }
}

class _HoroscopeSectionBody extends StatelessWidget {
  const _HoroscopeSectionBody({
    required this.showHeader,
    required this.showStayInformed,
    required this.onSeeAll,
    required this.onStayInformedTap,
    required this.padding,
  });

  final bool showHeader;
  final bool showStayInformed;
  final VoidCallback? onSeeAll;
  final VoidCallback? onStayInformedTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final lang = context.languageCode;
    final s = HoroscopeStrings.of(context);
    final colors = context.colors;
    return BlocBuilder<HoroscopeCubit, HoroscopeState>(
      builder: (context, state) {
        final cubit = context.read<HoroscopeCubit>();
        final selected = state.selected;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader)
              SectionHeader(
                title: s.title,
                padding: EdgeInsets.symmetric(
                  horizontal: padding.left,
                  vertical: AppSpacing.sm,
                ),
                trailing: TextButton(
                  onPressed: onSeeAll ?? () => context.go(AppRoutes.horoscope),
                  child: Text(s.seeAll),
                ),
              ),
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: PillTabs(
                          scrollable: true,
                          labels: [
                            for (final p in HoroscopePeriod.values)
                              p.labelFor(lang),
                          ],
                          selectedIndex: state.period.index,
                          onChanged: (i) =>
                              cubit.selectPeriod(HoroscopePeriod.values[i]),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      ZodiacSignDropdown(
                        selected: state.selectedSign,
                        onChanged: cubit.selectSign,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (state.predictions case Failed(:final failure))
                    ErrorView(message: failure.message, onRetry: cubit.load)
                  else if (selected == null)
                    const LoadingView(height: 160)
                  else ...[
                    ZodiacSignHeader(
                      sign: selected.sign,
                      isPlaying: state.isPlayingClip(selected.sign),
                      onAudioTap: () => cubit.togglePlayback(selected.sign),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      selected.textFor(lang),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    HoroscopeMediaCard(
                      media: selected.media,
                      position: state.positionOf(selected.sign),
                      isPlaying: state.isPlayingClip(selected.sign),
                      onToggle: () => cubit.togglePlayback(selected.sign),
                      onSeek: cubit.seek,
                    ),
                  ],
                  if (showStayInformed) ...[
                    const SizedBox(height: AppSpacing.md),
                    StayInformedCard(
                      onTap:
                          onStayInformedTap ??
                          () => context.push(AppRoutes.notificationSettings),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
