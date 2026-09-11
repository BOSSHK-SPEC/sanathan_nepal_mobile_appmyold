import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/primary_button.dart';

import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';

/// Bottom sheet showing full details for a business product or service item.
class BusinessItemDetailsSheet extends StatelessWidget {
  const BusinessItemDetailsSheet({
    required this.item,
    required this.business,
    super.key,
    this.onEdit,
  });

  final BusinessItem item;
  final BusinessProfile business;
  final VoidCallback? onEdit;

  static Future<void> show(
    BuildContext context, {
    required BusinessItem item,
    required BusinessProfile business,
    VoidCallback? onEdit,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.colors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
    ),
    builder: (_) => BusinessItemDetailsSheet(
      item: item,
      business: business,
      onEdit: onEdit,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final t = context.textTheme;
    final s = ProfileStrings.of(context);
    final isService = item.isService;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              if (onEdit != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onEdit!();
                  },
                )
              else
                const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Header Image or Icon Banner
          if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: AppImage(item.imageUrl!),
              ),
            )
          else
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: colors.border),
              ),
              child: Center(
                child: Icon(
                  isService
                      ? Icons.design_services_rounded
                      : Icons.inventory_2_rounded,
                  size: 48,
                  color: colors.accent,
                ),
              ),
            ),

          const SizedBox(height: AppSpacing.md),

          // Category & Type Badges
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colors.chipSelected,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  item.category.isEmpty ? 'General' : item.category,
                  style: t.labelSmall?.copyWith(color: colors.onChipSelected),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colors.chipBackground,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  isService ? s.isService : s.products,
                  style: t.labelSmall?.copyWith(color: colors.textSecondary),
                ),
              ),
              if (item.negotiable) ...[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    s.negotiable,
                    style: t.labelSmall?.copyWith(color: colors.success),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Title
          Text(
            item.title,
            style: t.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: AppSpacing.xs),

          // Price Label
          Text(
            item.priceLabel,
            style: t.titleLarge?.copyWith(
              color: colors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppSpacing.md),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),

          // Description
          Text(
            s.itemDescription,
            style: t.labelMedium?.copyWith(
              color: colors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.description.isEmpty
                ? 'No description provided.'
                : item.description,
            style: t.bodyMedium,
          ),

          // Business Details
          const SizedBox(height: AppSpacing.md),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          Text(
            s.businessProfile,
            style: t.labelMedium?.copyWith(
              color: colors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.storefront_rounded,
                size: 20,
                color: colors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  business.name,
                  style: t.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          if (business.address.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: colors.textMuted,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    business.address,
                    style: t.bodySmall?.copyWith(color: colors.textMuted),
                  ),
                ),
              ],
            ),
          ],

          // Links section if present
          if (item.purchaseLink.isNotEmpty ||
              item.tiktokLink.isNotEmpty ||
              item.youtubeLink.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Links & Media',
              style: t.labelMedium?.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            if (item.purchaseLink.isNotEmpty)
              _LinkTile(
                icon: Icons.link_rounded,
                label: 'Purchase Link',
                url: item.purchaseLink,
              ),
            if (item.tiktokLink.isNotEmpty)
              _LinkTile(
                icon: Icons.video_library_rounded,
                label: 'TikTok Video',
                url: item.tiktokLink,
              ),
            if (item.youtubeLink.isNotEmpty)
              _LinkTile(
                icon: Icons.play_circle_fill_rounded,
                label: 'YouTube Video',
                url: item.youtubeLink,
              ),
          ],

          const SizedBox(height: AppSpacing.xl),

          // Contact Business Action Button
          PrimaryButton(
            label:
                'Contact Seller (${business.phone.isNotEmpty ? business.phone : business.name})',
            icon: const Icon(Icons.phone_in_talk_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({required this.icon, required this.label, required this.url});

  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final t = context.textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: colors.accent),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: t.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    url,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.labelSmall?.copyWith(
                      color: colors.textMuted,
                      fontSize: 10,
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
