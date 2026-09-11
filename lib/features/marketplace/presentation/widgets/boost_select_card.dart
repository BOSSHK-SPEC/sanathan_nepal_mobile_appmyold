import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';
import '../l10n/marketplace_strings.dart';
import 'product_grid_card.dart';
import 'sort_by_row.dart';
import 'step_header.dart';

/// Step 1 of Boost: "Select your Product/Service" with sort + checkbox grid.
class BoostSelectCard extends StatelessWidget {
  const BoostSelectCard({
    required this.products,
    required this.selectedIds,
    required this.sort,
    required this.onSortChanged,
    required this.onToggle,
    required this.onNext,
    required this.onProductTap,
    super.key,
    this.loading = false,
  });

  final List<Product> products;
  final Set<String> selectedIds;
  final ProductSort sort;
  final ValueChanged<ProductSort> onSortChanged;
  final ValueChanged<String> onToggle;
  final VoidCallback onNext;
  final ValueChanged<Product> onProductTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withValues(
          alpha: context.isDark ? 0.6 : 1,
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StepHeader(
            steps: [
              StepItem(
                label: s.selectYourProductService,
                icon: Icons.shopping_bag_outlined,
              ),
              StepItem(
                label: s.checkout,
                icon: Icons.account_balance_wallet_outlined,
              ),
            ],
            activeIndex: 0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SortByRow(value: sort, onChanged: onSortChanged),
                const SizedBox(height: AppSpacing.sm),
                if (loading)
                  const LoadingView(height: 120)
                else if (products.isEmpty)
                  EmptyView(
                    message: s.noMyProducts,
                    icon: Icons.storefront_outlined,
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisExtent: 215,
                          crossAxisSpacing: AppSpacing.sm,
                          mainAxisSpacing: AppSpacing.sm,
                        ),
                    itemBuilder: (context, i) {
                      final p = products[i];
                      return ProductGridCard(
                        product: p,
                        selectable: true,
                        selected: selectedIds.contains(p.id),
                        onSelectedChanged: (_) => onToggle(p.id),
                        onTap: () => onProductTap(p),
                      );
                    },
                  ),
                const SizedBox(height: AppSpacing.md),
                Center(
                  child: SizedBox(
                    width: 160,
                    child: PrimaryButton(
                      label: s.next,
                      height: 34,
                      radius: AppRadius.sm,
                      onPressed: selectedIds.isEmpty ? null : onNext,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
