import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/product_listing_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/marketplace_search_bar.dart';
import '../widgets/product_list_card.dart';
import '../widgets/sort_by_row.dart';

/// "Product & Service listing Page" (Figma 475:731) – search, category title,
/// "N products found" and a grid of [ProductListCard]s.
class ProductListingPage extends StatelessWidget {
  const ProductListingPage({super.key, this.categoryId, this.query});

  final String? categoryId;
  final String? query;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) =>
            sl<ProductListingCubit>()
              ..load(categoryId: categoryId, query: query),
      ),
      BlocProvider(create: (_) => sl<CartCubit>()..load()),
    ],
    child: ProductListingView(initialQuery: query),
  );
}

/// Widget-testable body of [ProductListingPage].
class ProductListingView extends StatefulWidget {
  const ProductListingView({super.key, this.initialQuery});
  final String? initialQuery;

  @override
  State<ProductListingView> createState() => _ProductListingViewState();
}

class _ProductListingViewState extends State<ProductListingView> {
  late final TextEditingController _search = TextEditingController(
    text: widget.initialQuery ?? '',
  );

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;
    final lang = context.languageCode;
    return Scaffold(
      appBar: AppTopBar(
        title: s.marketplace,
        showBack: true,
        actions: const [CartIconButton()],
      ),
      body: BlocBuilder<ProductListingCubit, ProductListingState>(
        builder: (context, state) {
          final cubit = context.read<ProductListingCubit>();
          final products = state.products.dataOrNull ?? const <Product>[];
          final title =
              state.category?.name(languageCode: lang) ??
              (state.filter.query?.isNotEmpty ?? false
                  ? '“${state.filter.query}”'
                  : s.all);
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    MarketplaceSearchBar(
                      controller: _search,
                      hint: s.searchProduct,
                      onSubmitted: cubit.search,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _CategoryStrip(
                      categories: state.categories.dataOrNull ?? const [],
                      selectedId: state.filter.categoryId,
                      onSelected: cubit.selectCategory,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Padding(
                      padding: AppSpacing.page,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              title.toUpperCase(),
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            s.productsFound(products.length),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: AppSpacing.page,
                      child: SortByRow(
                        value: state.filter.sort,
                        onChanged: cubit.setSort,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ),
              ),
              if (state.products.isLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: LoadingView(),
                )
              else if (state.products case Failed(:final failure))
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorView(
                    message: failure.message,
                    onRetry: () => cubit.search(state.filter.query ?? ''),
                  ),
                )
              else if (products.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyView(
                    message: s.noProducts,
                    icon: Icons.storefront_outlined,
                  ),
                )
              else
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
                      final p = products[i];
                      return ProductListCard(
                        product: p,
                        onTap: () =>
                            context.push(AppRoutes.productDetailsPath(p.id)),
                        onFavourite: () => cubit.toggleFavourite(p.id),
                        onAddToCart: () {
                          context.read<CartCubit>().add(p);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(content: Text(s.addedToCart)),
                            );
                        },
                      );
                    }, childCount: products.length),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<Category> categories;
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final lang = context.languageCode;
    final items = [Category.all, ...categories];
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.page,
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final c = items[i];
          final selected = c.id == Category.all.id
              ? selectedId == null
              : c.id == selectedId;
          return ChoiceChip(
            label: Text(
              c.id == Category.all.id ? s.all : c.name(languageCode: lang),
            ),
            selected: selected,
            showCheckmark: false,
            selectedColor: colors.chipSelected,
            backgroundColor: colors.chipBackground,
            side: BorderSide.none,
            labelStyle: context.textTheme.labelMedium?.copyWith(
              color: selected ? colors.onChipSelected : colors.textSecondary,
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            visualDensity: VisualDensity.compact,
            onSelected: (_) => onSelected(c.id),
          );
        },
      ),
    );
  }
}
