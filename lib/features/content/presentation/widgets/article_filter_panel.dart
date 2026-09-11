import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/article.dart';
import '../l10n/content_strings.dart';
import 'article_tag_chip.dart';

/// Filter card from the Blogs / News lists (Figma `1494:2832`):
/// a 32px tab strip "Categories | Language | Tags" with an underline on the
/// active tab, followed by the options of the active tab – small square
/// radios for categories / language (Figma "Rectangle 2228" 8×8) and a row
/// of filled tag chips ("Group 36152") for tags. The language options come
/// from the active region's `languageCodes`.
class ArticleFilterPanel extends StatefulWidget {
  const ArticleFilterPanel({
    required this.categories,
    required this.tags,
    required this.selectedCategory,
    required this.selectedTag,
    required this.contentLanguageCode,
    required this.onCategory,
    required this.onTag,
    required this.onLanguage,
    super.key,
  });

  final List<ArticleLabel> categories;
  final List<ArticleLabel> tags;
  final String? selectedCategory;
  final String? selectedTag;

  /// Effective content language code (`ne`, `en`, `hi`).
  final String contentLanguageCode;
  final ValueChanged<String?> onCategory;
  final ValueChanged<String?> onTag;
  final ValueChanged<ContentLanguage> onLanguage;

  @override
  State<ArticleFilterPanel> createState() => _ArticleFilterPanelState();
}

class _ArticleFilterPanelState extends State<ArticleFilterPanel> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = ContentStrings.of(context);
    final labels = [strings.categories, strings.language, strings.tags];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Row(
            children: List.generate(labels.length, (i) {
              final selected = i == _tab;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _tab = i),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          labels[i],
                          style: context.textTheme.labelMedium?.copyWith(
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: selected
                                ? colors.textPrimary
                                : colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          height: 1,
                          width: 50,
                          color: selected ? colors.accent : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            0,
          ),
          child: switch (_tab) {
            0 => _OptionWrap(
              options: [
                _Option(null, strings.all),
                for (final c in widget.categories)
                  _Option(c.key, c.label.forLanguage(context.languageCode)),
              ],
              selected: widget.selectedCategory,
              onChanged: widget.onCategory,
            ),
            1 => _OptionWrap(
              options: [
                for (final code in context.regionConfig.languageCodes)
                  _Option(code, ContentLanguage.fromCode(code).nativeName),
              ],
              selected: widget.contentLanguageCode,
              onChanged: (v) => widget.onLanguage(ContentLanguage.fromCode(v)),
              center: true,
            ),
            _ => _TagChipWrap(
              options: [
                _Option(null, strings.all),
                for (final t in widget.tags)
                  _Option(t.key, t.label.forLanguage(context.languageCode)),
              ],
              selected: widget.selectedTag,
              onChanged: widget.onTag,
            ),
          },
        ),
      ],
    );
  }
}

class _Option {
  const _Option(this.key, this.label);
  final String? key;
  final String label;
}

/// Tag filter: filled chip = selected, outlined chip = available.
class _TagChipWrap extends StatelessWidget {
  const _TagChipWrap({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<_Option> options;
  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpacing.sm,
    runSpacing: AppSpacing.xs,
    children: [
      for (final o in options)
        Semantics(
          button: true,
          selected: o.key == selected,
          child: InkWell(
            onTap: () => onChanged(o.key),
            borderRadius: BorderRadius.circular(AppRadius.xs),
            // Chips are 14px tall in Figma – pad the tap target instead.
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2,
                vertical: AppSpacing.xs,
              ),
              child: ArticleTagChip(label: o.label, filled: o.key == selected),
            ),
          ),
        ),
    ],
  );
}

class _OptionWrap extends StatelessWidget {
  const _OptionWrap({
    required this.options,
    required this.selected,
    required this.onChanged,
    this.center = false,
  });

  final List<_Option> options;
  final String? selected;
  final ValueChanged<String?> onChanged;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        for (final o in options)
          InkWell(
            onTap: () => onChanged(o.key),
            borderRadius: BorderRadius.circular(AppRadius.xs),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: o.key == selected
                        ? colors.accent
                        : Colors.transparent,
                    border: Border.all(
                      color: o.key == selected
                          ? colors.accent
                          : colors.textMuted,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  o.label,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    color: o.key == selected
                        ? colors.textPrimary
                        : colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
