import 'package:flutter/material.dart';

import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/weather_condition.dart';

/// Renders the coloured SVG icon for a [WeatherCondition].
class WeatherIcon extends StatelessWidget {
  const WeatherIcon(
    this.condition, {
    super.key,
    this.isDay = true,
    this.size = 40,
  });

  final WeatherCondition condition;
  final bool isDay;
  final double size;

  @override
  Widget build(BuildContext context) => AppImage(
    condition.iconAsset(isDay: isDay),
    width: size,
    height: size,
    fit: BoxFit.contain,
  );
}

/// Monochrome glyph icons (wind, humidity, pin …) tinted with [color].
class WeatherGlyph extends StatelessWidget {
  const WeatherGlyph(this.name, {super.key, this.size = 20, this.color});

  /// File name without extension inside `assets/icons/weather/`.
  final String name;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => AppImage(
    'assets/icons/weather/$name.svg',
    width: size,
    height: size,
    fit: BoxFit.contain,
    color: color ?? IconTheme.of(context).color,
  );
}
