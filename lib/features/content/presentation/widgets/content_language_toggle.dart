import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/article.dart';

/// Segmented content-language switch from the details page (Figma
/// `1509:3077`, 100×20). The segments come from the active region's
/// `languageCodes` – Nepal: "नेपाली | English", India: "English | हिन्दी".
class ContentLanguageToggle extends StatelessWidget {
  const ContentLanguageToggle({
    required this.languageCode,
    required this.onChanged,
    super.key,
  });

  /// Effective content language code (`ne`, `en`, `hi`).
  final String languageCode;
  final ValueChanged<ContentLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languages = context.regionConfig.languageCodes.map(
      ContentLanguage.fromCode,
    );
    Widget segment(ContentLanguage value) {
      final selected = value.code == languageCode;
      return GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 20,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? colors.chipSelected : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          child: Text(
            value.nativeName,
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: selected ? colors.onChipSelected : colors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [for (final l in languages) segment(l)],
      ),
    );
  }
}
