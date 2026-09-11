import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../l10n/marketplace_strings.dart';

/// Shared 345px-wide dialog chrome used by the marketplace popups
/// (Figma "Order POPUP", "Seller Approval", "Product Category edit POPUP").
class MarketplaceDialog extends StatelessWidget {
  const MarketplaceDialog({
    required this.title,
    required this.child,
    required this.primaryLabel,
    required this.onPrimary,
    super.key,
    this.subtitle,
    this.secondaryLabel,
    this.onSecondary,
    this.titleIcon,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final Widget? titleIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineSmall,
                  ),
                ),
                ?titleIcon,
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            child,
            const SizedBox(height: AppSpacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (secondaryLabel != null)
                  SecondaryButton(
                    label: secondaryLabel!,
                    expanded: false,
                    height: 36,
                    onPressed: onSecondary ?? () => Navigator.of(context).pop(),
                  )
                else
                  const SizedBox.shrink(),
                PrimaryButton(
                  label: primaryLabel,
                  expanded: false,
                  height: 36,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  onPressed: onPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// "Order" popup – buyer quotes a price; returns the quoted amount or null.
Future<double?> showOrderRequestDialog(
  BuildContext context, {
  required String productTitle,
}) {
  final s = MarketplaceStrings.of(context);
  final controller = TextEditingController();
  return showDialog<double>(
    context: context,
    builder: (ctx) => MarketplaceDialog(
      title: productTitle,
      subtitle: s.sendOrderRequest,
      primaryLabel: s.order,
      secondaryLabel: s.cancel,
      onPrimary: () =>
          Navigator.of(ctx).pop(double.tryParse(controller.text.trim()) ?? 0),
      child: AppTextField(
        controller: controller,
        hint: s.quoteYourPrice(context.regionConfig.currencyCode),
        keyboardType: TextInputType.number,
      ),
    ),
  ).whenComplete(controller.dispose);
}

/// "Seller Approval" popup – seller confirms the final price for a request.
Future<double?> showSellerApprovalDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
}) {
  final s = MarketplaceStrings.of(context);
  final controller = TextEditingController();
  return showDialog<double>(
    context: context,
    builder: (ctx) => MarketplaceDialog(
      title: title,
      subtitle: subtitle,
      primaryLabel: s.confirm,
      secondaryLabel: s.cancel,
      titleIcon: IconButton(
        icon: const Icon(Icons.close, size: 16),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
      onPrimary: () =>
          Navigator.of(ctx).pop(double.tryParse(controller.text.trim()) ?? 0),
      child: AppTextField(
        controller: controller,
        hint: s.finalPriceHint(context.regionConfig.currencyCode),
        keyboardType: TextInputType.number,
      ),
    ),
  ).whenComplete(controller.dispose);
}

/// "Product Category edit" popup – returns the new category name or null.
Future<String?> showCategoryEditDialog(
  BuildContext context, {
  required String currentName,
  String? photoName,
}) {
  final s = MarketplaceStrings.of(context);
  final controller = TextEditingController(text: currentName);
  final colors = context.colors;
  return showDialog<String>(
    context: context,
    builder: (ctx) => MarketplaceDialog(
      title: currentName,
      titleIcon: Icon(Icons.edit_outlined, size: 16, color: colors.icon),
      primaryLabel: s.save,
      secondaryLabel: s.cancel,
      onPrimary: () => Navigator.of(ctx).pop(controller.text.trim()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: controller,
            label: s.productCategoryName,
            required: true,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: s.categoryPhoto,
            required: true,
            readOnly: true,
            hint: photoName ?? 'Category 1.jpg',
            suffix: Icon(Icons.photo_camera_outlined, color: colors.iconMuted),
          ),
        ],
      ),
    ),
  ).whenComplete(controller.dispose);
}

/// "DELETE POPUP" – trash icon, title, message, Cancel + Delete. Resolves to
/// `true` when the seller confirms.
Future<bool> showDeleteProductDialog(BuildContext context) async {
  final s = MarketplaceStrings.of(context);
  final colors = context.colors;
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.error.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: colors.error,
                size: 30,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              s.deleteProductTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              s.deleteProductMessage,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: s.cancel,
                    height: 36,
                    onPressed: () => Navigator.of(ctx).pop(false),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PrimaryButton(
                    label: s.delete,
                    height: 36,
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(ctx).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return result ?? false;
}
