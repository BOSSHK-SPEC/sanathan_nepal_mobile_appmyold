import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../app_settings/domain/entities/app_preferences.dart';
import '../../../app_settings/presentation/cubit/app_settings_cubit.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/auth_flow_navigation.dart';
import '../widgets/page_dots.dart';

/// "Select Language/Theme" (Figma 205:13 light · 667:1714 dark).
class LanguageThemePage extends StatelessWidget {
  const LanguageThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    String languageLabel(AppLanguage lang) => switch (lang) {
      AppLanguage.nepali => context.l10n.nepali,
      AppLanguage.english => context.l10n.english,
      AppLanguage.hindi => context.l10n.hindi,
    };
    final l10n = context.l10n;
    final colors = context.colors;
    final prefs = context.watch<AppSettingsCubit>().state;
    final settings = context.read<AppSettingsCubit>();
    final radioStyle = context.textTheme.bodyMedium?.copyWith(fontSize: 15);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(flex: 3),
                    Text(
                      s.welcomeTitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      l10n.selectRegion,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final region in Region.values)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                            ),
                            child: AppRadioOption<Region>(
                              value: region,
                              groupValue: prefs.region,
                              label:
                                  '${region.config.flagEmoji} '
                                  '${region.config.name(context.languageCode)}',
                              textStyle: radioStyle,
                              onChanged: settings.setRegion,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      s.selectLanguage,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final lang in AppLanguage.forRegion(prefs.region))
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                            ),
                            child: AppRadioOption<AppLanguage>(
                              value: lang,
                              groupValue: prefs.language,
                              label: languageLabel(lang),
                              textStyle: radioStyle,
                              onChanged: settings.setLanguage,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Divider(color: colors.divider, height: 1),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    Text(
                      s.selectTheme,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppRadioOption<ThemeMode>(
                          value: ThemeMode.light,
                          groupValue: prefs.themeMode,
                          label: s.lightTheme,
                          textStyle: radioStyle,
                          onChanged: settings.setThemeMode,
                        ),
                        const SizedBox(width: AppSpacing.xxl),
                        AppRadioOption<ThemeMode>(
                          value: ThemeMode.dark,
                          groupValue: prefs.themeMode,
                          label: s.darkTheme,
                          textStyle: radioStyle,
                          onChanged: settings.setThemeMode,
                        ),
                      ],
                    ),
                    const Spacer(flex: 4),
                    const PageDots(count: 4, activeIndex: 0),
                    const SizedBox(height: AppSpacing.xxxl),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 150),
                        child: PrimaryButton(
                          label: l10n.continueLabel,
                          expanded: false,
                          onPressed: () =>
                              AuthFlowNavigation.startSignIn(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xxl),
                        child: TextButton(
                          // Skips choosing a language and theme (the
                          // defaults stay), not signing in: the app is not
                          // usable without an account, so "skip" into it
                          // would only bounce off the sign-in gate.
                          onPressed: () =>
                              AuthFlowNavigation.startSignIn(context),
                          child: Text(
                            l10n.skip,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: colors.accent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
