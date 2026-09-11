import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/boost_cubit.dart';
import '../l10n/marketplace_strings.dart';
import 'boost_form_card.dart';
import 'boost_select_card.dart';

/// "🚀 BOOST ADS" – explanation copy followed by the two-step boost flow.
/// Expects a [BoostCubit] above it.
class BoostAdsSection extends StatelessWidget {
  const BoostAdsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final t = context.textTheme;
    return BlocConsumer<BoostCubit, BoostState>(
      listenWhen: (a, b) =>
          a.submission != b.submission ||
          a.products.failureOrNull != b.products.failureOrNull,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        switch (state.submission) {
          case Loaded(:final data):
            messenger.showSnackBar(
              SnackBar(content: Text(s.boostSubmitted(data.referenceId))),
            );
          case Failed(:final failure):
            messenger.showSnackBar(SnackBar(content: Text(failure.message)));
          case Idle() || Loading():
            if (state.products case Failed(:final failure)) {
              messenger.showSnackBar(SnackBar(content: Text(failure.message)));
            }
        }
      },
      builder: (context, state) {
        final cubit = context.read<BoostCubit>();
        return Padding(
          padding: AppSpacing.page,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.rocket_launch_rounded,
                    size: 22,
                    color: colors.accent,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    s.boostAds,
                    style: t.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                s.boostHeadline,
                textAlign: TextAlign.center,
                style: t.titleSmall?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                s.boostBody,
                textAlign: TextAlign.center,
                style: t.labelSmall?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                s.boostAnalytics,
                textAlign: TextAlign.center,
                style: t.labelSmall?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (state.step == BoostStep.select)
                BoostSelectCard(
                  products: state.products.dataOrNull ?? const [],
                  selectedIds: state.selectedIds,
                  sort: state.sort,
                  loading: state.products.isLoading,
                  onSortChanged: cubit.setSort,
                  onToggle: cubit.toggleSelection,
                  onNext: cubit.next,
                  onProductTap: (p) =>
                      context.push(AppRoutes.productDetailsPath(p.id)),
                )
              else
                BoostFormCard(
                  selectedCount: state.selectedIds.length,
                  plans: state.plans.dataOrNull ?? const [],
                  plan: state.plan,
                  submitting: state.submission.isLoading,
                  onPlanChanged: cubit.selectPlan,
                  onBack: cubit.back,
                  onSubmit: (v) => cubit.submit(
                    firstName: v.firstName,
                    lastName: v.lastName,
                    phone: v.phone,
                    productLink: v.productLink,
                    receiptPath: v.receiptPath,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
