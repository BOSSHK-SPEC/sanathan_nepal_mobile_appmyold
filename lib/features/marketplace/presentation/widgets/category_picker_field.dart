import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/category.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/category_icons.dart';
import 'marketplace_dialogs.dart';

/// Read-only "Category" field that opens a bottom sheet of categories.
/// Each row carries an edit icon opening the "Product Category edit" popup
/// ([showCategoryEditDialog]); the new name is reported via [onRenamed].
class CategoryPickerField extends StatelessWidget {
  const CategoryPickerField({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    required this.onRenamed,
    super.key,
    this.names = const {},
    this.errorText,
  });

  final List<Category> categories;
  final String? selectedId;
  final ValueChanged<String> onSelected;
  final void Function(String id, String name) onRenamed;

  /// Display-name overrides keyed by category id.
  final Map<String, String> names;
  final String? errorText;

  String _name(BuildContext context, Category c) =>
      names[c.id] ?? c.name(languageCode: context.languageCode);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final selected = categories.where((c) => c.id == selectedId).firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: s.category,
            style: context.textTheme.titleSmall,
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: colors.error),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: () => _open(context),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: s.selectCategory,
              errorText: errorText,
              prefixIcon: selected == null
                  ? null
                  : Icon(
                      CategoryIcons.forCategory(selected.id, iconName: selected.iconName),
                      color: colors.accent,
                      size: 18,
                    ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: colors.iconMuted,
              ),
            ),
            isEmpty: selected == null,
            child: selected == null
                ? null
                : Text(
                    _name(context, selected),
                    style: context.textTheme.bodyMedium,
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _open(BuildContext context) async {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: colors.surface,
      showDragHandle: true,
      builder: (sheet) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: AppSpacing.page,
              child: Text(
                s.selectCategory,
                style: context.textTheme.titleMedium,
              ),
            ),
            for (final c in categories)
              ListTile(
                dense: true,
                leading: Icon(
                  CategoryIcons.forCategory(c.id, iconName: c.iconName),
                  color: c.id == selectedId ? colors.accent : colors.icon,
                ),
                title: Text(_name(context, c)),
                selected: c.id == selectedId,
                selectedColor: colors.accent,
                trailing: IconButton(
                  tooltip: s.editCategory,
                  icon: Icon(Icons.edit_outlined, size: 18, color: colors.icon),
                  onPressed: () async {
                    final name = await showCategoryEditDialog(
                      sheet,
                      currentName: _name(context, c),
                    );
                    if (name != null && name.isNotEmpty) onRenamed(c.id, name);
                  },
                ),
                onTap: () {
                  onSelected(c.id);
                  Navigator.of(sheet).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}
