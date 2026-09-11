import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/business_form_cubit.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';

/// Second step of the business form: list of products/services with
/// add/remove actions and Back / Submit buttons.
class BusinessItemsStep extends StatelessWidget {
  const BusinessItemsStep({
    super.key,
    required this.state,
    required this.onAdd,
    required this.onRemove,
    required this.onBack,
    required this.onSubmit,
  });
  final BusinessFormState state;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final items = state.draft.items;
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        ProfileSectionCard(
          title: s.productsServicesDetails,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This list is application information, not the shop's public
              // catalogue — those are marketplace listings, added after
              // approval. Saying so here is what stops a seller filling this
              // in and then hunting for their products in the marketplace.
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  s.itemsAreForReview,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
              if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Text(s.noItems, style: context.textTheme.bodySmall),
                ),
              for (final item in items)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colors.shimmer,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      item.isService
                          ? Icons.design_services_outlined
                          : Icons.inventory_2_outlined,
                      size: 20,
                      color: colors.iconMuted,
                    ),
                  ),
                  title: Text(item.title, style: context.textTheme.titleSmall),
                  subtitle: Text(
                    [
                      '${item.category} · '
                          '${localizeDigits(context, item.priceLabel)}'
                          '${item.negotiable ? ' · ${s.negotiable}' : ''}',
                      if (item.purchaseLink.isNotEmpty) item.purchaseLink,
                    ].join('\n'),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: colors.error,
                    ),
                    onPressed: () => onRemove(item.id),
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add, size: 16),
                label: Text(s.addItem),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: s.back,
                  height: 40,
                  onPressed: onBack,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  label: s.submit,
                  height: 40,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  isLoading: state.submission.isLoading,
                  onPressed: onSubmit,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
