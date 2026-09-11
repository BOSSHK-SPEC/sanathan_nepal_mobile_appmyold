import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Home-page style section title with an accent rule on the right
/// (e.g. "राशिफल ————").
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    super.key,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.pageGutter,
      vertical: AppSpacing.sm,
    ),
    this.showRule = true,
  });

  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final bool showRule;

  /// The trailing ("see all", a chevron, the accent rule) takes at most this
  /// much of the row, so a long label truncates instead of squeezing the
  /// title away.
  static const double _maxTrailingFraction = 0.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final end =
        trailing ??
        (showRule
            ? Container(width: 24, height: 2, color: colors.accent)
            : null);

    Widget header = LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          // Expanded, not Flexible: the title claims every pixel the trailing
          // does not, which is what pins the trailing to the end of the row.
          // Two flexible siblings would split the free space evenly instead
          // and leave the trailing floating mid-row behind a short title.
          //
          // Ellipsised, because a translated title is longer than the English
          // one it was laid out with: "Next Forecast" fits a 360dp phone,
          // "अर्को पूर्वानुमान" beside a trailing widget does not.
          Expanded(
            child: Text(
              title,
              style: context.textTheme.headlineSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (end != null) ...[
            const SizedBox(width: AppSpacing.sm),
            // Given a real bound: a Row hands unbounded width to its non-flex
            // children, so a Text inside the trailing would refuse to wrap or
            // ellipsise without this.
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * _maxTrailingFraction,
              ),
              // Clipped rather than allowed to push the title off-screen:
              // the trailing is a control or a label, never the point of
              // the row.
              child: ClipRect(child: end),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      header = InkWell(onTap: onTap, child: header);
    }

    return Padding(padding: padding, child: header);
  }
}
