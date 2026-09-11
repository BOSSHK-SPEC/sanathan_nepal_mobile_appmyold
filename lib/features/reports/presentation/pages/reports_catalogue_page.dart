import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/report_product.dart';
import '../cubit/report_catalogue_cubit.dart';
import '../l10n/report_strings.dart';
import '../widgets/report_kind_icon.dart';

/// The paid-report storefront.
class ReportsCataloguePage extends StatelessWidget {
  const ReportsCataloguePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ReportCatalogueCubit>()..load(),
    child: const _CatalogueView(),
  );
}

class _CatalogueView extends StatelessWidget {
  const _CatalogueView();

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(
        title: s.reports,
        showBack: true,
        actions: [
          TextButton(
            onPressed: () => context.push(AppRoutes.myReports),
            child: Text(s.myReports),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ReportCatalogueCubit, ReportCatalogueState>(
          builder: (context, state) {
            final cubit = context.read<ReportCatalogueCubit>();
            return switch (state.products) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.refresh,
              ),
              _ => RefreshIndicator(
                onRefresh: cubit.refresh,
                color: colors.accent,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.xxxl,
                  ),
                  children: [
                    Text(
                      s.reportsSubtitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    for (final product in state.all)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _ProductCard(product: product),
                      ),
                  ],
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ReportProduct product;

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;
    final language = Localizations.localeOf(context).languageCode;

    return AppCard(
      onTap: () => context.push(AppRoutes.reportDetailsPath(product.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReportKindIcon(kind: product.kind),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            product.title.forLanguage(language),
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                        if (product.isPopular) ...[
                          const SizedBox(width: AppSpacing.sm),
                          StatusChip(
                            label: s.popular,
                            tone: StatusTone.accent,
                            dense: true,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      product.summary.forLanguage(language),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MoneyText(product.price, style: context.textTheme.titleMedium),
              if (product.isDiscounted) ...[
                const SizedBox(width: AppSpacing.sm),
                MoneyText(
                  product.originalPrice!,
                  strikethrough: true,
                  color: colors.textMuted,
                  style: context.textTheme.labelSmall,
                ),
                const SizedBox(width: AppSpacing.sm),
                StatusChip(
                  label: s.discountPercent(product.discountPercent),
                  tone: StatusTone.success,
                  dense: true,
                ),
              ],
              const Spacer(),
              Text(
                s.pageCount(product.pageCount),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
