import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Rounded search field (Figma "Frame 3847": 🔍 Search...).
class MarketplaceSearchBar extends StatelessWidget {
  const MarketplaceSearchBar({
    required this.hint,
    super.key,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.autofocus = false,
    this.margin = AppSpacing.page,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: margin,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: colors.border),
        ),
        child: TextField(
          controller: controller,
          autofocus: autofocus,
          textInputAction: TextInputAction.search,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          style: context.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
            prefixIcon: Icon(Icons.search, size: 20, color: colors.iconMuted),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }
}
