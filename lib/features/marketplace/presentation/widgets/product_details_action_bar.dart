import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_details_cubit.dart';
import '../l10n/marketplace_strings.dart';

/// Sticky bottom bar of the details page: round Call / Chat buttons and a
/// wide "Add to Cart" (or "Edit Product" for the seller's own listing).
class ProductDetailsActionBar extends StatelessWidget {
  const ProductDetailsActionBar({
    required this.product,
    super.key,
    this.onEdit,
  });

  final Product product;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final adding = context.select(
      (ProductDetailsCubit c) => c.state.addToCart.isLoading,
    );
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pageGutter,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.divider)),
        ),
        child: Row(
          children: [
            RoundIconButton(
              icon: Icons.call,
              tooltip: s.call,
              onPressed: () => showSellerContact(context, product, s.call),
            ),
            const SizedBox(width: AppSpacing.sm),
            RoundIconButton(
              icon: Icons.chat_bubble_outline,
              tooltip: s.chat,
              onPressed: () => showSellerContact(context, product, s.chat),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: onEdit != null
                  ? PrimaryButton(
                      label: s.edit,
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 16,
                        color: colors.onPrimary,
                      ),
                      onPressed: onEdit,
                    )
                  : PrimaryButton(
                      label: s.addToCart,
                      height: 40,
                      isLoading: adding,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      icon: Icon(
                        Icons.add_shopping_cart,
                        size: 16,
                        color: colors.onPrimary,
                      ),
                      onPressed: context.read<ProductDetailsCubit>().addToCart,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Snackbar with the seller's name + phone (no dialer / chat backend yet).
void showSellerContact(BuildContext context, Product product, String action) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          '$action: ${product.seller.name} · ${product.seller.phone ?? ''}',
        ),
      ),
    );
}

/// 40 px outlined circular icon button (Call / Chat).
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.accent),
            ),
            child: Icon(icon, size: 18, color: colors.accent),
          ),
        ),
      ),
    );
  }
}
