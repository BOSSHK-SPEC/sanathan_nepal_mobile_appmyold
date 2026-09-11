import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/sign_profile.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../l10n/horoscope_strings.dart';

/// "मेष राशि को बारेमा / About Aries" card of the expanded sign details
/// (Figma `Group 35717`): about paragraph, text tabs (मेष राशि को पुरुष /
/// व्यक्तित्व / career horoscope), the tab intro and its labelled points
/// (पैसा / स्वास्थ्य / पेशा / सम्बन्ध).
class SignProfileCard extends StatefulWidget {
  const SignProfileCard({required this.sign, required this.profile, super.key});
  final ZodiacSign sign;
  final SignProfile profile;

  @override
  State<SignProfileCard> createState() => _SignProfileCardState();
}

class _SignProfileCardState extends State<SignProfileCard> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final s = HoroscopeStrings.of(context);
    final p = widget.profile;
    final tabs = p.tabs;
    final tab = tabs.isEmpty ? null : tabs[_tab.clamp(0, tabs.length - 1)];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: colors.cardGradient,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.aboutSign(widget.sign.displayNameFor(lang)),
            style: context.textTheme.titleSmall?.copyWith(
              color: colors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(p.aboutFor(lang), style: context.textTheme.bodySmall),
          if (tab != null) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (var i = 0; i < tabs.length; i++)
                  _TextTab(
                    label: tabs[i].titleFor(lang),
                    selected: i == _tab,
                    onTap: () => setState(() => _tab = i),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(tab.introFor(lang), style: context.textTheme.bodySmall),
            for (final point in tab.points) ...[
              const SizedBox(height: AppSpacing.sm),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${point.labelFor(lang)} : ',
                      style: TextStyle(
                        color: colors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: point.textFor(lang)),
                  ],
                ),
                style: context.textTheme.bodySmall,
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Underlined text tab (Figma "tabs/cell/selected" / "tabs/cell/default").
class _TextTab extends StatelessWidget {
  const _TextTab({
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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? colors.accent : colors.divider,
              width: selected ? 2 : 1,
            ),
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: selected ? colors.accent : colors.textSecondary,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
