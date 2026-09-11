import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/weather_bundle.dart';
import '../l10n/weather_strings.dart';
import 'weather_format.dart';
import 'weather_icon.dart';

/// 2×2 grid with sunrise / sunset / humidity / wind for today.
class WeatherDetailsCard extends StatelessWidget {
  const WeatherDetailsCard({required this.bundle, super.key});
  final WeatherBundle bundle;

  @override
  Widget build(BuildContext context) {
    final s = WeatherStrings.of(context);
    final dv = context.usesDevanagariDigits;
    final today = bundle.today;
    final current = bundle.current;
    String hm(DateTime? t) => t == null
        ? '—'
        : WeatherFormat.digits(
            '${t.hour.toString().padLeft(2, '0')}:'
            '${t.minute.toString().padLeft(2, '0')}',
            devanagari: dv,
          );
    final tiles = <_Detail>[
      _Detail('sunrise', s.sunrise, hm(today?.sunrise)),
      _Detail('sunset', s.sunset, hm(today?.sunset)),
      _Detail(
        'humidity',
        s.humidity,
        WeatherFormat.percent(current.humidity, devanagari: dv),
      ),
      _Detail(
        'wind',
        s.wind,
        WeatherFormat.digits(
          '${current.windSpeed.round()} ${s.kmh}',
          devanagari: dv,
        ),
      ),
    ];
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [for (final t in tiles.take(2)) Expanded(child: t)]),
          const SizedBox(height: AppSpacing.md),
          Row(children: [for (final t in tiles.skip(2)) Expanded(child: t)]),
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail(this.glyph, this.label, this.value);
  final String glyph;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          alignment: Alignment.center,
          child: WeatherGlyph(glyph, size: 20, color: colors.accent),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
