import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/horoscope_prediction.dart';
import 'horoscope_media_card.dart';
import 'lucky_details_table.dart';
import 'sign_profile_card.dart';

/// Content of the opened "थप विवरण / More Details" area of a sign card
/// (Figma `Rectangle 2206` block): full lucky-details table with the gem
/// "Shop Now" CTA, the second clip ("Lucky Color, Number and Stone for …")
/// and the about-the-sign card with its tabs.
class HoroscopeDetailsPanel extends StatelessWidget {
  const HoroscopeDetailsPanel({
    required this.prediction,
    super.key,
    this.luckyClipUrl,
    this.onOpenLuckyClip,
    this.onShop,
  });

  final HoroscopePrediction prediction;

  /// The sign's "lucky" clip, when one is published. Null hides the card.
  final String? luckyClipUrl;
  final VoidCallback? onOpenLuckyClip;
  final VoidCallback? onShop;

  @override
  Widget build(BuildContext context) {
    final profile = prediction.profile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LuckyDetailsTable(lucky: prediction.lucky, onShop: onShop),
        if (profile != null) ...[
          const SizedBox(height: AppSpacing.md),
          HoroscopeMediaCard(
            media: profile.luckyMedia,
            onOpen: luckyClipUrl == null ? null : onOpenLuckyClip,
            height: 130,
          ),
          const SizedBox(height: AppSpacing.md),
          SignProfileCard(sign: prediction.sign, profile: profile),
        ],
      ],
    );
  }
}
