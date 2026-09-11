import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/horoscope_media.dart';
import 'horoscope_format.dart';

/// Video/audio player card ("Aries Rashifal - Baishak,2079", big play
/// button, progress bar and `5:07 / 15:28` read-out). Playback is driven by
/// the cubit – this widget is purely presentational.
class HoroscopeMediaCard extends StatelessWidget {
  const HoroscopeMediaCard({
    required this.media,
    required this.position,
    required this.isPlaying,
    required this.onToggle,
    super.key,
    this.onSeek,
    this.height = 150,
  });

  final HoroscopeMedia media;
  final Duration position;
  final bool isPlaying;
  final VoidCallback onToggle;
  final ValueChanged<double>? onSeek;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final total = media.duration.inSeconds;
    final fraction = total == 0 ? 0.0 : position.inSeconds / total;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary.withValues(alpha: 0.85),
            colors.primaryVariant.withValues(alpha: 0.85),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.sm,
              0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    media.titleFor(lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(Icons.info_outline, size: 16, color: colors.onPrimary),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Semantics(
                button: true,
                label: isPlaying ? 'Pause' : 'Play',
                child: InkWell(
                  onTap: onToggle,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.onPrimary.withValues(alpha: 0.9),
                    ),
                    child: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: colors.primary,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _ProgressBar(fraction: fraction, onSeek: onSeek),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onToggle,
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 18,
                    color: colors.onPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '${HoroscopeFormat.clock(position, nepali: devanagari)} / '
                    '${HoroscopeFormat.clock(media.duration, nepali: devanagari)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.onPrimary,
                    ),
                  ),
                ),
                Icon(Icons.fullscreen, size: 18, color: colors.onPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.fraction, this.onSeek});
  final double fraction;
  final ValueChanged<double>? onSeek;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: onSeek == null
            ? null
            : (d) => onSeek!(d.localPosition.dx / constraints.maxWidth),
        child: SizedBox(
          height: 14,
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: 3,
                  color: colors.onPrimary.withValues(alpha: 0.35),
                ),
                FractionallySizedBox(
                  widthFactor: fraction.clamp(0.0, 1.0),
                  child: Container(height: 3, color: colors.onPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
