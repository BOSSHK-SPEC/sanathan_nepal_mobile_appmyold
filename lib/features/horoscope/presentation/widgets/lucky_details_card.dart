import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/lucky_details.dart';
import '../l10n/horoscope_strings.dart';
import 'horoscope_format.dart';

/// "भाग्यशाली विवरण / Lucky Details" strip
/// (`6, 9 | ● Red | Tuesdays… | Red Coral | [More Details]`) – Figma
/// `Group 35712`. The expanded content is rendered by the caller
/// (see `HoroscopeDetailsPanel`); this widget only owns the toggle.
class LuckyDetailsCard extends StatelessWidget {
  const LuckyDetailsCard({
    required this.lucky,
    required this.expanded,
    required this.onToggle,
    super.key,
  });

  final LuckyDetails lucky;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final s = HoroscopeStrings.of(context);
    final small = context.textTheme.labelSmall?.copyWith(
      color: colors.textPrimary,
      fontSize: 11,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: colors.accent,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.xs),
            ),
          ),
          child: Text(
            s.luckyDetails,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.onPrimary,
              fontSize: 11,
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.accent),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(AppRadius.xs),
                      bottomLeft: Radius.circular(AppRadius.xs),
                    ),
                    color: colors.surfaceVariant,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          HoroscopeFormat.list(
                            lucky.numbers,
                            nepali: devanagari,
                          ),
                          style: small,
                        ),
                        _Divider(color: colors.border),
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: Color(lucky.colorValue),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(lucky.colorFor(lang), style: small),
                        _Divider(color: colors.border),
                        Text(lucky.daysFor(lang).join(', '), style: small),
                        _Divider(color: colors.border),
                        Text(lucky.luckyStoneFor(lang), style: small),
                      ],
                    ),
                  ),
                ),
              ),
              Semantics(
                button: true,
                label: expanded ? s.lessDetails : s.moreDetails,
                child: InkWell(
                  onTap: onToggle,
                  child: Container(
                    width: 74,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: colors.primaryGradient,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(AppRadius.xs),
                      ),
                    ),
                    child: Text(
                      expanded ? s.lessDetails : s.moreDetails,
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.onPrimary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 12,
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    color: color,
  );
}
