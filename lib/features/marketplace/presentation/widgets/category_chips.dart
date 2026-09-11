import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/category.dart';
import '../l10n/marketplace_strings.dart';

/// Row of "☐ All ☐ Jobs ☐ Automobiles …" selectors + a "View All" pill.
class CategoryChips extends StatelessWidget {
  const CategoryChips({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    required this.onViewAll,
    super.key,
  });

  final List<Category> categories;
  final String selectedId;
  final ValueChanged<String> onSelected;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final lang = context.languageCode;
    final items = [Category.all, ...categories];
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.pageGutter),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final c in items) ...[
                    _CategoryChip(
                      label: c.id == Category.all.id
                          ? s.all
                          : c.name(languageCode: lang),
                      selected: c.id == selectedId,
                      onTap: () => onSelected(c.id),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: GestureDetector(
              onTap: onViewAll,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: colors.chipSelected,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      size: 10,
                      color: colors.onChipSelected,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      s.viewAll,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.onChipSelected,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: selected ? colors.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: selected ? colors.accent : colors.textMuted,
              ),
            ),
            child: selected
                ? Icon(Icons.check, size: 8, color: colors.onChipSelected)
                : null,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: selected ? colors.textPrimary : colors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
