import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import 'motion_config.dart';

/// A surface that leans toward the pointer in real perspective.
///
/// The effect is three things layered, and it falls apart if any one is
/// missing:
///
///  1. **Rotation** about X and Y, proportional to how far the pointer is from
///     the centre. Rotation alone looks like a sticker being bent.
///  2. **A perspective divisor** in the matrix (`..setEntry(3, 2, …)`), which
///     is what makes the near edge grow and the far edge shrink. Without it
///     the card shears rather than turns.
///  3. **A shadow that moves opposite the lean**, because a real surface
///     casting a light source's shadow does. A static shadow under a tilting
///     card is the tell that reads as "cheap CSS".
///
/// Touch devices get the lift on press but no tilt: there is no hover, and
/// tilting on tap fights the tap.
class TiltCard extends StatefulWidget {
  const TiltCard({
    required this.child,
    super.key,
    this.onTap,
    this.borderRadius = 20,
    this.maxTilt = Motion.tiltMaxRadians,
    this.lift = Motion.hoverLift,
    this.glare = true,
    this.padding = const EdgeInsets.all(20),
    this.background,
    this.borderColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final double maxTilt;
  final double lift;

  /// A soft specular sheen that tracks the pointer. Off for dense surfaces
  /// like tables, where it competes with the text.
  final bool glare;
  final EdgeInsetsGeometry padding;
  final Color? background;
  final Color? borderColor;

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  /// Pointer position in "unit" space: (-1, -1) top-left … (1, 1) bottom-right.
  Offset _pointer = Offset.zero;
  bool _hovering = false;

  void _updatePointer(PointerEvent event, Size size) {
    if (size.isEmpty) return;
    setState(() {
      _pointer = Offset(
        (event.localPosition.dx / size.width) * 2 - 1,
        (event.localPosition.dy / size.height) * 2 - 1,
      );
    });
  }

  void _reset() => setState(() {
    _hovering = false;
    _pointer = Offset.zero;
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final animate = Motion.enabled(context);
    final radius = BorderRadius.circular(widget.borderRadius);

    // Clamped so a pointer that leaves the box mid-drag cannot send the card
    // past its limit.
    final tiltX = animate ? (-_pointer.dy).clamp(-1.0, 1.0) * widget.maxTilt : 0.0;
    final tiltY = animate ? _pointer.dx.clamp(-1.0, 1.0) * widget.maxTilt : 0.0;
    final lifted = animate && _hovering;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return MouseRegion(
          cursor: widget.onTap == null
              ? MouseCursor.defer
              : SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovering = true),
          onHover: (event) => _updatePointer(event, size),
          onExit: (_) => _reset(),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: Motion.fast,
              curve: Motion.settle,
              transform: Matrix4.identity()
                ..setEntry(3, 2, Motion.perspective)
                ..rotateX(tiltX)
                ..rotateY(tiltY)
                ..translateByDouble(0, lifted ? -widget.lift : 0, 0, 1),
              transformAlignment: Alignment.center,
              padding: widget.padding,
              decoration: BoxDecoration(
                color: widget.background ?? colors.surface,
                borderRadius: radius,
                border: Border.all(
                  color: lifted
                      ? (widget.borderColor ?? colors.primary).withValues(alpha: 0.45)
                      : (widget.borderColor ?? colors.border),
                ),
                boxShadow: [
                  BoxShadow(
                    // Offset opposite the lean, so the light source stays put
                    // while the card turns under it.
                    offset: Offset(-tiltY * 90, tiltX * 90 + (lifted ? 14 : 6)),
                    blurRadius: lifted ? 34 : 16,
                    spreadRadius: lifted ? -4 : -6,
                    color: Colors.black.withValues(
                      alpha: context.isDark ? 0.55 : 0.14,
                    ),
                  ),
                ],
              ),
              child: widget.glare && animate
                  ? _Glare(pointer: _pointer, visible: _hovering, radius: radius, child: widget.child)
                  : widget.child,
            ),
          ),
        );
      },
    );
  }
}

/// The specular highlight: a soft radial that follows the pointer.
///
/// Drawn *above* the content with a low alpha rather than behind it, because a
/// real sheen sits on the glass, not under it. Kept subtle enough that body
/// text underneath stays at an accessible contrast.
class _Glare extends StatelessWidget {
  const _Glare({
    required this.pointer,
    required this.visible,
    required this.radius,
    required this.child,
  });

  final Offset pointer;
  final bool visible;
  final BorderRadius radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: Motion.fast,
              opacity: visible ? 1 : 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  gradient: RadialGradient(
                    center: Alignment(pointer.dx, pointer.dy),
                    radius: 0.9,
                    colors: [
                      Colors.white.withValues(alpha: 0.13),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
