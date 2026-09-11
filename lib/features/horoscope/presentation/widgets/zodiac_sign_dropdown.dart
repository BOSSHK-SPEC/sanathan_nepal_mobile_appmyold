import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../l10n/horoscope_strings.dart';
import 'zodiac_sign_header.dart';

/// "Horoscope dropdown" from Figma – a bordered pill showing the selected
/// sign that opens a menu with all twelve signs.
class ZodiacSignDropdown extends StatelessWidget {
  const ZodiacSignDropdown({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final ZodiacSign selected;
  final ValueChanged<ZodiacSign> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final s = HoroscopeStrings.of(context);
    return PopupMenuButton<ZodiacSign>(
      tooltip: s.selectSign,
      initialValue: selected,
      onSelected: onChanged,
      color: colors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      constraints: const BoxConstraints(maxHeight: 360, minWidth: 200),
      itemBuilder: (context) => [
        for (final sign in ZodiacSign.values)
          PopupMenuItem<ZodiacSign>(
            value: sign,
            height: 40,
            child: Row(
              children: [
                ZodiacSignIcon(sign: sign, size: 28),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    sign.displayNameFor(lang),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: sign == selected ? colors.accent : null,
                      fontWeight: sign == selected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                if (sign == selected)
                  Icon(Icons.check, size: 18, color: colors.accent),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: colors.accent),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          color: colors.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZodiacSignIcon(sign: selected, size: 22),
            const SizedBox(width: AppSpacing.sm),
            Text(
              selected.displayNameFor(lang),
              style: context.textTheme.labelLarge?.copyWith(
                color: colors.accent,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, size: 20, color: colors.accent),
          ],
        ),
      ),
    );
  }
}
