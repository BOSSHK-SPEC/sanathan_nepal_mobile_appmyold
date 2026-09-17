import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import 'motion_config.dart';

/// A call to action that leans toward the pointer and presses inward on tap.
///
/// The "magnetism" is a small translation toward the cursor, capped well below
/// the button's own padding — a control that moves far enough to escape the
/// pointer is a control you cannot click, which is the failure mode of most
/// magnetic buttons on the web.
class MagneticButton extends StatefulWidget {
  const MagneticButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.filled = true,
    this.pull = 6,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// Filled for the primary action on a surface; outlined for the rest.
  final bool filled;

  /// Maximum travel toward the pointer, in logical pixels.
  final double pull;

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton> {
  Offset _shift = Offset.zero;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = widget.onPressed != null;
    final animate = Motion.enabled(context) && enabled;

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          cursor: enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          onHover: (event) {
            if (!animate) return;
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            if (size.isEmpty) return;
            setState(() {
              _shift = Offset(
                ((event.localPosition.dx / size.width) * 2 - 1) * widget.pull,
                ((event.localPosition.dy / size.height) * 2 - 1) * widget.pull,
              );
            });
          },
          onExit: (_) => setState(() => _shift = Offset.zero),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: Motion.fast,
              curve: Motion.settle,
              transform: Matrix4.identity()
                ..translateByDouble(_shift.dx, _shift.dy, 0, 1)
                ..scaleByDouble(_pressed ? 0.97 : 1, _pressed ? 0.97 : 1, 1, 1),
              transformAlignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              decoration: BoxDecoration(
                gradient: widget.filled && enabled
                    ? colors.primaryGradient
                    : null,
                color: widget.filled
                    ? (enabled ? null : colors.surfaceVariant)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: widget.filled
                    ? null
                    : Border.all(color: colors.border, width: 1.4),
                boxShadow: widget.filled && enabled
                    ? [
                        BoxShadow(
                          color: colors.primary.withValues(
                            alpha: _pressed ? 0.18 : 0.34,
                          ),
                          blurRadius: _pressed ? 12 : 26,
                          offset: Offset(0, _pressed ? 4 : 12),
                          spreadRadius: -6,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 18,
                      color: widget.filled
                          ? colors.onPrimary
                          : colors.textPrimary,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    widget.label,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: widget.filled
                          ? colors.onPrimary
                          : colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
