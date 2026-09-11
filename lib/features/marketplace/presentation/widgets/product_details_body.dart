import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_details_cubit.dart';
import '../l10n/marketplace_strings.dart';
import 'comments_section.dart';
import 'general_specs_card.dart';
import 'marketplace_dialogs.dart';
import 'product_details_action_bar.dart';
import 'product_hero.dart';
import 'product_info_header.dart';
import 'product_option_selector.dart';
import 'product_reviews_preview.dart';
import 'product_videos_section.dart';
import 'similar_products_section.dart';
import 'underline_tabs.dart';

/// Scrollable content of the details page, top to bottom: hero + thumbnails,
/// title / price / seller, Description | Comments tabs with Call / Order
/// pills, summary, option selectors, "Add to Cart" + "Buy Now" square
/// buttons, long description, General specs, Product Videos, inspection
/// note and Similar Products.
class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({
    required this.product,
    required this.state,
    required this.onShare,
    required this.onBuyNow,
    super.key,
    this.onEdit,
  });

  final Product product;
  final ProductDetailsState state;
  final VoidCallback onShare;
  final VoidCallback onBuyNow;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final lang = context.languageCode;
    final details = product.detailParagraphsFor(languageCode: lang);
    final adding = state.addToCart.isLoading;
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        ProductHero(
          images: product.images,
          selectedIndex: state.selectedImage,
          onSelected: cubit.selectImage,
          isFavourite: product.isFavourite,
          onFavourite: cubit.toggleFavourite,
          onShare: onShare,
          onEdit: onEdit,
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: AppSpacing.page,
          child: ProductInfoHeader(product: product),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: AppSpacing.page,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: UnderlineTabs(
                  padding: EdgeInsets.zero,
                  tabs: [UnderlineTab(s.description), UnderlineTab(s.comments)],
                  selectedIndex: state.tab.index,
                  onChanged: (i) => cubit.selectTab(DetailsTab.values[i]),
                ),
              ),
              _PillAction(
                icon: Icons.call,
                label: s.call,
                onPressed: () => showSellerContact(context, product, s.call),
              ),
              const SizedBox(width: AppSpacing.sm),
              _PillAction(
                icon: Icons.add_shopping_cart,
                label: s.order,
                onPressed: () => _order(context, product),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: AppSpacing.page,
          child: state.tab == DetailsTab.description
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.summaryFor(languageCode: lang),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    if (product.options.isNotEmpty)
                      Divider(height: AppSpacing.xxl, color: colors.divider),
                    for (final option in product.options.entries) ...[
                      ProductOptionSelector(
                        name: option.key,
                        values: option.value,
                        selected: state.selectedOptions[option.key],
                        onSelected: (v) => cubit.selectOption(option.key, v),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                    if (product.options.isEmpty)
                      const SizedBox(height: AppSpacing.lg),
                    if (!product.isMine) ...[
                      // "button - square" ×2 (335×45).
                      PrimaryButton(
                        label: s.addToCart,
                        height: 45,
                        radius: AppRadius.sm,
                        isLoading: adding && !state.buyNow,
                        icon: Icon(
                          Icons.add_shopping_cart,
                          size: 16,
                          color: colors.onPrimary,
                        ),
                        onPressed: adding ? null : cubit.addToCart,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: s.buyNow,
                        height: 45,
                        radius: AppRadius.sm,
                        icon: Icon(
                          Icons.flash_on_rounded,
                          size: 16,
                          color: colors.accent,
                        ),
                        onPressed: adding ? null : onBuyNow,
                      ),
                    ],
                    if (details.isNotEmpty) ...[
                      Divider(height: AppSpacing.xxl, color: colors.divider),
                      _DetailParagraphs(paragraphs: details),
                    ],
                  ],
                )
              : CommentsSection(comments: product.comments),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: AppSpacing.page,
          child: GeneralSpecsCard(product: product),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: AppSpacing.page,
          child: ProductReviewsPreview(
            productId: product.id,
            isSeller: product.isMine,
          ),
        ),
        if (product.videos.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: AppSpacing.page,
            child: ProductVideosSection(
              product: product,
              onPlay: (url) => ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(url))),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: AppSpacing.page,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.border),
            ),
            child: Text(
              s.inspectionNote,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SimilarProductsSection(
          products: state.similar.dataOrNull ?? const [],
          onTap: (p) => context.push(AppRoutes.productDetailsPath(p.id)),
        ),
      ],
    );
  }

  Future<void> _order(BuildContext context, Product product) async {
    final s = MarketplaceStrings.of(context);
    final quote = await showOrderRequestDialog(
      context,
      productTitle: product.titleFor(languageCode: context.languageCode),
    );
    if (quote != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(s.orderRequestSent)));
    }
  }
}

/// Long description: the first paragraph is rendered as a heading when more
/// than one paragraph follows the summary ("मोती कसले धारण गर्ने ?").
class _DetailParagraphs extends StatelessWidget {
  const _DetailParagraphs({required this.paragraphs});
  final List<String> paragraphs;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasHeading = paragraphs.length > 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < paragraphs.length; i++) ...[
          Text(
            paragraphs[i],
            style: hasHeading && i == 0
                ? context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  )
                : context.textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                    height: 1.5,
                  ),
          ),
          if (i < paragraphs.length - 1) const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

/// Small "Button/Primary" pill (Call / Order) beside the tabs.
class _PillAction extends StatelessWidget {
  const _PillAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => PrimaryButton(
    label: label,
    expanded: false,
    height: 24,
    radius: AppRadius.xs,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    icon: Icon(icon, size: 12, color: context.colors.onPrimary),
    onPressed: onPressed,
  );
}
