import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../motion/motion.dart';

/// A titled surface for one block of console content.
///
/// Tilt is off by default here. It is right for the landing page, where a card
/// is a thing to look at; on a queue full of numbers a surface that leans under
/// the cursor makes the text swim while you read it. Depth on this screen comes
/// from the shadow and the border, not from movement.
class ConsolePanel extends StatelessWidget {
  const ConsolePanel({
    required this.child,
    super.key,
    this.title,
    this.trailing,
    this.padding = const EdgeInsets.all(20),
    this.tilt = false,
  });

  final Widget child;
  final String? title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final bool tilt;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  title!,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 16),
        ],
        child,
      ],
    );

    if (tilt) {
      return TiltCard(padding: padding, glare: false, child: content);
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDark ? 0.35 : 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
            spreadRadius: -12,
          ),
        ],
      ),
      child: content,
    );
  }
}

/// A row of panels that wraps instead of overflowing.
///
/// `Wrap` rather than `Row` on purpose: the console is used at widths from a
/// phone to an ultrawide, and a fixed row of four metric cards is unreadable at
/// both ends.
class PanelGrid extends StatelessWidget {
  const PanelGrid({
    required this.children,
    super.key,
    this.minTileWidth = 240,
    this.spacing = 16,
  });

  final List<Widget> children;
  final double minTileWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        // At least one per row, however narrow the viewport gets.
        final columns = (available / (minTileWidth + spacing)).floor().clamp(
          1,
          6,
        );
        final tileWidth = (available - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final (index, child) in children.indexed)
              SizedBox(
                width: tileWidth,
                child: Reveal(delay: Motion.stagger(index), child: child),
              ),
          ],
        );
      },
    );
  }
}
