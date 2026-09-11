import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/weather_bundle.dart';
import '../l10n/weather_strings.dart';
import 'weather_format.dart';
import 'weather_icon.dart';

/// The "now" card: place, big temperature, condition and the condition icon.
///
/// An [AppCard] carrying `headerGradient`, not a full-bleed hero. The gradient
/// hero is this app's chrome for a *profile* — an astrologer, a provider, the
/// signed-in user — where it frames an identity and replaces the app bar.
/// Weather is a data screen like Forex and Panchanga, and those carry an
/// [AppTopBar] and stack cards under it. Borrowing the profile chrome here
/// left the screen with no title, a back button of a different size in a
/// different place, and gutters that did not line up with anything else.
class WeatherHeader extends StatelessWidget {
  const WeatherHeader({required this.bundle, super.key, this.onLocationTap});

  final WeatherBundle bundle;

  /// Re-locates the user. Null hides the affordance.
  final VoidCallback? onLocationTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dv = context.usesDevanagariDigits;
    final s = WeatherStrings.of(context);
    final current = bundle.current;
    final onGradient = colors.onPrimary;
    final t = current.time;
    final timeLabel = WeatherFormat.digits(
      '${s.weekday(t.weekday).substring(0, 3)}, '
      '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}',
      devanagari: dv,
    );

    return AppCard(
      gradient: colors.headerGradient,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WeatherGlyph('map_pin', size: 18, color: onGradient),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  bundle.location.displayName(
                    languageCode: context.languageCode,
                  ),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: onGradient,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onLocationTap != null)
                IconButton(
                  onPressed: onLocationTap,
                  tooltip: s.useMyLocation,
                  icon: Icon(
                    Icons.my_location_outlined,
                    color: onGradient,
                    size: 18,
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          WeatherFormat.digits(
                            '${current.temperature.round()}',
                            devanagari: dv,
                          ),
                          style: context.textTheme.displayLarge?.copyWith(
                            fontSize: 56,
                            height: 1,
                            color: onGradient,
                          ),
                        ),
                        Text(
                          '°',
                          style: context.textTheme.displaySmall?.copyWith(
                            color: onGradient,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      current.condition.label(
                        languageCode: context.languageCode,
                      ),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: onGradient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      timeLabel,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: onGradient.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              WeatherIcon(current.condition, isDay: current.isDay, size: 96),
            ],
          ),
        ],
      ),
    );
  }
}
