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
import '../../domain/entities/consult_channel.dart';
import '../cubit/astrologer_list_cubit.dart';
import '../l10n/astrologers_strings.dart';
import '../widgets/astrologer_card.dart';
import '../widgets/astrologer_filter_sheet.dart';
import '../widgets/astrologer_list_skeleton.dart';

/// Astrologer discovery — the entry point to the whole consultation flow.
class AstrologerListPage extends StatelessWidget {
  const AstrologerListPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AstrologerListCubit>(param1: null)..load(),
    child: const _AstrologerListView(),
  );
}

class _AstrologerListView extends StatelessWidget {
  const _AstrologerListView();

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.title, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<AstrologerListCubit, AstrologerListState>(
          builder: (context, state) {
            final cubit = context.read<AstrologerListCubit>();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.sm,
                  ),
                  child: AppSearchField(
                    hint: s.searchHint,
                    readOnly: true,
                    onTap: () => context.push(AppRoutes.astrologerSearch),
                    filterCount: state.filter.activeCount,
                    onFilterTap: () => AstrologerFilterSheet.show(context),
                  ),
                ),
                _SortRow(
                  sort: state.filter.sort,
                  resultCount: state.results.length,
                  onlineCount: state.onlineCount,
                  onSortChanged: cubit.setSort,
                ),
                Expanded(
                  child: switch (state.astrologers) {
                    Idle() ||
                    Loading(previous: null) => const AstrologerListSkeleton(),
                    Failed(:final failure, previous: null) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.refresh,
                    ),
                    _ when state.isEmpty => _EmptyResults(
                      onClear: () {
                        cubit
                          ..beginFilterEdit()
                          ..resetDraft()
                          ..applyFilter();
                      },
                      canClear: state.filter.hasFilters,
                    ),
                    _ => RefreshIndicator(
                      onRefresh: cubit.refresh,
                      color: colors.accent,
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.pageGutter,
                          AppSpacing.sm,
                          AppSpacing.pageGutter,
                          AppSpacing.xxxl,
                        ),
                        itemCount: state.results.length,
                        itemBuilder: (context, i) {
                          final astrologer = state.results[i];
                          return AstrologerCard(
                            astrologer: astrologer,
                            onTap: () => context.push(
                              AppRoutes.astrologerProfilePath(astrologer.id),
                            ),
                            onFollowToggle: () =>
                                cubit.toggleFollow(astrologer.id),
                            onConsult: (channel) =>
                                _startConsult(context, astrologer.id, channel),
                          );
                        },
                      ),
                    ),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _startConsult(
    BuildContext context,
    String astrologerId,
    ConsultChannel channel,
  ) => context.push(
    AppRoutes.consultIntakePath(astrologerId, channel: channel.name),
  );
}

class _SortRow extends StatelessWidget {
  const _SortRow({
    required this.sort,
    required this.resultCount,
    required this.onlineCount,
    required this.onSortChanged,
  });

  final AstrologerSort sort;
  final int resultCount;
  final int onlineCount;
  final ValueChanged<AstrologerSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.success,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs + 2),
                Flexible(
                  child: Text(
                    '$onlineCount ${s.onlineNow.toLowerCase()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<AstrologerSort>(
            initialValue: sort,
            onSelected: onSortChanged,
            position: PopupMenuPosition.under,
            color: colors.surfaceElevated,
            itemBuilder: (context) => [
              for (final option in AstrologerSort.values)
                PopupMenuItem(
                  value: option,
                  child: Text(
                    s.sortName(option),
                    style: context.textTheme.bodyMedium,
                  ),
                ),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.swap_vert_rounded, size: 17, color: colors.accent),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  s.sortName(sort),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.onClear, required this.canClear});

  final VoidCallback onClear;
  final bool canClear;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search_outlined,
              size: 44,
              color: colors.textMuted,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(s.noResults, style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(
              s.noResultsHint,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textMuted,
              ),
            ),
            if (canClear) ...[
              const SizedBox(height: AppSpacing.xl),
              SecondaryButton(
                label: s.clearFilters,
                expanded: false,
                onPressed: onClear,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
