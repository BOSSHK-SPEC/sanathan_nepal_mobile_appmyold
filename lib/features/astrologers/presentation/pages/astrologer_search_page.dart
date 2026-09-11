import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/astrologer_list_cubit.dart';
import '../l10n/astrologers_strings.dart';
import '../widgets/astrologer_card.dart';
import '../widgets/astrologer_list_skeleton.dart';

/// Dedicated search screen with recent searches.
///
/// A separate route rather than an in-place mode on the listing, so the
/// keyboard-first experience gets the whole screen and the back button does
/// the obvious thing.
class AstrologerSearchPage extends StatelessWidget {
  const AstrologerSearchPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AstrologerListCubit>(param1: null)..load(),
    child: const _AstrologerSearchView(),
  );
}

class _AstrologerSearchView extends StatefulWidget {
  const _AstrologerSearchView();

  @override
  State<_AstrologerSearchView> createState() => _AstrologerSearchViewState();
}

class _AstrologerSearchViewState extends State<_AstrologerSearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runSearch(String query) {
    _controller.text = query;
    _controller.selection = TextSelection.collapsed(offset: query.length);
    context.read<AstrologerListCubit>().submitSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.icon),
          onPressed: () => context.pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.pageGutter),
          child: AppSearchField(
            hint: s.searchHint,
            controller: _controller,
            autofocus: true,
            onChanged: context.read<AstrologerListCubit>().search,
            onSubmitted: (q) =>
                context.read<AstrologerListCubit>().submitSearch(q),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<AstrologerListCubit, AstrologerListState>(
          builder: (context, state) {
            final cubit = context.read<AstrologerListCubit>();

            if (!state.isSearching) {
              return _RecentSearches(
                searches: state.recentSearches,
                onTap: _runSearch,
                onClear: cubit.clearRecentSearches,
              );
            }

            return switch (state.astrologers) {
              Idle() ||
              Loading(previous: null) => const AstrologerListSkeleton(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.refresh,
              ),
              _ when state.isEmpty => EmptyView(
                message: s.noResults,
                icon: Icons.person_search_outlined,
              ),
              _ => ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.md,
                  AppSpacing.pageGutter,
                  AppSpacing.xxxl,
                ),
                itemCount: state.results.length,
                itemBuilder: (context, i) {
                  final astrologer = state.results[i];
                  return AstrologerCard(
                    astrologer: astrologer,
                    onTap: () {
                      cubit.submitSearch(_controller.text);
                      context.push(
                        AppRoutes.astrologerProfilePath(astrologer.id),
                      );
                    },
                    onFollowToggle: () => cubit.toggleFollow(astrologer.id),
                  );
                },
              ),
            };
          },
        ),
      ),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  const _RecentSearches({
    required this.searches,
    required this.onTap,
    required this.onClear,
  });

  final List<String> searches;
  final ValueChanged<String> onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    if (searches.isEmpty) {
      return EmptyView(message: s.searchEmpty, icon: Icons.search_rounded);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageGutter,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  s.recentSearches,
                  style: context.textTheme.titleSmall,
                ),
              ),
              TextButton(
                onPressed: onClear,
                child: Text(
                  s.clearAll,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (final query in searches)
          ListTile(
            dense: true,
            leading: Icon(
              Icons.history_rounded,
              size: 20,
              color: colors.iconMuted,
            ),
            title: Text(query, style: context.textTheme.bodyMedium),
            trailing: Icon(
              Icons.north_west_rounded,
              size: 16,
              color: colors.iconMuted,
            ),
            onTap: () => onTap(query),
          ),
      ],
    );
  }
}
