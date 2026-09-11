// Null-safe, in-repo port of the `expansion_card` package (v0.1.0), which is
// unmaintained and does not support Dart 3 / null safety.
//
// The public API is intentionally kept identical to the original so existing
// call sites (`margin`, `trailing`, `title`, `children`, `background`,
// `borderRadius`, `backgroundColor`, `initiallyExpanded`,
// `onExpansionChanged`) keep working unchanged.
//
// Original: https://pub.dev/packages/expansion_card (BSD-style licence,
// derived from Flutter's ExpansionTile).

import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

/// A [ListTile]-style header that expands or collapses to reveal or hide
/// [children], optionally drawn over a [background] widget (image/gif).
///
/// When used inside scrolling widgets such as [ListView], give it a unique
/// [PageStorageKey] so its expanded state survives being scrolled off-screen.
class ExpansionCard extends StatefulWidget {
  const ExpansionCard({
    super.key,
    this.leading,
    required this.title,
    this.background,
    this.backgroundColor,
    this.margin = const EdgeInsets.only(top: 30),
    this.borderRadius = 30.0,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.collapsedHeaderColor = Colors.white,
    this.expandedHeaderColor = const Color(0xff60c9df),
  });

  /// Margin applied around the header tile.
  final EdgeInsets margin;

  /// Corner radius used to clip [background].
  final double borderRadius;

  /// Optional widget rendered behind the card (e.g. an image or gif).
  final Widget? background;

  /// A widget to display before the title (typically a [CircleAvatar]).
  final Widget? leading;

  /// The primary content of the header.
  final Widget title;

  /// Called with `true` when the card starts expanding and `false` when it
  /// starts collapsing.
  final ValueChanged<bool>? onExpansionChanged;

  /// Widgets shown when the card is expanded.
  final List<Widget> children;

  /// Colour drawn behind the card while expanded.
  final Color? backgroundColor;

  /// Widget shown instead of the rotating expand arrow.
  final Widget? trailing;

  /// Whether the card starts expanded.
  final bool initiallyExpanded;

  /// Header text/icon colour while collapsed (matches the original package).
  final Color collapsedHeaderColor;

  /// Header text/icon colour while expanded (matches the original package).
  final Color expandedHeaderColor;

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late final AnimationController _controller;
  late final Animation<double> _iconTurns;
  late final Animation<double> _heightFactor;
  late final Animation<Color?> _headerColor;
  late final Animation<Color?> _iconColor;
  late final Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.maybeOf(context)?.readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    _headerColorTween
      ..begin = widget.collapsedHeaderColor
      ..end = widget.expandedHeaderColor;
    _iconColorTween
      ..begin = widget.collapsedHeaderColor
      ..end = widget.expandedHeaderColor;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ExpansionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.collapsedHeaderColor != widget.collapsedHeaderColor ||
        oldWidget.expandedHeaderColor != widget.expandedHeaderColor ||
        oldWidget.backgroundColor != widget.backgroundColor) {
      _headerColorTween
        ..begin = widget.collapsedHeaderColor
        ..end = widget.expandedHeaderColor;
      _iconColorTween
        ..begin = widget.collapsedHeaderColor
        ..end = widget.expandedHeaderColor;
      _backgroundColorTween.end = widget.backgroundColor;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final background = widget.background;
    return Stack(
      children: <Widget>[
        if (background != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Align(
              heightFactor:
                  _heightFactor.value < 0.5 ? 0.5 : _heightFactor.value,
              child: background,
            ),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: _backgroundColor.value ?? Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTileTheme.merge(
                iconColor: _iconColor.value,
                textColor: _headerColor.value,
                child: Padding(
                  padding: widget.margin,
                  child: ListTile(
                    onTap: _handleTap,
                    leading: widget.leading,
                    title: widget.title,
                    trailing: widget.trailing ??
                        RotationTransition(
                          turns: _iconTurns,
                          child: const Icon(Icons.expand_more),
                        ),
                  ),
                ),
              ),
              ClipRect(
                child: Align(
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
