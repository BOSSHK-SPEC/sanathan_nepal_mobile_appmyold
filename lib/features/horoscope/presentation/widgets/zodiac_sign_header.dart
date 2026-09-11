import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../l10n/horoscope_strings.dart';

/// Sign icon + name + name-letters + "अडियो राशिफल ▶" chip
/// (top of every sign card in the Figma listing page).
class ZodiacSignHeader extends StatelessWidget {
  const ZodiacSignHeader({
    required this.sign,
    super.key,
    this.onAudioTap,
    this.iconSize = 56,
    this.isPlaying = false,
    this.showIcon = true,
  });

  final ZodiacSign sign;
  final VoidCallback? onAudioTap;
  final double iconSize;
  final bool isPlaying;

  /// Hide the circular icon (the card renders it in its own left rail).
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final s = HoroscopeStrings.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showIcon) ...[
          ZodiacSignIcon(sign: sign, size: iconSize),
          const SizedBox(width: AppSpacing.md),
        ],
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: sign.displayNameFor(lang),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' (${sign.lettersFor(lang)})',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (onAudioTap != null)
                _AudioChip(
                  label: s.audioRashifal,
                  isPlaying: isPlaying,
                  onTap: onAudioTap!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Circular tinted zodiac icon (legacy PNGs reused from `assets/images/`).
class ZodiacSignIcon extends StatelessWidget {
  const ZodiacSignIcon({required this.sign, super.key, this.size = 56});
  final ZodiacSign sign;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: colors.cardGradient,
        border: Border.all(color: colors.primary.withValues(alpha: 0.35)),
      ),
      child: AppImage(AppAssets.image(sign.asset), fit: BoxFit.contain),
    );
  }
}

class _AudioChip extends StatelessWidget {
  const _AudioChip({
    required this.label,
    required this.isPlaying,
    required this.onTap,
  });
  final String label;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.only(
          left: AppSpacing.sm,
          right: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: colors.border),
          color: colors.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium,
              ),
            ),
            Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              size: 20,
              color: colors.accent,
            ),
          ],
        ),
      ),
    );
  }
}
