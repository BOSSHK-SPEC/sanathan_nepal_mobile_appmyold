import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer_client.dart';
import '../cubit/clients_cubit.dart';
import '../l10n/console_strings.dart';

/// The astrologer's client book.
class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ClientsCubit>()..load(),
    child: const _ClientsView(),
  );
}

class _ClientsView extends StatelessWidget {
  const _ClientsView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.navClients, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ClientsCubit, ClientsState>(
          builder: (context, state) {
            final cubit = context.read<ClientsCubit>();

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
                    hint: s.searchClients,
                    onChanged: cubit.search,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pageGutter,
                  ),
                  child: Row(
                    children: [
                      for (final (sort, label) in [
                        (ClientSort.recent, s.sortRecent),
                        (ClientSort.value, s.sortValue),
                        (ClientSort.sessions, s.sortSessions),
                      ]) ...[
                        _SortChip(
                          label: label,
                          selected: state.sort == sort,
                          onTap: () => cubit.setSort(sort),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: switch (state.clients) {
                    Idle() || Loading(previous: null) =>
                      const AppSkeletonList.tiles(count: 5),
                    Failed(:final failure, previous: null) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.load,
                    ),
                    _ when state.isEmpty => _EmptyClients(strings: s),
                    _ when state.visible.isEmpty => EmptyView(
                      message: s.noClients,
                      icon: Icons.search_off_rounded,
                    ),
                    _ => ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.pageGutter,
                        0,
                        AppSpacing.pageGutter,
                        AppSpacing.xxxl,
                      ),
                      children: [
                        for (final client in state.visible)
                          _ClientTile(client: client, strings: s),
                      ],
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
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs + 2,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.chipSelected : colors.chipBackground,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: selected ? colors.onChipSelected : colors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _ClientTile extends StatelessWidget {
  const _ClientTile({required this.client, required this.strings});

  final AstrologerClient client;
  final ConsoleStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      onTap: () => context.push(AppRoutes.astrologerClientPath(client.id)),
      child: Row(
        children: [
          AppAvatar(source: client.avatar, name: client.name, size: 44),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        client.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    if (client.isRepeat) ...[
                      const SizedBox(width: AppSpacing.xs),
                      StatusChip(
                        label: strings.repeatClient,
                        tone: StatusTone.info,
                        dense: true,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${_digits(context, client.sessionCount)} '
                  '${strings.sessions} · '
                  '${relativeTime(context, client.lastSessionAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          MoneyText(client.lifetimeValue, style: context.textTheme.titleSmall),
        ],
      ),
    );
  }
}

class _EmptyClients extends StatelessWidget {
  const _EmptyClients({required this.strings});

  final ConsoleStrings strings;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 42,
            color: context.colors.textMuted,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(strings.noClients, style: context.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            strings.noClientsBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textMuted,
            ),
          ),
        ],
      ),
    ),
  );
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
