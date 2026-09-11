import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../marketplace/domain/entities/product.dart';
import '../../../marketplace/presentation/l10n/marketplace_strings.dart';
import '../../../marketplace/presentation/utils/marketplace_format.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';
import 'small_gradient_button.dart';

/// "Products" / "Services" tab: header with count, category chips, listing
/// grid and the "Add New Product / Add Other Services" action.
///
/// The listings are the shop's **marketplace** products, not a catalogue kept
/// on the business record. They used to be the latter, which meant a seller
/// could add a product here and never find it in the marketplace — two lists
/// with the same name and nothing connecting them.
class BusinessItemsSection extends StatefulWidget {
  const BusinessItemsSection({
    required this.items,
    required this.isServices,
    super.key,
    this.onAdd,
    this.onItemTap,
    this.onRemove,
    this.isLoading = false,
    this.errorMessage,
    this.addDisabledReason,
  });

  final List<Product> items;
  final bool isServices;

  /// "Add New Product / Add Other Services" – hidden when `null` (viewer).
  final VoidCallback? onAdd;
  final ValueChanged<Product>? onItemTap;

  /// Owner/admin delete action per card – hidden when `null`.
  final ValueChanged<Product>? onRemove;

  final bool isLoading;
  final String? errorMessage;

  /// Shown in place of the add button when the owner cannot publish yet —
  /// a pending shop has no `manageProducts`, and offering a button that can
  /// only fail is worse than saying why.
  final String? addDisabledReason;

  @override
  State<BusinessItemsSection> createState() => _BusinessItemsSectionState();
}

class _BusinessItemsSectionState extends State<BusinessItemsSection> {
  String? _category;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final categories = widget.items.map((i) => i.categoryId).toSet().toList();
    final visible = _category == null
        ? widget.items
        : widget.items.where((i) => i.categoryId == _category).toList();
    return ProfileSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.isServices ? s.services : s.allProducts,
                  style: context.textTheme.headlineSmall,
                ),
              ),
              Text(
                s.productsFound(localizeDigits(context, '${visible.length}')),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
          if (categories.length > 1) ...[
            const SizedBox(height: AppSpacing.sm),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _Chip(
                    label: 'All',
                    selected: _category == null,
                    onTap: () => setState(() => _category = null),
                  ),
                  for (final c in categories)
                    _Chip(
                      label: c,
                      selected: _category == c,
                      onTap: () => setState(() => _category = c),
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          if (widget.isLoading && widget.items.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: CircularProgressIndicator(),
              ),
            )
          else if (widget.errorMessage != null && widget.items.isEmpty)
            Text(
              widget.errorMessage!,
              style: context.textTheme.bodySmall?.copyWith(color: colors.error),
            )
          else if (visible.isEmpty)
            Text(s.noItems, style: context.textTheme.bodySmall)
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visible.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 150 / 165,
              ),
              itemBuilder: (_, i) => _ItemCard(
                item: visible[i],
                onTap: widget.onItemTap == null
                    ? null
                    : () => widget.onItemTap!(visible[i]),
                onRemove: widget.onRemove == null
                    ? null
                    : () => widget.onRemove!(visible[i]),
              ),
            ),
          if (widget.onAdd != null) ...[
            const SizedBox(height: AppSpacing.md),
            Center(
              child: SmallGradientButton(
                label: widget.isServices ? s.addOtherServices : s.addNewProduct,
                icon: Icons.add,
                height: 30,
                onPressed: widget.onAdd,
              ),
            ),
          ] else if (widget.addDisabledReason case final reason?) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 14,
                  color: colors.textMuted,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    reason,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.chipSelected : colors.chipBackground,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: selected ? colors.onChipSelected : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, this.onTap, this.onRemove});
  final Product item;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final t = context.textTheme;
    final s = ProfileStrings.of(context);
    final image = item.images.isEmpty ? null : item.images.first;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 150 / 70,
                  child: image == null
                      ? Container(
                          color: colors.shimmer,
                          child: Icon(
                            item.isService
                                ? Icons.design_services_outlined
                                : Icons.diamond_outlined,
                            color: colors.iconMuted,
                          ),
                        )
                      : AppImage(image),
                ),
                if (onRemove != null)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: IconButton(
                      tooltip: s.remove,
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: onRemove,
                      icon: Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: colors.error,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.titleFor(languageCode: context.languageCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    item.descriptionFor(languageCode: context.languageCode),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: t.labelSmall?.copyWith(
                      fontSize: 9,
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    // A price of zero is a listing whose owner never named one
                    // — say so rather than printing "Rs 0".
                    item.price <= 0
                        ? MarketplaceStrings.of(context).askForPrice
                        : MarketplaceFormat.priceOf(context, item.price),
                    style: t.labelSmall?.copyWith(
                      color: colors.accent,
                      fontWeight: FontWeight.w600,
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
