import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/consult_channel.dart';
import '../cubit/astrologer_profile_cubit.dart';
import '../l10n/astrologers_strings.dart';
import '../widgets/astrologer_header.dart';
import '../widgets/astrologer_presence.dart';
import '../widgets/report_astrologer_sheet.dart';
import '../widgets/review_tile.dart';

/// Public astrologer profile, addressed by id so it is shareable and
/// deep-linkable.
class AstrologerProfilePage extends StatelessWidget {
  const AstrologerProfilePage({required this.astrologerId, super.key});

  final String astrologerId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        GetIt.I<AstrologerProfileCubit>(param1: astrologerId)..load(),
    child: const _AstrologerProfileView(),
  );
}

class _AstrologerProfileView extends StatelessWidget {
  const _AstrologerProfileView();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = AstrologersStrings.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: BlocBuilder<AstrologerProfileCubit, AstrologerProfileState>(
        builder: (context, state) {
          final cubit = context.read<AstrologerProfileCubit>();

          return switch (state.astrologer) {
            Idle() ||
            Loading(previous: null) => const SafeArea(child: LoadingView()),
            Failed(:final failure, previous: null) => SafeArea(
              child: ErrorView(message: failure.message, onRetry: cubit.load),
            ),
            _ => _Loaded(
              astrologer: state.astrologer.dataOrNull!,
              state: state,
            ),
          };
        },
      ),
      bottomNavigationBar:
          BlocBuilder<AstrologerProfileCubit, AstrologerProfileState>(
            buildWhen: (p, n) => p.astrologer != n.astrologer,
            builder: (context, state) {
              final astrologer = state.astrologer.dataOrNull;
              if (astrologer == null) return const SizedBox.shrink();
              return _ConsultBar(astrologer: astrologer, strings: s);
            },
          ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.astrologer, required this.state});

  final Astrologer astrologer;
  final AstrologerProfileState state;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final cubit = context.read<AstrologerProfileCubit>();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          title: Text(localized(context, astrologer.name)),
          actions: [
            IconButton(
              tooltip: s.report,
              icon: const Icon(Icons.flag_outlined),
              onPressed: () async {
                final reported = await ReportAstrologerSheet.show(
                  context,
                  astrologerId: astrologer.id,
                );
                if (reported && context.mounted) {
                  AppSnack.success(context, s.reportThanks);
                }
              },
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: AstrologerHeader(
            astrologer: astrologer,
            onFollowToggle: cubit.toggleFollow,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pageGutter,
              vertical: AppSpacing.md,
            ),
            child: PillTabs(
              labels: [s.about, s.services, s.reviews, s.contact],
              selectedIndex: state.tabIndex,
              scrollable: true,
              onChanged: cubit.selectTab,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pageGutter,
            0,
            AppSpacing.pageGutter,
            AppSpacing.xxxl,
          ),
          sliver: switch (state.tab) {
            AstrologerProfileTab.about => _AboutTab(astrologer: astrologer),
            AstrologerProfileTab.services => _ServicesTab(
              astrologer: astrologer,
            ),
            AstrologerProfileTab.reviews => _ReviewsTab(state: state),
            AstrologerProfileTab.contact => _ContactTab(astrologer: astrologer),
          },
        ),
      ],
    );
  }
}

class _AboutTab extends StatelessWidget {
  const _AboutTab({required this.astrologer});

