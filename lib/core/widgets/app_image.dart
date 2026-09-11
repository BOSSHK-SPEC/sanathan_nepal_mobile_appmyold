import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../extensions/context_extensions.dart';

/// Renders a bundled asset (PNG/SVG) or a network URL with a themed
/// placeholder. Keeps asset handling in one place.
class AppImage extends StatelessWidget {
  const AppImage(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.radius = 0,
  });

  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final double radius;

  bool get _isNetwork => source.startsWith('http');
  bool get _isSvg => source.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_isSvg) {
      child = _isNetwork
          ? SvgPicture.network(
              source,
              width: width,
              height: height,
              fit: fit,
              colorFilter: color == null
                  ? null
                  : ColorFilter.mode(color!, BlendMode.srcIn),
            )
          : SvgPicture.asset(
              source,
              width: width,
              height: height,
              fit: fit,
              colorFilter: color == null
                  ? null
                  : ColorFilter.mode(color!, BlendMode.srcIn),
            );
    } else if (_isNetwork) {
      child = Image.network(
        source,
        width: width,
        height: height,
        fit: fit,
        color: color,
        errorBuilder: (_, _, _) => _placeholder(context),
        loadingBuilder: (_, w, p) => p == null ? w : _placeholder(context),
      );
    } else {
      child = Image.asset(
        source,
        width: width,
        height: height,
        fit: fit,
        color: color,
        errorBuilder: (_, _, _) => _placeholder(context),
      );
    }
    if (radius > 0) {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      );
    }
    return child;
  }

  Widget _placeholder(BuildContext context) => Container(
    width: width,
    height: height,
    color: context.colors.shimmer,
    child: Icon(Icons.image_outlined, color: context.colors.iconMuted),
  );
}
