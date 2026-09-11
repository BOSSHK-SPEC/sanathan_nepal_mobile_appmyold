import 'package:flutter/material.dart';

/// Motion tokens for the console, and the one place that decides whether
/// motion happens at all.
///
/// Every animated widget in `admin/motion/` asks [enabled] first. A person who
/// has set "reduce motion" in their OS is telling us that parallax and tilt
/// make them ill or make the screen unreadable — Flutter surfaces that as
/// `MediaQuery.disableAnimations`, and honouring it is not optional. The
/// widgets do not degrade to "less motion": they render the final, resting
/// state immediately, so the page is identical in content and only still.
abstract final class Motion {
  const Motion._();

  /// How far a card leans, in radians, at the far corner of its surface.
  /// Small on purpose — past ~0.08 rad text starts to shimmer as it rotates.
  static const double tiltMaxRadians = 0.055;

  /// The perspective divisor in the transform matrix. Smaller = stronger
  /// vanishing point. 0.001 reads as depth; 0.01 reads as a funhouse mirror.
  static const double perspective = 0.0011;

  /// How far a lifted surface travels toward the viewer, in logical pixels.
  static const double hoverLift = 10;

  static const Duration fast = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 620);

  /// The ambient background loop. Long enough that it is never the thing you
  /// notice, which is the whole point of ambient motion.
  static const Duration ambient = Duration(seconds: 18);

  /// Settling curve for anything that moves under a pointer — decelerating,
  /// never bouncy. A moderation queue is not a toy.
  static const Curve settle = Curves.easeOutCubic;
  static const Curve enter = Curves.easeOutQuart;

  /// Whether motion should run at all for this viewer.
  static bool enabled(BuildContext context) {
    final query = MediaQuery.maybeOf(context);
    if (query == null) return true;
    // `accessibleNavigation` means a screen reader is driving: motion that
    // moves focus or repaints under the reader is actively hostile there.
    return !query.disableAnimations && !query.accessibleNavigation;
  }

  /// Stagger for a list that reveals as a group, capped so the twentieth row
  /// does not wait two seconds to appear.
  static Duration stagger(int index, {int cap = 10}) =>
      Duration(milliseconds: 55 * (index > cap ? cap : index));
}
