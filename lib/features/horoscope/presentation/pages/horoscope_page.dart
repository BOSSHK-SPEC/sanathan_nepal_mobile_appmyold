import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/horoscope_prediction.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../cubit/horoscope_cubit.dart';
import '../l10n/horoscope_strings.dart';
import '../widgets/horoscope_format.dart';
import '../widgets/horoscope_sign_card.dart';
import '../widgets/stay_informed_card.dart';
import '../widgets/zodiac_sign_dropdown.dart';

/// Horoscope tab – "Horoscope Listing Page" (Figma `507:718` light /
/// `687:2559` dark): period tabs, sign dropdown, today's date, all twelve
/// sign cards (prediction, player, lucky details + expandable "More Details"
/// area), ad slots after the 4th / 8th / 12th card, the closing blessing and
/// the "stay informed" card.
class HoroscopePage extends StatelessWidget {
  const HoroscopePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<HoroscopeCubit>()..load(),
    child: const HoroscopeView(),
  );
}

/// Cubit-agnostic body of [HoroscopePage] (expects a [HoroscopeCubit] above).
class HoroscopeView extends StatefulWidget {
  const HoroscopeView({super.key});

  @override
  State<HoroscopeView> createState() => _HoroscopeViewState();
}

class _HoroscopeViewState extends State<HoroscopeView> {
  final Map<ZodiacSign, GlobalKey> _keys = {
    for (final s in ZodiacSign.values) s: GlobalKey(),
  };

  void _jumpTo(ZodiacSign sign) {
    context.read<HoroscopeCubit>().selectSign(sign);
    final ctx = _keys[sign]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 350),
        alignment: 0.05,
      );
    }
  }

  Future<void> _share(HoroscopePrediction p) async {
    final s = HoroscopeStrings.of(context);
    final lang = context.languageCode;
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(
      ClipboardData(
        text: s.shareText(
          p.sign.displayNameFor(lang),
          p.period.labelFor(lang),
          p.textFor(lang),
        ),
      ),
    );
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(s.copied)));
  }

  @override
  Widget build(BuildContext context) {
    final s = HoroscopeStrings.of(context);
    final lang = context.languageCode;
    return Scaffold(
      appBar: AppTopBar(
        title: s.periodTitle(
          context.select((HoroscopeCubit c) => c.state.period),
        ),
      ),
      body: BlocBuilder<HoroscopeCubit, HoroscopeState>(
        builder: (context, state) {
          final cubit = context.read<HoroscopeCubit>();
          final predictions =
              state.predictions.dataOrNull ?? const <HoroscopePrediction>[];
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.sm,
                  ),
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
                            onChanged: _jumpTo,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _dateLine(context),
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.predictions case Failed(:final failure))
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorView(
                    message: failure.message,
                    onRetry: cubit.load,
                  ),
                )
              else if (predictions.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: LoadingView(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pageGutter,
                  ),
                  sliver: SliverList.separated(
                    itemCount: predictions.length,
                    // Ad slots after the 4th and 8th card (Figma "1" / "3").
                    separatorBuilder: (_, i) => i == 3 || i == 7
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                            child: AdBanner(
                              label: s.horoscopeAds,
                              margin: EdgeInsets.zero,
                            ),
                          )
                        : const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, i) {
                      final p = predictions[i];
                      return KeyedSubtree(
                        key: _keys[p.sign],
                        child: HoroscopeSignCard(
                          prediction: p,
                          highlighted: p.sign == state.selectedSign,
                          isPlaying: state.isPlayingClip(p.sign),
                          position: state.positionOf(p.sign),
                          onTogglePlayback: () => cubit.togglePlayback(p.sign),
                          onSeek: cubit.seek,
                          expanded: state.isExpanded(p.sign),
                          onToggleDetails: () => cubit.toggleDetails(p.sign),
                          liked: state.isLiked(p.sign),
                          onLike: () => cubit.toggleLike(p.sign),
                          onShare: () => _share(p),
                          isLuckyPlaying: state.isPlayingClip(
                            p.sign,
                            lucky: true,
                          ),
                          luckyPosition: state.positionOf(p.sign, lucky: true),
                          onToggleLuckyPlayback: () =>
                              cubit.togglePlayback(p.sign, lucky: true),
                          onShop: () => context.push(AppRoutes.marketplace),
                        ),
                      );
                    },
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.lg,
                  AppSpacing.pageGutter,
                  AppSpacing.xxl,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      if (predictions.isNotEmpty) ...[
                        // Figma "2": ad after the last card + closing quote.
                        AdBanner(
                          label: s.horoscopeAds,
                          margin: EdgeInsets.zero,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                          child: Text(
                            s.closingQuote,
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      StayInformedCard(
                        onTap: () =>
                            context.push(AppRoutes.notificationSettings),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Traditional date of the active region + weekday, e.g.
  /// Nepal: "फागुन ११, २०७९, बिहीबार" / "Falgun 11, 2079 · Thursday, 23 Feb 2023";
  /// India: "श्रावण २७, १९४८, मंगलवार" / "Shravana 27, 1948 · Tuesday, 18 Aug 2026".
  String _dateLine(BuildContext context) {
    final now = DateTime.now();
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final calendar = context.traditionalCalendar;
    final t = calendar.fromGregorian(now);
    final month = calendar.monthName(t.month, languageCode: lang);
    final day = HoroscopeFormat.localiseDigits('${t.day}', nepali: devanagari);
    final year = HoroscopeFormat.localiseDigits(
      '${t.year}',
      nepali: devanagari,
    );
    final traditional = '$month $day, $year';
    final weekday = HoroscopeFormat.weekday(now, languageCode: lang);
    if (devanagari) return '$traditional, $weekday';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '$traditional · $weekday, ${now.day} '
        '${months[now.month - 1]} ${now.year}';
  }
}
