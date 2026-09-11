import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/session/permission.dart';
import '../../../../core/session/session_scope.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/product.dart';
import '../cubit/boost_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/marketplace_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../widgets/boost_ads_section.dart';
import '../widgets/boosted_product_card.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/category_chips.dart';
import '../widgets/marketplace_dialogs.dart';
import '../widgets/marketplace_search_bar.dart';
import '../widgets/product_grid.dart';
import '../widgets/underline_tabs.dart';

/// Marketplace bottom-nav tab (Figma "MARKETPLACE" 1681:2913).
class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<MarketplaceCubit>()..load()),
      BlocProvider(create: (_) => sl<BoostCubit>()..load()),
      BlocProvider(create: (_) => sl<CartCubit>()..load()),
    ],
    child: const MarketplaceView(),
  );
}

/// Widget-testable body of [MarketplacePage] (cubits must be provided).
class MarketplaceView extends StatelessWidget {
  const MarketplaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(
        title: s.marketplace,
        actions: [
          IconButton(
            tooltip: s.savedProducts,
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () => context.push(AppRoutes.savedProducts),
          ),
          const CartIconButton(),
        ],
      ),
      body: BlocConsumer<MarketplaceCubit, MarketplaceState>(
        listenWhen: (a, b) => a.deletion != b.deletion,
        listener: (context, state) {
          final message = switch (state.deletion) {
            Loaded() => s.productDeleted,
            Failed(:final failure) => failure.message,
            Idle() || Loading() => null,
          };
          if (message != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          }
        },
        builder: (context, state) {
          final hasContent =
              (state.recent.dataOrNull?.isNotEmpty ?? false) ||
              (state.boosted.dataOrNull?.isNotEmpty ?? false);
          if (hasContent) return const _MarketplaceBody();
          return switch (state.recent) {
            Idle() || Loading() => const LoadingView(),
            Failed(:final failure) => ErrorView(
              message: failure.message,
              onRetry: context.read<MarketplaceCubit>().load,
            ),
            Loaded() => const _MarketplaceBody(),
          };
        },
      ),
    );
  }
}

class _MarketplaceBody extends StatelessWidget {
  const _MarketplaceBody();

  void _openProduct(BuildContext context, Product p) =>
      context.push(AppRoutes.productDetailsPath(p.id));

  /// Opens the seller form and refreshes the tab when it pops with a result.
  Future<void> _openForm(BuildContext context, String path) async {
    final cubit = context.read<MarketplaceCubit>();
    final changed = await context.push<Object?>(path);
    if (changed != null) await cubit.load();
  }

  Future<void> _deleteProduct(BuildContext context, Product p) async {
    final cubit = context.read<MarketplaceCubit>();
    if (await showDeleteProductDialog(context)) {
      await cubit.deleteMyProduct(p.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<MarketplaceCubit>();
    final state = context.watch<MarketplaceCubit>().state;
    final myProducts = state.myProducts.dataOrNull ?? const <Product>[];
    final feed = state.feed.dataOrNull ?? const <Product>[];
    return RefreshIndicator(
      onRefresh: cubit.load,
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          const SizedBox(height: AppSpacing.sm),
          CategoryChips(
            categories: state.categories.dataOrNull ?? const [],
            selectedId: state.selectedCategoryId,
            onSelected: cubit.selectCategory,
            onViewAll: () => context.push(AppRoutes.productListing),
          ),
          const SizedBox(height: AppSpacing.md),
          UnderlineTabs(
            tabs: [
              UnderlineTab(s.boostedPost),
              UnderlineTab(
                s.boostPostToSellQuickly,
                icon: Icon(
                  Icons.rocket_launch_rounded,
                  size: 12,
                  color: colors.accent,
                ),
              ),
              UnderlineTab(s.myProductsAndServices),
            ],
            selectedIndex: state.tab.index,
            onChanged: (i) => cubit.selectTab(MarketplaceTab.values[i]),
          ),
          const SizedBox(height: AppSpacing.md),
          switch (state.tab) {
            MarketplaceTab.boosted => _BoostedCarousel(
              products: state.boosted.dataOrNull ?? const [],
              onTap: (p) => _openProduct(context, p),
              onFavourite: (p) => cubit.toggleFavourite(p.id),
            ),
            MarketplaceTab.boost => const BoostAdsSection(),
            MarketplaceTab.myProducts => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: AppSpacing.page,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.myProductsAndServices,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Publishing needs an approved shop. Offering the
                      // button to everyone meant filling the whole form and
                      // being told "Missing permission" at the end.
                      if (context.can(Permission.manageProducts))
                        PrimaryButton(
                          label: s.addProduct,
                          expanded: false,
                          height: 30,
                          radius: AppRadius.sm,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                          ),
                          icon: Icon(
                            Icons.add,
                            size: 14,
                            color: colors.onPrimary,
                          ),
                          onPressed: () =>
                              _openForm(context, AppRoutes.productCreate),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (myProducts.isEmpty)
                  EmptyView(
                    message: context.can(Permission.manageProducts)
                        ? s.noMyProducts
                        : s.listingsNeedApproval,
                    icon: Icons.storefront_outlined,
                  )
                else
                  ProductGrid(
                    products: myProducts,
                    onTap: (p) => _openProduct(context, p),
                    onFavourite: (p) => cubit.toggleFavourite(p.id),
                    onEdit: (p) =>
                        _openForm(context, AppRoutes.productEditPath(p.id)),
                    onDelete: (p) => _deleteProduct(context, p),
                  ),
              ],
            ),
          },
          const SizedBox(height: AppSpacing.lg),
          Divider(height: 1, color: colors.divider),
          const SizedBox(height: AppSpacing.md),
          UnderlineTabs(
            tabs: [UnderlineTab(s.recent), UnderlineTab(s.recommendation)],
            selectedIndex: state.feedTab.index,
            onChanged: (i) => cubit.selectFeedTab(FeedTab.values[i]),
          ),
          const SizedBox(height: AppSpacing.md),
          if (feed.isEmpty)
            EmptyView(message: s.noProducts, icon: Icons.storefront_outlined)
          else
            ProductGrid(
              products: feed,
              onTap: (p) => _openProduct(context, p),
              onFavourite: (p) => cubit.toggleFavourite(p.id),
            ),
          const SizedBox(height: AppSpacing.xxl),
          AdBanner(label: s.settingTabAds, height: 120),
          const SizedBox(height: AppSpacing.md),
          MarketplaceSearchBar(
            hint: s.search,
            onSubmitted: (q) => context.push(
              Uri(
                path: AppRoutes.productListing,
                queryParameters: {'q': q},
              ).toString(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoostedCarousel extends StatelessWidget {
  const _BoostedCarousel({
    required this.products,
    required this.onTap,
    required this.onFavourite,
  });

  final List<Product> products;
  final ValueChanged<Product> onTap;
  final ValueChanged<Product> onFavourite;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return EmptyView(
        message: MarketplaceStrings.of(context).noProducts,
        icon: Icons.rocket_launch_outlined,
      );
    }
    return SizedBox(
      height: 134,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.page,
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) => BoostedProductCard(
          product: products[i],
          onTap: () => onTap(products[i]),
          onFavourite: () => onFavourite(products[i]),
        ),
      ),
    );
  }
}
