import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/horoscope_media.dart';
import '../l10n/horoscope_strings.dart';

/// The "राशिफल" clip attached to a reading, in whichever of its two states
/// tells the truth today.
///
/// * **[onOpen] given** — a clip is published. The card opens it where it
///   lives; it does not pretend to play it in place.
/// * **[onOpen] null** — nothing is published yet, and the card says so. It
///   keeps the slot on screen so the feature is visibly on its way, and it
///   offers no control, because a control that does nothing is the thing this
///   replaced: the card used to draw a progress bar and a running clock driven
///   by a one-second timer with no audio behind it.
///
/// Announcing "coming soon" is a promise, so only show this where the clip is
/// genuinely planned.
class HoroscopeMediaCard extends StatelessWidget {
  const HoroscopeMediaCard({
    required this.media,
    super.key,
    this.onOpen,
    this.height = 150,
  });

  final HoroscopeMedia media;

  /// Opens the clip. Null puts the card in its "coming soon" state.
  final VoidCallback? onOpen;

  final double height;

  bool get _hasClip => onOpen != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = HoroscopeStrings.of(context);
    final title = media.titleFor(context.languageCode);
    final heading = title.isEmpty ? s.audioRashifal : title;

    final card = Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Waiting reads as quieter than ready, without going grey and
            // looking like a failure.
            colors.primary.withValues(alpha: _hasClip ? 0.85 : 0.42),
            colors.primaryVariant.withValues(alpha: _hasClip ? 0.85 : 0.42),
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
              AppSpacing.md,
              0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    heading,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: _hasClip
                  ? _PlayButton(colors: colors)
                  : _ComingSoon(label: s.clipComingSoon, colors: colors),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    s.audioRashifal,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.onPrimary.withValues(
                        alpha: _hasClip ? 1 : 0.75,
                      ),
                    ),
                  ),
                ),
                // Only where there is somewhere to go: the icon says the tap
                // leaves the app, and without a clip there is no tap.
                if (_hasClip)
                  Icon(
                    Icons.open_in_new_rounded,
                    size: 16,
                    color: colors.onPrimary,
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!_hasClip) {
      return Semantics(
        label: '$heading — ${s.clipComingSoon}',
        child: ExcludeSemantics(child: card),
      );
    }
    return Semantics(
      button: true,
      label: heading,
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: card,
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.colors});
  final AppColors colors;

  @override
  Widget build(BuildContext context) => Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: colors.onPrimary.withValues(alpha: 0.9),
    ),
    child: Icon(Icons.play_arrow_rounded, color: colors.primary, size: 30),
  );
}

/// The waiting state: an outline where the play button will be, and the words.
///
/// Outlined rather than filled so it does not read as a button someone has
/// failed to press.
class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.label, required this.colors});

  final String label;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final onPrimary = colors.onPrimary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: onPrimary.withValues(alpha: 0.7)),
          ),
          child: Icon(
            Icons.hourglass_empty_rounded,
            color: onPrimary.withValues(alpha: 0.9),
            size: 20,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelMedium?.copyWith(
            color: onPrimary,
            fontWeight: FontWeight.w600,
            letterSpacing: .2,
          ),
        ),
      ],
    );
  }
}
