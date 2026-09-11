import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/product.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/product_listing_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/product_list_card.dart';

/// Listings the buyer has saved.
///
/// Favouriting was write-only until now — the heart could be tapped from
/// three screens but never read back. This is the read side, and it is the
/// same grid as the listing page with a favourites-only filter rather than a
/// parallel screen.
class SavedProductsPage extends StatelessWidget {
  const SavedProductsPage({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => sl<ProductListingCubit>()..load(favouritesOnly: true),
      ),
      BlocProvider(create: (_) => sl<CartCubit>()..load()),
    ],
    child: const SavedProductsView(),
  );
}

/// Widget-testable body of [SavedProductsPage].
class SavedProductsView extends StatelessWidget {
  const SavedProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(
        title: s.savedProducts,
        showBack: true,
        actions: const [CartIconButton()],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ProductListingCubit, ProductListingState>(
          builder: (context, state) {
            final cubit = context.read<ProductListingCubit>();
            final products = state.products.dataOrNull ?? const <Product>[];

            return switch (state.products) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 4),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: () => cubit.load(favouritesOnly: true),
              ),
              _ when products.isEmpty => EmptyViewWithBody(
                title: s.noSavedTitle,
                body: s.noSavedBody,
                icon: Icons.favorite_border_rounded,
                actionLabel: s.browseMarketplace,
                onAction: () => context.go(AppRoutes.marketplace),
              ),
              _ => CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.pageGutter,
                        AppSpacing.md,
                        AppSpacing.pageGutter,
                        AppSpacing.sm,
                      ),
                      child: Text(
                        '${products.length} ${s.savedCount}',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.pageGutter,
                      0,
                      AppSpacing.pageGutter,
                      AppSpacing.xxl,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 200,
                            crossAxisSpacing: AppSpacing.md,
                            mainAxisSpacing: AppSpacing.md,
                          ),
                      delegate: SliverChildBuilderDelegate((context, i) {
                        final product = products[i];
                        return ProductListCard(
                          product: product,
                          onTap: () => context.push(
                            AppRoutes.productDetailsPath(product.id),
                          ),
                          // Un-hearting here removes the card, which is what
                          // a saved list is for.
                          onFavourite: () => cubit.toggleFavourite(product.id),
                          onAddToCart: () {
                            context.read<CartCubit>().add(product);
                            AppSnack.show(context, s.addedToCart);
                          },
                        );
                      }, childCount: products.length),
                    ),
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
