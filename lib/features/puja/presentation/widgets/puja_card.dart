import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/puja_service.dart';
import '../l10n/puja_strings.dart';

/// One puja in the catalogue.
class PujaCard extends StatelessWidget {
  const PujaCard({required this.service, required this.onTap, super.key});

  final PujaService service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;
    final language = Localizations.localeOf(context).languageCode;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    service.name.forLanguage(language),
                    style: context.textTheme.titleSmall,
                  ),
                ),
                if (service.isPopular) ...[
                  const SizedBox(width: AppSpacing.sm),
                  StatusChip(
                    label: s.popular,
                    tone: StatusTone.accent,
                    dense: true,
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              service.summary.forLanguage(language),
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            if (service.templeName != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.temple_hindu_outlined,
                    size: 14,
                    color: colors.textMuted,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      service.templeName!.forLanguage(language),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                MoneyText(
                  service.basePrice,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  s.minutes(service.duration.inMinutes),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const Spacer(),
                // Social proof is the strongest signal in this category, so
                // it sits on the card rather than only on the detail page.
                if (service.bookingsThisMonth > 0)
                  Text(
                    '${service.bookingsThisMonth} ${s.bookingsThisMonth}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.success,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
