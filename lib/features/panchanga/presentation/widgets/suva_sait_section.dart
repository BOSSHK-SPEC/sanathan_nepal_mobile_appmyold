import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/suva_sait.dart';
import '../cubit/panchanga_cubit.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';
import 'suva_sait_panel.dart';

/// "शुभ साइत" block (Home): bullet list of auspicious-timing categories with
/// their upcoming dates, the "आज कुनै शुभ साइत … फेला परेन" line and the
/// "थप शुभ साइत तथा मुहूर्तहरू हेर्नुहोस्" link. With [full] it renders the
/// Panchanga-page [SuvaSaitPanel] (tabs + monthly / yearly tables) instead.
///
/// Provides its own [PanchangaCubit] unless [cubit] is passed; the dates
/// shown follow the cubit's selected date.
class SuvaSaitSection extends StatelessWidget {
  const SuvaSaitSection({
    super.key,
    this.cubit,
    this.showHeader = true,
    this.showMoreLink = true,
    this.maxItems,
    this.maxDatesPerItem = 3,
    this.onMore,
    this.padding = AppSpacing.page,
    this.full = false,
  });

  final PanchangaCubit? cubit;
  final bool showHeader;
  final bool showMoreLink;

  /// Render the full monthly / yearly panel instead of the compact list.
  final bool full;

  /// Limit the number of categories (Home shows a few; null = all).
  final int? maxItems;
  final int maxDatesPerItem;

  /// Defaults to `context.push(AppRoutes.panchanga)`.
  final VoidCallback? onMore;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final body = full
        ? Padding(padding: padding, child: const SuvaSaitPanel())
        : _Body(
            showHeader: showHeader,
            showMoreLink: showMoreLink,
            maxItems: maxItems,
            maxDatesPerItem: maxDatesPerItem,
            onMore: onMore,
            padding: padding,
          );
    if (cubit != null) return BlocProvider.value(value: cubit!, child: body);
    return BlocProvider(
      create: (_) => sl<PanchangaCubit>()..load(),
      child: body,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.showHeader,
    required this.showMoreLink,
    required this.maxItems,
    required this.maxDatesPerItem,
    required this.onMore,
    required this.padding,
  });
  final bool showHeader;
  final bool showMoreLink;
  final int? maxItems;
  final int maxDatesPerItem;
  final VoidCallback? onMore;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final devanagari = context.usesDevanagariDigits;
    final config = context.regionConfig;
    final s = PanchangaStrings.of(context);
    return BlocBuilder<PanchangaCubit, PanchangaState>(
      builder: (context, state) {
        final all = state.saits.dataOrNull ?? const <SuvaSait>[];
        final items = maxItems == null ? all : all.take(maxItems!).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader)
              SectionHeader(
                title: s.saitTitle(config),
                padding: EdgeInsets.symmetric(
                  horizontal: padding.left,
                  vertical: AppSpacing.sm,
                ),
              ),
            Padding(
              padding: padding,
              child: AppCard(
                gradient: colors.cardGradient,
                elevated: false,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: state.saits.isLoading && all.isEmpty
                    ? const LoadingView(height: 80)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final sait in items)
                            _SaitItem(
                              sait: sait,
                              from: state.date,
                              maxDates: maxDatesPerItem,
                              devanagari: devanagari,
                            ),
                          // Two different empty states. Nothing published at
                          // all is not the same as "none falls today": saits
                          // are editorial, so an empty list means no panel has
                          // published one, and saying "none today" there reads
                          // as an answer when it is an absence of data.
                          if (all.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.xs,
                              ),
                              child: Text(
                                s.noSaitsPublishedFor(config),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            )
                          else if (state.saitsToday.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: AppSpacing.xs,
                              ),
                              child: Text(
                                s.noSaitTodayFor(config),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            ),
                          // No link when there is nothing behind it.
                          if (showMoreLink && all.isNotEmpty)
                            InkWell(
                              onTap:
                                  onMore ??
                                  () => context.push(AppRoutes.panchanga),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacing.sm,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        s.moreSaitsFor(config),
                                        style: context.textTheme.labelLarge
                                            ?.copyWith(color: colors.accent),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 18,
                                      color: colors.accent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SaitItem extends StatelessWidget {
  const _SaitItem({
    required this.sait,
    required this.from,
    required this.maxDates,
    required this.devanagari,
  });
  final SuvaSait sait;

  /// Only dates on/after this day are listed (the cubit's selected date).
  final DateTime from;
  final int maxDates;

  /// Devanagari UI (Nepali / Hindi) – picks the Devanagari title.
  final bool devanagari;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final config = context.regionConfig;
    final lang = context.languageCode;
    final dates = sait.upcoming(from, max: maxDates);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: AppSpacing.sm),
            child: Icon(Icons.circle, size: 7, color: colors.accent),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sait.title(nepali: devanagari),
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    for (final d in dates)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: colors.chipBackground,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          PanchangaFormat.saitDate(
                            d,
                            config: config,
                            languageCode: lang,
                          ),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
