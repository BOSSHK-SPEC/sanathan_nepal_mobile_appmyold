import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';
import '../region/business_region_fields.dart';
import 'profile_section_card.dart';

/// "About" tab: tagline, description, location (map placeholder), email,
/// website, phone, working hours and uploaded documents.
class BusinessAboutSection extends StatelessWidget {
  const BusinessAboutSection({required this.business, super.key});
  final BusinessProfile business;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final t = context.textTheme;
    return Column(
      children: [
        ProfileSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (business.tagline.isNotEmpty) ...[
                Text(
                  business.tagline,
                  style: t.titleSmall?.copyWith(color: colors.accent),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              Text(business.description, style: t.bodyMedium),
              const SizedBox(height: AppSpacing.md),
              _Line(
                Icons.location_on_outlined,
                s.officeLocation,
                business.address,
              ),
              if (business.mapLink.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 26, top: 2),
                  child: Text(
                    s.viewOnGoogleMap,
                    style: t.labelSmall?.copyWith(
                      color: colors.accent,
                      decoration: TextDecoration.underline,
                      decorationColor: colors.accent,
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              _MapPlaceholder(),
              const SizedBox(height: AppSpacing.md),
              _Line(Icons.mail_outline_rounded, s.email, business.email),
              const SizedBox(height: AppSpacing.sm),
              _Line(Icons.language, s.website, business.website),
              const SizedBox(height: AppSpacing.sm),
              _Line(
                Icons.call_outlined,
                s.phoneNumber,
                localizeDigits(context, business.phone),
              ),
              const SizedBox(height: AppSpacing.sm),
              _Line(
                Icons.schedule,
                s.workingHours,
                localizeDigits(context, business.workingHours),
              ),
              if (business.taxId.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                _Line(
                  Icons.receipt_long_outlined,
                  BusinessRegionFields.of(
                    context.regionConfig,
                  ).taxIdLabel(context.languageCode),
                  business.taxId,
                ),
              ],
            ],
          ),
        ),
        if (business.documents.isNotEmpty)
          ProfileSectionCard(
            title: s.documents,
            child: Column(
              children: [
                for (final d in business.documents)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 16,
                          color: colors.accent,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: Text(d, style: t.bodySmall)),
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: colors.success,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: colors.accent),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: context.textTheme.bodySmall,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: value.isEmpty ? '—' : value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.shimmer,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Center(
        child: Icon(Icons.map_outlined, size: 32, color: colors.iconMuted),
      ),
    );
  }
}
