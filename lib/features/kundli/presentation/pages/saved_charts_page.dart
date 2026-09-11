import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/birth_profile.dart';
import '../cubit/saved_charts_cubit.dart';
import '../l10n/kundli_strings.dart';

/// Saved birth charts — the entry point to everything in this feature.
class SavedChartsPage extends StatelessWidget {
  const SavedChartsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<SavedChartsCubit>()..load(),
    child: const _SavedChartsView(),
  );
}

class _SavedChartsView extends StatelessWidget {
  const _SavedChartsView();

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.kundli, showBack: true),
      floatingActionButton: BlocBuilder<SavedChartsCubit, SavedChartsState>(
        buildWhen: (p, n) => p.isEmpty != n.isEmpty,
        builder: (context, state) => state.isEmpty
            ? const SizedBox.shrink()
            : FloatingActionButton.extended(
                backgroundColor: colors.accent,
                foregroundColor: colors.onPrimary,
                onPressed: () async {
                  await context.push(AppRoutes.kundliNew);
                  if (context.mounted) {
                    await context.read<SavedChartsCubit>().load();
                  }
                },
                icon: const Icon(Icons.add_rounded),
                label: Text(s.newChart),
              ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<SavedChartsCubit, SavedChartsState>(
          builder: (context, state) {
            final cubit = context.read<SavedChartsCubit>();

            return switch (state.profiles) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 4),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ when state.isEmpty => _EmptyCharts(strings: s),
              _ => ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.md,
                  AppSpacing.pageGutter,
                  AppSpacing.xxxl * 2,
                ),
                children: [
                  if (state.canMatch) ...[
                    AppCard(
                      onTap: () => context.push(AppRoutes.kundliMatch),
                      gradient: colors.cardGradient,
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.accent.withValues(alpha: 0.14),
                            ),
                            child: Icon(
                              Icons.favorite_rounded,
                              size: 20,
                              color: colors.accent,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.matchKundli,
                                  style: context.textTheme.titleSmall,
                                ),
                                Text(
                                  s.matchKundliSubtitle,
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: colors.iconMuted,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  for (final profile in state.charts)
                    _ChartTile(
                      profile: profile,
                      strings: s,
                      onOpen: () =>
                          context.push(AppRoutes.kundliChartPath(profile.id)),
                      onDelete: () async {
                        final confirmed = await AppConfirmSheet.show(
                          context,
                          title: s.deleteChart,
                          message: s.deleteChartBody,
                          confirmLabel: s.delete,
                          cancelLabel: s.cancel,
                        );
                        if (confirmed) await cubit.delete(profile.id);
                      },
                    ),
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}

class _ChartTile extends StatelessWidget {
  const _ChartTile({
    required this.profile,
    required this.strings,
    required this.onOpen,
    required this.onDelete,
  });

  final BirthProfile profile;
  final KundliStrings strings;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final date = DateFormat.yMMMd(
      context.languageCode,
    ).format(profile.birthDateTime);

    return AppCard(
      onTap: onOpen,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          AppAvatar(name: profile.name, size: 44),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        profile.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    StatusChip(
                      label: strings.relationName(profile.relation),
                      dense: true,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  profile.timeUnknown
                      ? '$date · ${profile.birthPlace}'
                      : '$date · '
                            '${DateFormat.Hm().format(profile.birthDateTime)} · '
                            '${profile.birthPlace}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: colors.iconMuted,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _EmptyCharts extends StatelessWidget {
  const _EmptyCharts({required this.strings});

  final KundliStrings strings;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome_outlined,
            size: 46,
            color: context.colors.textMuted,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(strings.noChartsTitle, style: context.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            strings.noChartsBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: strings.createFirstChart,
            expanded: false,
            onPressed: () async {
              await context.push(AppRoutes.kundliNew);
              if (context.mounted) {
                await context.read<SavedChartsCubit>().load();
              }
            },
          ),
        ],
      ),
    ),
  );
}
