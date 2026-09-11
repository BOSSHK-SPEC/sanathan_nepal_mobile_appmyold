import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/current_weather.dart';
import '../l10n/weather_strings.dart';
import 'weather_format.dart';
import 'weather_icon.dart';

/// Rounded strip with rain-chance / humidity / wind chips
/// (Figma "Intro Stats Chips").
class WeatherStatsChips extends StatelessWidget {
  const WeatherStatsChips({required this.current, super.key});
  final CurrentWeather current;

  @override
  Widget build(BuildContext context) {
    final dv = context.usesDevanagariDigits;
    final s = WeatherStrings.of(context);
    // An AppCard rather than a bare tinted box: it sits in a column of cards,
    // and a flat strip among them read as an unstyled leftover.
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          // Each stat takes a third of the row rather than its natural width,
          // so a longer translation tightens its own cell instead of pushing
          // the row past the card.
          Expanded(
            child: _Chip(
              glyph: 'rain_chance',
              value: WeatherFormat.percent(
                current.precipitationProbability,
                devanagari: dv,
              ),
              semantics: s.rain,
            ),
          ),
          Expanded(
            child: _Chip(
              glyph: 'humidity',
              value: WeatherFormat.percent(current.humidity, devanagari: dv),
              semantics: s.humidity,
            ),
          ),
          Expanded(
            child: _Chip(
              glyph: 'wind',
              value: WeatherFormat.digits(
                '${current.windSpeed.round()} ${s.kmh}',
                devanagari: dv,
              ),
              semantics: s.wind,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.glyph,
    required this.value,
    required this.semantics,
  });
  final String glyph;
  final String value;
  final String semantics;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semantics,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherGlyph(glyph, size: 20, color: context.colors.icon),
        const SizedBox(width: AppSpacing.xs),
        // Flexible: three stats share one row, and the Nepali and Hindi
        // labels are wider than the English ones this was sized against —
        // on a 360dp phone the row overflowed rather than tightening.
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
