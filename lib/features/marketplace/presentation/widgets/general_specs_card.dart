import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';

/// "General" card: location, negotiable, website, posted, expiry + specs.
class GeneralSpecsCard extends StatelessWidget {
  const GeneralSpecsCard({required this.product, super.key, this.now});

  final Product product;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final rows = <MapEntry<String, String>>[
      MapEntry(
        s.location,
        product.locationFor(languageCode: context.languageCode),
      ),
      MapEntry(
        '${s.negotiable}:',
        product.negotiable ? s.negotiable : s.notNegotiable,
      ),
      if (product.websiteLink != null)
        MapEntry(s.websiteLink, product.websiteLink!),
      MapEntry(
        s.adsPosted,
        MarketplaceFormat.timeAgo(context, product.postedAt, now: now),
      ),
      if (product.expiresAt != null)
        MapEntry(
          s.adsExpiry,
          MarketplaceFormat.isoDate(context, product.expiresAt!),
        ),
      for (final e in product.specs.entries)
        MapEntry('${e.key}:', MarketplaceFormat.digits(context, e.value)),
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.general,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Divider(height: AppSpacing.lg, color: colors.divider),
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      r.key,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      r.value,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
