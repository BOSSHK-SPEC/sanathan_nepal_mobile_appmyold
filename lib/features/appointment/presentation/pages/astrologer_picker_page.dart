import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../cubit/appointment_list_cubit.dart';
import '../widgets/appointment_format.dart';
import '../l10n/appointment_strings.dart';

/// Who you can book with.
///
/// The step the old flow skipped: it featured whichever astrologer happened to
/// be first in the list and gave no way to reach any of the others.
class AstrologerPickerPage extends StatelessWidget {
  const AstrologerPickerPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AppointmentListCubit>()..load(),
    child: const AstrologerPickerView(),
  );
}

/// Widget-testable body of [AstrologerPickerPage].
class AstrologerPickerView extends StatelessWidget {
  const AstrologerPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppointmentStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.chooseAstrologer, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<AppointmentListCubit, AppointmentListState>(
          builder: (context, state) {
            final cubit = context.read<AppointmentListCubit>();
            final astrologers = state.astrologers.dataOrNull ?? const [];

            return switch (state.astrologers) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 4),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ when astrologers.isEmpty => EmptyView(
                message: s.noAstrologers,
                icon: Icons.person_search_outlined,
              ),
              _ => ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.md,
                  AppSpacing.pageGutter,
                  AppSpacing.xxxl,
                ),
                itemCount: astrologers.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Text(
                        s.chooseAstrologerBody,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    );
                  }
                  return _AstrologerCard(astrologer: astrologers[i - 1]);
                },
              ),
            };
          },
        ),
      ),
    );
  }
}

class _AstrologerCard extends StatelessWidget {
  const _AstrologerCard({required this.astrologer});

  final BookableAstrologer astrologer;

  @override
  Widget build(BuildContext context) {
    final s = AppointmentStrings.of(context);
    final colors = context.colors;
    final language = context.languageCode;
    final fmt = AppointmentFormat.of(context);
    final cheapest = astrologer.cheapestSitting;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        onTap: () =>
            context.push(AppRoutes.astrologerProfilePath(astrologer.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppAvatar(
                  source: astrologer.avatarAsset,
                  name: astrologer.name.forLanguage(language),
                  size: 44,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              astrologer.name.forLanguage(language),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleSmall,
                            ),
                          ),
                          if (astrologer.isVerified) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.verified, size: 14, color: colors.accent),
                          ],
                        ],
                      ),
                      Text(
                        astrologer.title.forLanguage(language),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingStars(rating: astrologer.rating, size: 12),
                    Text(
                      '${astrologer.reviewCount} ${s.reviews}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                // Whether they are free right now, and what a sitting costs —
                // the two things that decide who you book. An offline
                // astrologer is still bookable: a calendar of their own hours
                // is exactly what makes "book later" mean something.
                Icon(
                  astrologer.isOnline ? Icons.circle : Icons.schedule_outlined,
                  size: 10,
                  color: astrologer.isOnline ? Colors.green : colors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  astrologer.isOnline ? s.onlineNow : s.bookLater,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const Spacer(),
                if (cheapest != null)
                  Text(
                    fmt.money(cheapest.price),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Icon(Icons.chevron_right_rounded, size: 16, color: colors.accent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
