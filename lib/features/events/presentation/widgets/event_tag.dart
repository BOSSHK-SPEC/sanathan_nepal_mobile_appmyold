import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Tiny rounded label used for "हिन्दु चाड" / "सार्वजनिक विदा" tags.
class EventTag extends StatelessWidget {
  const EventTag({
    required this.label,
    super.key,
    this.color,
    this.filled = false,
  });

  final String label;

  /// Border / text colour (defaults to accent).
  final Color? color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.colors.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: filled ? c : c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: c, width: 0.8),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.labelSmall?.copyWith(
          color: filled ? context.colors.onChipSelected : c,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
      ),
    );
  }
}
