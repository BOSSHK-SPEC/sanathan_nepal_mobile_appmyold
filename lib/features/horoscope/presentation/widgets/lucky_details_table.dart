import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/lucky_details.dart';
import '../l10n/horoscope_strings.dart';
import 'horoscope_format.dart';

/// Full lucky-details table of the expanded card (Figma "Rashifal details
/// 1st table"): Lucky Number, Colour (swatch), Days, Ruling Planet, Symbol,
/// Element, Lucky Stone (gem swatch + "Shop Now"), Unlucky Stone, Lucky
/// Alphabet, Eventful Years.
class LuckyDetailsTable extends StatelessWidget {
  const LuckyDetailsTable({required this.lucky, super.key, this.onShop});
  final LuckyDetails lucky;
  final VoidCallback? onShop;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final s = HoroscopeStrings.of(context);
    Widget row(String label, Widget value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: value),
        ],
      ),
    );
    Widget text(String v) => Text(v, style: context.textTheme.bodySmall);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: colors.cardGradient,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          row(
            s.luckyNumber,
            text(HoroscopeFormat.list(lucky.numbers, nepali: devanagari)),
          ),
          row(
            s.luckyColor,
            Row(
              children: [
                Icon(Icons.circle, size: 8, color: Color(lucky.colorValue)),
                const SizedBox(width: AppSpacing.xs),
                text(lucky.colorFor(lang)),
              ],
            ),
          ),
          row(s.luckyDays, text(lucky.daysFor(lang).join(', '))),
          row(s.rulingPlanet, text(lucky.rulingPlanetFor(lang))),
          row(s.symbol, text(lucky.symbolFor(lang))),
          row(s.element, text(lucky.elementFor(lang))),
          row(
            s.luckyStone,
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GemSwatch(stone: lucky.luckyStoneEn),
                    const SizedBox(width: AppSpacing.xs),
                    Flexible(child: text(lucky.luckyStoneFor(lang))),
                  ],
                ),
                InkWell(
                  onTap: onShop,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      gradient: colors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      s.shopNow,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          row(s.unluckyStone, text(lucky.unluckyStoneFor(lang))),
          row(s.luckyAlphabet, text(lucky.luckyAlphabet)),
          row(
            s.eventfulYears,
            text(HoroscopeFormat.list(lucky.eventfulYears, nepali: devanagari)),
          ),
        ],
      ),
    );
  }
}

/// 20×20 gem swatch tinted by the (English) stone name – Figma
/// `Rectangle 2194` next to the lucky stone.
class GemSwatch extends StatelessWidget {
  const GemSwatch({required this.stone, super.key, this.size = 20});
  final String stone;
  final double size;

  static Color colorFor(String stone) => switch (stone.toLowerCase()) {
    'red coral' => const Color(0xFFE0523A),
    'ruby' => const Color(0xFFC2185B),
    'emerald' => const Color(0xFF2E9E5B),
    'pearl' => const Color(0xFFE8E4DA),
    'diamond' => const Color(0xFFBEE3F8),
    'yellow sapphire' => const Color(0xFFF2C14E),
    'blue sapphire' => const Color(0xFF2F58C9),
    "cat's eye" => const Color(0xFF9E8B5A),
    'hessonite' || 'gomed' => const Color(0xFFB5651D),
    _ => const Color(0xFF9E9E9E),
  };

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: colorFor(stone),
      borderRadius: BorderRadius.circular(AppRadius.xs),
      border: Border.all(color: context.colors.border),
    ),
    child: Icon(
      Icons.diamond_outlined,
      size: size * 0.7,
      color: Colors.white.withValues(alpha: 0.9),
    ),
  );
}
