import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/legal_document.dart';

/// Renders one [LegalSection]: numbered heading + justified body paragraph
/// (Figma: heading 14/600, body 14/400 with generous line height).
class LegalSectionView extends StatelessWidget {
  const LegalSectionView({required this.section, super.key});

  final LegalSection section;

  @override
  Widget build(BuildContext context) {
    final language = context.languageCode;
    final textTheme = context.textTheme;
    final heading = section.heading.resolve(language);
    final body = section.body.resolve(language);
    final isSub = section.level > 1;
    return Padding(
      padding: EdgeInsets.only(
        top: isSub ? AppSpacing.sm : AppSpacing.lg,
        left: isSub ? AppSpacing.sm : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: (isSub ? textTheme.titleSmall : textTheme.headlineSmall)
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (body.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              body,
              textAlign: TextAlign.justify,
              style: textTheme.bodyMedium?.copyWith(
                height: 1.55,
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
