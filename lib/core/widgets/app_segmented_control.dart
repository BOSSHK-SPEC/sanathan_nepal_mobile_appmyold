import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Two-to-four way exclusive switch with a sliding thumb.
///
/// Used for North/South chart style, chat/call channel, and day/week/month
/// ranges. For many scrollable options prefer `PillTabs` instead.
class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
    this.height = 38,
    this.icons,
  });

  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final double height;
  final List<IconData>? icons;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final segmentWidth = constraints.maxWidth / segments.length;
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                left: segmentWidth * selectedIndex,
                top: 0,
                bottom: 0,
                width: segmentWidth,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: context.isDark ? 0.3 : 0.08,
                          ),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Fills the pill. An unpositioned Stack child is pinned to the
              // top-left and sized to its own text, so the labels rode above
              // the centre line — and only that strip of each segment was
              // tappable, which read as a tab that would not switch.
              Positioned.fill(
                child: Row(
                  // Stretch, so each segment's InkWell is as tall as the pill.
                  // Centred children shrink-wrap their text, which left the
                  // tap area a thin strip through the middle.
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(segments.length, (i) {
                    final selected = i == selectedIndex;
                    return Expanded(
                      child: Semantics(
                        button: true,
                        selected: selected,
                        child: InkWell(
                          onTap: () => onChanged(i),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (icons != null && i < icons!.length) ...[
                                Icon(
                                  icons![i],
                                  size: 15,
                                  color: selected
                                      ? colors.accent
                                      : colors.textMuted,
                                ),
                                const SizedBox(width: AppSpacing.xs + 2),
                              ],
                              Flexible(
                                child: Text(
                                  segments[i],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.labelLarge?.copyWith(
                                    fontSize: 14,
                                    color: selected
                                        ? colors.textPrimary
                                        : colors.textMuted,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
