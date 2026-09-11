import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/puja_service.dart';
import '../cubit/puja_catalogue_cubit.dart';
import '../l10n/puja_strings.dart';
import '../widgets/puja_card.dart';

/// The puja storefront, grouped by what the devotee is asking for.
class PujaCataloguePage extends StatelessWidget {
  const PujaCataloguePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PujaCatalogueCubit>()..load(),
    child: const _CatalogueView(),
  );
}

class _CatalogueView extends StatelessWidget {
  const _CatalogueView();

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(
        title: s.pujas,
        showBack: true,
        actions: [
          TextButton(
            onPressed: () => context.push(AppRoutes.myPujas),
            child: Text(s.myPujas),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<PujaCatalogueCubit, PujaCatalogueState>(
          builder: (context, state) {
            final cubit = context.read<PujaCatalogueCubit>();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.pujasSubtitle,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Single-select: people arrive with one problem, and a
                      // multi-select here would mostly produce empty results.
                      SizedBox(
                        height: 34,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: PujaPurpose.values.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: AppSpacing.sm),
                          itemBuilder: (context, i) {
                            final purpose = PujaPurpose.values[i];
                            return ChoiceChip(
                              label: Text(s.purposeName(purpose)),
                              selected: state.purpose == purpose,
                              onSelected: (_) => cubit.selectPurpose(purpose),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: switch (state.services) {
                    Idle() || Loading(previous: null) =>
                      const AppSkeletonList.tiles(count: 4),
                    Failed(:final failure, previous: null) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.refresh,
                    ),
                    _ when state.isEmpty => EmptyView(
                      message: s.noMuhurtaBody,
                      icon: Icons.temple_hindu_outlined,
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
                        itemCount: state.all.length,
                        itemBuilder: (context, i) => PujaCard(
                          service: state.all[i],
                          onTap: () => context.push(
                            AppRoutes.pujaDetailsPath(state.all[i].id),
                          ),
                        ),
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
}
