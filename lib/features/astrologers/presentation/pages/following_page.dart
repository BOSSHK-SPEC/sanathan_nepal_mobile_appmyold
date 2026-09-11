import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../cubit/astrologer_list_cubit.dart';
import '../l10n/astrologers_strings.dart';
import '../widgets/astrologer_card.dart';
import '../widgets/astrologer_list_skeleton.dart';

/// The astrologers a seeker follows.
///
/// Until now following was write-only — the star could be tapped but never
/// read back. This is the read side, and it is the same list widget as
/// discovery with a following-only filter rather than a parallel screen.
class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AstrologerListCubit>(
      param1: const AstrologerFilter(followingOnly: true),
    )..load(),
    child: const _FollowingView(),
  );
}

class _FollowingView extends StatelessWidget {
  const _FollowingView();

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.followingTitle, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<AstrologerListCubit, AstrologerListState>(
          builder: (context, state) {
            final cubit = context.read<AstrologerListCubit>();
            return switch (state.astrologers) {
              Idle() ||
              Loading(previous: null) => const AstrologerListSkeleton(),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.refresh,
              ),
              _ when state.isEmpty => EmptyViewWithBody(
                title: s.noFollowingTitle,
                body: s.noFollowingBody,
                icon: Icons.person_add_alt_outlined,
                actionLabel: s.browseAstrologers,
                onAction: () => context.push(AppRoutes.astrologers),
              ),
              _ => RefreshIndicator(
                onRefresh: cubit.refresh,
                color: colors.accent,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.xxxl,
                  ),
                  // The count header earns its place here: the reason to keep
                  // a following list is knowing who can talk right now.
                  itemCount: state.results.length + 1,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Text(
                          '${state.onlineCount} ${s.followingOnlineNote}',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: state.onlineCount > 0
                                ? colors.accent
                                : colors.textMuted,
                          ),
                        ),
                      );
                    }
                    final astrologer = state.results[i - 1];
                    return AstrologerCard(
                      astrologer: astrologer,
                      onTap: () => context.push(
                        AppRoutes.astrologerProfilePath(astrologer.id),
                      ),
                      onFollowToggle: () => cubit.toggleFollow(astrologer.id),
                      onConsult: (channel) => context.push(
                        AppRoutes.consultIntakePath(
                          astrologer.id,
                          channel: channel.name,
                        ),
                      ),
                    );
                  },
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}
