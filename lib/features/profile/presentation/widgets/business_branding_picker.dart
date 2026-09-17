import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';

/// Banner and logo on the business form, shown as they will appear on the
/// listing: the wide banner with the round logo overlapping its corner.
///
/// Presentation only. The page picks and uploads, because it is the page that
/// knows the bucket and where the result goes — the same split as
/// [UploadPlaceholder] and the profile's avatar picker.
class BusinessBrandingPicker extends StatelessWidget {
  const BusinessBrandingPicker({
    required this.logoUrl,
    required this.coverUrl,
    required this.onPick,
    required this.onRemove,
    super.key,
  });

  final String? logoUrl;
  final String? coverUrl;
  final ValueChanged<BusinessImageSlot> onPick;
  final ValueChanged<BusinessImageSlot> onRemove;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final cover = coverUrl;
    final logo = logoUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.businessBanner, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Room for the overhanging logo inside the Stack, so tapping the
            // logo reaches it (taps outside a widget's bounds are dropped).
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Semantics(
                button: true,
                label: cover == null ? s.addBanner : s.changeBanner,
                child: GestureDetector(
                  onTap: () => onPick(BusinessImageSlot.cover),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: cover == null ? colors.cardGradient : null,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: colors.border),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: cover == null
                        ? Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 32,
                              color: colors.iconMuted,
                            ),
                          )
                        : AppImage(cover, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.md,
              bottom: 0,
              child: Semantics(
                button: true,
                label: logo == null ? s.addLogo : s.changeLogo,
                child: GestureDetector(
                  onTap: () => onPick(BusinessImageSlot.logo),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.surface,
                      border: Border.all(color: colors.background, width: 3),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: logo == null
                        ? Icon(Icons.add_a_photo_outlined, color: colors.accent)
                        : AppImage(logo),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: 0,
          children: [
            TextButton.icon(
              onPressed: () => onPick(BusinessImageSlot.logo),
              icon: const Icon(Icons.photo_camera_outlined, size: 18),
              label: Text(logo == null ? s.addLogo : s.changeLogo),
            ),
            TextButton.icon(
              onPressed: () => onPick(BusinessImageSlot.cover),
              icon: const Icon(Icons.panorama_outlined, size: 18),
              label: Text(cover == null ? s.addBanner : s.changeBanner),
            ),
            if (logo != null)
              TextButton(
                onPressed: () => onRemove(BusinessImageSlot.logo),
                child: Text(s.removeLogo),
              ),
            if (cover != null)
              TextButton(
                onPressed: () => onRemove(BusinessImageSlot.cover),
                child: Text(s.removeBanner),
              ),
          ],
        ),
        Text(
          s.brandingHint,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
          ),
        ),
      ],
    );
  }
}
