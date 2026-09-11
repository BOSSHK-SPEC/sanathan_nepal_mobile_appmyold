import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/currency.dart';

/// Small rectangular flag for a currency. Uses the bundled PNG flags where
/// available (NP / US / GB) and an emoji flag otherwise.
class CurrencyFlag extends StatelessWidget {
  const CurrencyFlag(this.currency, {super.key, this.width = 20});
  final Currency currency;
  final double width;

  static const Map<String, String> _assets = {
    'NP': AppAssets.flagNepal,
    'US': AppAssets.flagUsa,
    'GB': AppAssets.flagUk,
  };

  @override
  Widget build(BuildContext context) {
    final asset = _assets[currency.countryCode];
    final height = width * 0.62;
    if (asset != null) {
      return AppImage(
        asset,
        width: width,
        height: height,
        fit: BoxFit.contain,
        radius: 2,
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(currency.flagEmoji, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
