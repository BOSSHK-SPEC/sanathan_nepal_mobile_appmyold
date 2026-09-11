import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/report_product.dart';

/// Rounded tile carrying the icon for a report kind.
///
/// A shared widget rather than a switch at each call site, so the catalogue,
/// the library and the delivery screen cannot drift apart on what a
/// "marriage report" looks like.
class ReportKindIcon extends StatelessWidget {
  const ReportKindIcon({required this.kind, super.key, this.size = 44});

  final ReportKind kind;
  final double size;

  IconData get _icon => switch (kind) {
    ReportKind.life => Icons.auto_stories_outlined,
    ReportKind.career => Icons.work_outline_rounded,
    ReportKind.marriage => Icons.favorite_outline_rounded,
    ReportKind.yearAhead => Icons.calendar_month_outlined,
    ReportKind.matchMaking => Icons.join_inner_rounded,
    ReportKind.remedies => Icons.spa_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Icon(_icon, size: size * 0.45, color: colors.accent),
    );
  }
}
