import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/user_profile.dart';
import '../l10n/profile_strings.dart';

/// Horoscope sign dropdown (Figma "Horoscope dropdown" 1337:3023) –
/// "Taurus (वृष)" labels in English mode, "वृष" in Nepali mode.
class ZodiacDropdown extends StatelessWidget {
  const ZodiacDropdown({
    required this.value,
    required this.onChanged,
    super.key,
    this.label,
  });

  final ProfileZodiac? value;
  final ValueChanged<ProfileZodiac?> onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final devanagari = context.usesDevanagariDigits;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: context.textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
        ],
        DropdownButtonFormField<ProfileZodiac>(
          initialValue: value,
          isExpanded: true,
          hint: Text(s.selectHoroscope),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: context.colors.iconMuted,
          ),
          dropdownColor: context.colors.surface,
          style: context.textTheme.bodyMedium,
          items: [
            for (final z in ProfileZodiac.values)
              DropdownMenuItem(
                value: z,
                child: Row(
                  children: [
                    AppImage(AppAssets.image(z.asset), width: 18, height: 18),
                    const SizedBox(width: AppSpacing.sm),
                    Text(devanagari ? z.nameNe : z.combinedLabel),
                  ],
                ),
              ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
