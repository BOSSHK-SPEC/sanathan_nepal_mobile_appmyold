import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../app_settings/domain/entities/app_preferences.dart';
import '../../../app_settings/presentation/cubit/app_settings_cubit.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';

/// "Preferences" card: Region (Nepal/India), Language and Theme (Dark/Light)
/// radios wired to [AppSettingsCubit], plus the Favourite heading.
class PreferencesCard extends StatelessWidget {
  const PreferencesCard({super.key, this.favouriteChild});

  /// Rendered below the "Favourite" row (product grid).
  final Widget? favouriteChild;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final cubit = context.watch<AppSettingsCubit>();
    final prefs = cubit.state;
    final radioStyle = context.textTheme.bodyMedium;

    return ProfileSectionCard(
      title: s.preferences,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PrefRow(
            icon: Icons.public_outlined,
            label: context.l10n.region,
            child: Row(
              children: [
                for (final region in Region.values) ...[
                  AppRadioOption<Region>(
                    value: region,
                    groupValue: prefs.region,
                    label:
                        '${region.config.flagEmoji} '
                        '${region.config.name(context.languageCode)}',
                    textStyle: radioStyle,
                    onChanged: cubit.setRegion,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PrefRow(
            icon: Icons.translate_rounded,
            label: s.language,
            child: Row(
              children: [
                for (final lang in AppLanguage.forRegion(prefs.region)) ...[
                  AppRadioOption<AppLanguage>(
                    value: lang,
                    groupValue: prefs.language,
                    label: switch (lang) {
                      AppLanguage.english => s.english,
                      AppLanguage.nepali => s.nepali,
                      AppLanguage.hindi => context.l10n.hindi,
                    },
                    textStyle: radioStyle,
                    onChanged: cubit.setLanguage,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PrefRow(
            icon: Icons.dark_mode_outlined,
            label: s.theme,
            child: Row(
              children: [
                AppRadioOption<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: prefs.themeMode,
                  label: s.dark,
                  textStyle: radioStyle,
                  onChanged: cubit.setThemeMode,
                ),
                const SizedBox(width: AppSpacing.sm),
                AppRadioOption<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: prefs.themeMode,
                  label: s.light,
                  textStyle: radioStyle,
                  onChanged: cubit.setThemeMode,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PrefRow(
            icon: Icons.favorite_border_rounded,
            label: s.favourite,
            child: Text(
              s.yourFavouriteProducts,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.accent,
                decoration: TextDecoration.underline,
                decorationColor: colors.accent,
              ),
            ),
          ),
          if (favouriteChild != null) ...[
            const SizedBox(height: AppSpacing.md),
            favouriteChild!,
          ],
        ],
      ),
    );
  }
}

class _PrefRow extends StatelessWidget {
  const _PrefRow({
    required this.icon,
    required this.label,
    required this.child,
  });
  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 18, color: context.colors.icon),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        flex: 2,
        child: Text(label, style: context.textTheme.titleSmall),
      ),
      Expanded(
        flex: 4,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: child,
        ),
      ),
    ],
  );
}