  final Astrologer astrologer;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return SliverList.list(
      children: [
        Text(
          localized(context, astrologer.about),
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(s.speciality, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final specialty in astrologer.specialties)
              StatusChip(
                label: s.specialty(specialty),
                tone: StatusTone.accent,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(s.language, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final code in astrologer.languageCodes)
              StatusChip(label: s.languageName(code)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          child: KeyValueList(
            divided: true,
            children: [
              KeyValueRow(
                label: s.recommended,
                value:
                    '${localizeCount(context, astrologer.recommendedPercent)}%',
              ),
              KeyValueRow(
                label: s.followers,
                value: localizeCount(context, astrologer.followers),
              ),
              KeyValueRow(
                label: s.consultations,
                value: localizeCount(context, astrologer.consultationCount),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ServicesTab extends StatelessWidget {
  const _ServicesTab({required this.astrologer});

  final Astrologer astrologer;

  IconData _icon(ConsultChannel c) => switch (c) {
    ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
    ConsultChannel.voice => Icons.call_outlined,
    ConsultChannel.video => Icons.videocam_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return SliverList.list(
      children: [
        for (final channel in astrologer.channels)
          AppCard(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.accent.withValues(alpha: 0.12),
                  ),
                  child: Icon(_icon(channel), size: 19, color: colors.accent),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    s.channelName(channel),
                    style: context.textTheme.titleSmall,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    MoneyText(
                      astrologer.rateFor(channel)!,
                      style: context.textTheme.headlineSmall,
                      color: colors.accent,
                    ),
                    Text(
                      s.perMinute,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab({required this.state});

  final AstrologerProfileState state;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final astrologer = state.astrologer.dataOrNull!;
    final reviews = state.reviewList;

    return SliverList.list(
      children: [
        AppCard(
          margin: const EdgeInsets.only(bottom: AppSpacing.lg),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    astrologer.rating.toStringAsFixed(1),
                    style: context.textTheme.displayMedium,
                  ),
                  RatingStars(rating: astrologer.rating, size: 15),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${s.basedOn} '
                    '${localizeCount(context, astrologer.reviewCount)}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: _RatingBreakdown(
                  breakdown: astrologer.ratingBreakdown,
                  total: astrologer.reviewCount,
                ),
              ),
            ],
          ),
        ),
        // Offered only to someone who has actually consulted this astrologer.
        // The server refuses a review without a completed session behind it,
        // so showing the button to everyone sent people into a form that
        // failed on submit with nothing they could do about it.
        if (state.canWriteReview) ...[
          PrimaryButton(
            label: s.writeReview,
            icon: Icon(
              Icons.rate_review_outlined,
              size: 17,
              color: context.colors.onPrimary,
            ),
            onPressed: () => context.push(
              AppRoutes.astrologerReviewPath(
                astrologer.id,
                consultationId: state.reviewConsultationId,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (state.reviews.isLoading && reviews.isEmpty)
          const AppSkeletonList.tiles(count: 3, padding: EdgeInsets.zero)
        else if (reviews.isEmpty)
          EmptyView(message: s.noReviewsYet, icon: Icons.reviews_outlined)
        else
          for (final review in reviews) ReviewTile(review: review),
      ],
    );
  }
}

class _RatingBreakdown extends StatelessWidget {
  const _RatingBreakdown({required this.breakdown, required this.total});

  final Map<int, int> breakdown;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final divisor = total == 0 ? 1 : total;

    return Column(
      children: [
        for (var star = 5; star >= 1; star--)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                  child: Text(
                    localizeCount(context, star),
                    style: context.textTheme.labelSmall,
                  ),
                ),
                Icon(Icons.star_rounded, size: 10, color: colors.warning),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: LinearProgressIndicator(
                      value: (breakdown[star] ?? 0) / divisor,
                      minHeight: 5,
                      backgroundColor: colors.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation(colors.warning),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ContactTab extends StatelessWidget {
  const _ContactTab({required this.astrologer});

  final Astrologer astrologer;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);

    return SliverList.list(
      children: [
        AppCard(
          child: KeyValueList(
            divided: true,
            children: [
              if (astrologer.location != null)
                KeyValueRow(
                  label: s.contact,
                  value: localized(context, astrologer.location!),
                  icon: Icons.place_outlined,
                ),
              KeyValueRow(
                label: s.language,
                value: astrologer.languageCodes.map(s.languageName).join(', '),
                icon: Icons.translate_rounded,
              ),
              KeyValueRow(
                label: s.channel,
                value: astrologer.channels.map(s.channelName).join(', '),
                icon: Icons.forum_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConsultBar extends StatelessWidget {
  const _ConsultBar({required this.astrologer, required this.strings});

  final Astrologer astrologer;
  final AstrologersStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    strings.from,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  Text(
                    '${RegionFormat.money(astrologer.lowestRate, config: context.regionConfig, languageCode: context.languageCode)}'
                    '${strings.perMinute}',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: colors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.lg),
              // Offline, the only thing on offer is a sitting from the hours
              // they keep. Online, talking now is the main act — but booking
              // is still offered beside it, because someone who arrived here
              // from "Book your appointment" must not hit a dead end just
              // because the astrologer happens to be free this minute.
              Expanded(
                child: astrologer.isOnline
                    ? Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              label: strings.consultNow,
                              height: 46,
                              onPressed: () => context.push(
                                AppRoutes.consultIntakePath(
                                  astrologer.id,
                                  channel:
                                      astrologer.channels.firstOrNull?.name,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: SecondaryButton(
                              label: strings.bookLater,
                              height: 46,
                              onPressed: () => context.push(
                                AppRoutes.appointmentBookPath(astrologer.id),
                              ),
                            ),
                          ),
                        ],
                      )
                    : PrimaryButton(
                        label: strings.bookLater,
                        height: 46,
                        onPressed: () => context.push(
                          AppRoutes.appointmentBookPath(astrologer.id),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
