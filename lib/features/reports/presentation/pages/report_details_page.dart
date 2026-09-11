import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../kundli/domain/entities/birth_profile.dart';
import '../../domain/entities/report_product.dart';
import '../cubit/report_purchase_cubit.dart';
import '../l10n/report_strings.dart';
import '../widgets/report_kind_icon.dart';

/// One report: what it contains, whose chart it is for, and the payment.
///
/// Buying and choosing the chart are on the same screen on purpose — the
/// choice is short, and splitting it would put a step between the price and
/// the pay button for no gain.
class ReportDetailsPage extends StatelessWidget {
  const ReportDetailsPage({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ReportPurchaseCubit>(param1: productId)..load(),
    child: const _DetailsView(),
  );
}

class _DetailsView extends StatelessWidget {
  const _DetailsView();

  Future<void> _buy(BuildContext context) async {
    final cubit = context.read<ReportPurchaseCubit>();
    final report = await cubit.buy();
    if (!context.mounted) return;
    if (report == null) {
      AppSnack.error(
        context,
        cubit.state.purchaseError ?? ReportStrings.of(context).failedTitle,
      );
      return;
    }
    // Replace rather than push: coming back to a paid-for product page and
    // being able to buy it again is how people double-charge themselves.
    context.pushReplacement(AppRoutes.reportDeliveryPath(report.id));
  }

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;
    final language = Localizations.localeOf(context).languageCode;

    return BlocBuilder<ReportPurchaseCubit, ReportPurchaseState>(
      builder: (context, state) {
        final cubit = context.read<ReportPurchaseCubit>();
        final product = state.product.dataOrNull;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: product?.title.forLanguage(language) ?? s.reports,
            showBack: true,
          ),
          body: SafeArea(
            top: false,
            child: switch (state.product) {
              Idle() || Loading(previous: null) => const LoadingView(),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => _Body(product: product!, state: state),
            },
          ),
          bottomNavigationBar: product == null
              ? null
              : _PayBar(
                  product: product,
                  state: state,
                  onBuy: () => _buy(context),
                ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.product, required this.state});

  final ReportProduct product;
  final ReportPurchaseState state;

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<ReportPurchaseCubit>();
    final language = Localizations.localeOf(context).languageCode;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.md,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        Row(
          children: [
            ReportKindIcon(kind: product.kind, size: 56),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.reportKind(product.kind),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
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
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          child: Column(
            children: [
              KeyValueRow(
                label: s.pages,
                value: s.pageCount(product.pageCount),
              ),
              KeyValueRow(
                label: s.deliveredIn,
                value: s.minutes(product.deliveryTime.inMinutes),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: s.whatsInside),
        for (final item in product.contents)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 16,
                  color: colors.success,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    item.forLanguage(language),
                    style: context.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: s.forWhom),
        if (state.allProfiles.isEmpty)
          EmptyViewWithBody(
            title: s.noProfilesTitle,
            body: s.noProfilesBody,
            icon: Icons.person_add_alt_outlined,
            actionLabel: s.addBirthProfile,
            onAction: () => context.push(AppRoutes.kundliNew),
          )
        else
          _ProfilePicker(
            profiles: state.allProfiles,
            selectedId: state.selectedProfileId,
            onSelected: cubit.selectProfile,
          ),
        if (product.needsSecondProfile && state.allProfiles.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(title: s.partnerProfile),
          Text(
            s.choosePartner,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ProfilePicker(
            // A chart cannot be matched against itself; excluding it here
            // beats validating it after the buyer has paid.
            profiles: state.allProfiles
                .where((p) => p.id != state.selectedProfileId)
                .toList(),
            selectedId: state.partnerProfileId,
            onSelected: cubit.selectPartner,
          ),
        ],
      ],
    );
  }
}

class _ProfilePicker extends StatelessWidget {
  const _ProfilePicker({
    required this.profiles,
    required this.selectedId,
    required this.onSelected,
  });

  final List<BirthProfile> profiles;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final profile in profiles)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: _ProfileTile(
            profile: profile,
            selected: profile.id == selectedId,
            onTap: () => onSelected(profile.id),
          ),
        ),
    ],
  );
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.profile,
    required this.selected,
    required this.onTap,
  });

  final BirthProfile profile;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? colors.chipSelected : colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: selected ? colors.accent : colors.border),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 18,
              color: selected ? colors.accent : colors.textMuted,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.name, style: context.textTheme.bodyMedium),
                  Text(
                    profile.birthPlace,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PayBar extends StatelessWidget {
  const _PayBar({
    required this.product,
    required this.state,
    required this.onBuy,
  });

  final ReportProduct product;
  final ReportPurchaseState state;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.pageGutter),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  s.walletBalance,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                MoneyText(
                  state.balance,
                  style: context.textTheme.labelMedium,
                  color: state.canAfford ? colors.textPrimary : colors.error,
                ),
                const Spacer(),
                MoneyText(product.price, style: context.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // When the wallet is short, the useful action is topping up —
            // offering "Pay" that will certainly fail is not.
            state.canAfford
                ? PrimaryButton(
                    label: s.payAndGenerate,
                    isLoading: state.isBuying,
                    onPressed: state.isComplete && !state.isBuying
                        ? onBuy
                        : null,
                  )
                : PrimaryButton(
                    label: s.topUpFirst,
                    onPressed: () => context.push(AppRoutes.walletTopUp),
                  ),
          ],
        ),
      ),
    );
  }
}
