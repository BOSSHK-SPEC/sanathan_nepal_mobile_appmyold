import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer.dart';
import '../cubit/astrologer_list_cubit.dart';
import '../l10n/astrologers_strings.dart';
import 'astrologer_presence.dart';

/// Home-page rail of online astrologers.
///
/// Discovery is the entry point to the only flow that earns money, so it
/// gets a place on Home rather than living behind the quick-menu sheet.
class TalkToAstrologerSection extends StatelessWidget {
  const TalkToAstrologerSection({super.key, this.maxItems = 8});

  final int maxItems;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AstrologerListCubit>(param1: null)..load(),
    child: TalkToAstrologerRail(maxItems: maxItems),
  );
}

/// The rail itself, given an [AstrologerListCubit] above it.
///
/// Split from the provider so the "loading versus genuinely empty" rendering
/// can be tested without standing up dependency injection.
@visibleForTesting
class TalkToAstrologerRail extends StatelessWidget {
  const TalkToAstrologerRail({required this.maxItems, super.key});

  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);

    return BlocBuilder<AstrologerListCubit, AstrologerListState>(
      builder: (context, state) {
        // Nothing to advertise if the catalogue failed — stay silent rather
        // than showing an error block on Home.
        if (state.astrologers.isFailed && state.results.isEmpty) {
          return const SizedBox.shrink();
        }

        // Loaded, but this region has nobody to show. The rail is an
        // advertisement, so it disappears rather than sitting there empty —
        // and, critically, rather than shimmering forever: a skeleton that
        // never resolves reads as a broken app, not as "no astrologers yet".
        final isLoading =
            state.astrologers.isLoading || state.astrologers.isIdle;
        if (!isLoading && state.results.isEmpty) {
          return const SizedBox.shrink();
        }

        final items = state.results.take(maxItems).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: s.title,
              trailing: TextButton(
                onPressed: () => context.push(AppRoutes.astrologers),
                child: Text(
                  context.l10n.seeAll,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colors.accent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 172,
              child: isLoading && state.results.isEmpty
                  ? const _RailSkeleton()
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.pageGutter,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.md),
                      itemBuilder: (context, i) => _AstrologerMiniCard(
                        astrologer: items[i],
                        onTap: () => context.push(
                          AppRoutes.astrologerProfilePath(items[i].id),
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _AstrologerMiniCard extends StatelessWidget {
  const _AstrologerMiniCard({required this.astrologer, required this.onTap});

  final Astrologer astrologer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = AstrologersStrings.of(context);

    return SizedBox(
      width: 132,
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAvatar(
              source: astrologer.avatarAsset,
              name: astrologer.name.en,
              size: 52,
              online: astrologer.isOnline,
              verified: astrologer.isVerified,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              localized(context, astrologer.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall,
            ),
            Text(
              astrologer.specialties.take(1).map(s.specialty).join(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            RatingSummary(rating: astrologer.rating, size: 12),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${RegionFormat.money(astrologer.lowestRate, config: context.regionConfig, languageCode: context.languageCode)}'
              '${s.perMinute}',
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RailSkeleton extends StatelessWidget {
  const _RailSkeleton();

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
      itemBuilder: (_, _) => const SizedBox(
        width: 132,
        child: Column(
          children: [
            AppSkeletonCircle(size: 52),
            SizedBox(height: AppSpacing.md),
            AppSkeleton.text(width: 90),
            SizedBox(height: AppSpacing.sm),
            AppSkeleton.text(width: 60),
            SizedBox(height: AppSpacing.sm),
            AppSkeleton.text(width: 70),
          ],
        ),
      ),
    ),
  );
}
