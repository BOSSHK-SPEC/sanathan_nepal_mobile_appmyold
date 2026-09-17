import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/day_panchanga.dart';

/// The small glyph that marks a vrat day: a full moon for Purnima, an empty
/// one for Amavasya, a diamond for Ekadashi. Shape as well as colour, so it
/// reads without colour vision.
class VratMarker extends StatelessWidget {
  const VratMarker({required this.kind, super.key, this.size = 6, this.color});

  final VratKind kind;
  final double size;

  /// Defaults to the theme accent.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.colors.accent;
    return switch (kind) {
      VratKind.purnima => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      ),
      VratKind.amavasya => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: c, width: math.max(1, size / 6)),
        ),
      ),
      VratKind.ekadashi => SizedBox(
        width: size,
        height: size,
        child: Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            margin: EdgeInsets.all(size * 0.15),
            color: c,
          ),
        ),
      ),
    };
  }
}
