import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/horoscope_prediction.dart';
import '../l10n/horoscope_strings.dart';
import 'horoscope_details_panel.dart';
import 'horoscope_media_card.dart';
import 'lucky_details_card.dart';
import 'zodiac_sign_header.dart';

/// One sign block of the horoscope listing page (Figma `MESH` / `Group
/// 357xx`): left rail = sign icon + ♥ + share, right = name/letters with the
/// "अडियो राशिफल" chip, prediction text and player; below = the lucky-details
/// strip whose "थप विवरण" opens [HoroscopeDetailsPanel].
///
/// Purely presentational – expansion / like / playback state comes from the
/// cubit through the constructor.
class HoroscopeSignCard extends StatelessWidget {
  const HoroscopeSignCard({
    required this.prediction,
    super.key,
    this.clipUrl,
    this.onOpenClip,
    this.showLucky = true,
    this.highlighted = false,
    this.expanded = false,
    this.onToggleDetails,
    this.liked = false,
    this.onLike,
    this.onShare,
    this.luckyClipUrl,
    this.onOpenLuckyClip,
    this.onShop,
  });

  final HoroscopePrediction prediction;

  /// The reading's clip, when one is published. Null renders no player.
  final String? clipUrl;
  final VoidCallback? onOpenClip;
  final bool showLucky;
  final bool highlighted;

  /// "More Details" area open.
  final bool expanded;
  final VoidCallback? onToggleDetails;
  final bool liked;
  final VoidCallback? onLike;
  final VoidCallback? onShare;

  /// The second ("lucky details") clip, when published.
  final String? luckyClipUrl;
  final VoidCallback? onOpenLuckyClip;
  final VoidCallback? onShop;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final s = HoroscopeStrings.of(context);
    final p = prediction;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      gradient: colors.cardGradient,
      elevated: false,
      border: Border.all(
        color: highlighted ? colors.accent : colors.border,
        width: highlighted ? 1.4 : 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ZodiacSignIcon(sign: p.sign),
                  const SizedBox(height: AppSpacing.sm),
                  _RailButton(
                    icon: liked ? Icons.favorite : Icons.favorite_border,
                    color: liked ? colors.error : colors.iconMuted,
                    label: s.like,
                    onTap: onLike,
                  ),
                  _RailButton(
                    icon: Icons.share_outlined,
                    color: colors.iconMuted,
                    label: s.share,
                    onTap: onShare,
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZodiacSignHeader(
                      sign: p.sign,
                      onAudioTap: clipUrl == null ? null : onOpenClip,
                      showIcon: false,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(p.textFor(lang), style: context.textTheme.bodyMedium),
                    const SizedBox(height: AppSpacing.md),
                    HoroscopeMediaCard(
                      media: p.media,
                      onOpen: clipUrl == null ? null : onOpenClip,
                      height: 130,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showLucky) ...[
            const SizedBox(height: AppSpacing.md),
            LuckyDetailsCard(
              lucky: p.lucky,
              expanded: expanded,
              onToggle: onToggleDetails ?? () {},
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: expanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.md),
                      child: HoroscopeDetailsPanel(
                        prediction: p,
                        luckyClipUrl: luckyClipUrl,
                        onOpenLuckyClip: onOpenLuckyClip,
                        onShop: onShop,
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ],
      ),
    );
  }
}

/// Small icon button of the left rail (♥ / share) with a semantics label.
class _RailButton extends StatelessWidget {
  const _RailButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: label,
    onPressed: onTap,
    icon: Icon(icon, size: 18, color: color),
    visualDensity: VisualDensity.compact,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(minWidth: 32, minHeight: 28),
  );
}
