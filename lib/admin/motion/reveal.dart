import 'package:flutter/material.dart';

import 'motion_config.dart';

/// Reveals its child once, on first build, with depth rather than a plain fade.
///
/// The child starts slightly *behind* the viewport — scaled down and pushed
/// down — and settles forward. That reads as a card arriving in space, where a
/// pure opacity fade reads as a screenshot loading. The distinction is what
/// makes a whole page feel built rather than assembled.
///
/// [delay] is what turns a grid into a sequence. Use `Motion.stagger(index)`
/// so a long list still finishes revealing in well under a second.
class Reveal extends StatefulWidget {
  const Reveal({
    required this.child,
    super.key,
    this.delay = Duration.zero,
    this.offset = 26,
    this.scaleFrom = 0.97,
    this.duration = Motion.slow,
  });

  final Widget child;
  final Duration delay;

  /// How far below its resting place the child starts, in logical pixels.
  final double offset;

  /// Starting scale. Below ~0.92 the text inside visibly reflows as it grows.
  final double scaleFrom;
  final Duration duration;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    if (widget.delay > Duration.zero) {
      await Future<void>.delayed(widget.delay);
      // The page can be popped while a staggered child is still waiting its
      // turn; driving a disposed controller throws.
      if (!mounted) return;
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Eased scale for progress [t], from `scaleFrom` to 1.
  double _scale(double t) => widget.scaleFrom + (1 - widget.scaleFrom) * t;

  @override
  Widget build(BuildContext context) {
    // Reduced motion: render the resting state, immediately and completely.
    if (!Motion.enabled(context)) return widget.child;

    final curved = CurvedAnimation(parent: _controller, curve: Motion.enter);

    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) {
        final t = curved.value;
        return Opacity(
          opacity: t,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, Motion.perspective)
              ..translateByDouble(0, (1 - t) * widget.offset, 0, 1)
              ..scaleByDouble(_scale(t), _scale(t), 1, 1),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Reveals a list of children in sequence.
///
/// A convenience over wrapping each child by hand, so the stagger cap is
/// applied consistently and one screen cannot accidentally take three seconds
/// to finish appearing.
class RevealGroup extends StatelessWidget {
  const RevealGroup({
    required this.children,
    super.key,
    this.spacing = 0,
    this.axis = Axis.vertical,
  });

  final List<Widget> children;
  final double spacing;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final revealed = <Widget>[
      for (final (index, child) in children.indexed) ...[
        if (index > 0 && spacing > 0)
          SizedBox(
            width: axis == Axis.horizontal ? spacing : null,
            height: axis == Axis.vertical ? spacing : null,
          ),
        Reveal(delay: Motion.stagger(index), child: child),
      ],
    ];

    return axis == Axis.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: revealed,
          )
        : Row(children: revealed);
  }
}
