import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// A tile grid that shows [rowsPerPage] × [columns] tiles per page and lets
/// the user swipe horizontally to the next page (Figma quick-menu: two rows
/// per page with pill page indicators underneath).
///
/// Generic over the tile model so it stays free of menu-specific types.
class PagedTileGrid<T> extends StatefulWidget {
  const PagedTileGrid({
    required this.items,
    required this.tileBuilder,
    super.key,
    this.columns = 4,
    this.rowsPerPage = 2,
    this.rowHeight = 86,
    this.rowSpacing = AppSpacing.md,
    this.indicatorPadding = const EdgeInsets.only(top: AppSpacing.md),
  }) : assert(columns > 0 && rowsPerPage > 0);

  final List<T> items;
  final Widget Function(BuildContext context, T item) tileBuilder;
  final int columns;
  final int rowsPerPage;

  /// Height of one tile row (icon box + label).
  final double rowHeight;
  final double rowSpacing;
  final EdgeInsets indicatorPadding;

  int get perPage => columns * rowsPerPage;
  int get pageCount =>
      items.isEmpty ? 0 : (items.length + perPage - 1) ~/ perPage;

  @override
  State<PagedTileGrid<T>> createState() => _PagedTileGridState<T>();
}

class _PagedTileGridState<T> extends State<PagedTileGrid<T>> {
  late final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = widget.pageCount;
    if (pages == 0) return const SizedBox.shrink();
    final rows = widget.rowsPerPage;
    final height = rows * widget.rowHeight + (rows - 1) * widget.rowSpacing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: _controller,
            itemCount: pages,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, pageIndex) {
              final start = pageIndex * widget.perPage;
              final end = (start + widget.perPage).clamp(
                0,
                widget.items.length,
              );
              final pageItems = widget.items.sublist(start, end);
              return _TilePage<T>(
                items: pageItems,
                columns: widget.columns,
                rows: rows,
                rowHeight: widget.rowHeight,
                rowSpacing: widget.rowSpacing,
                tileBuilder: widget.tileBuilder,
              );
            },
          ),
        ),
        if (pages > 1)
          Padding(
            padding: widget.indicatorPadding,
            child: PagePillIndicator(
              count: pages,
              current: _page,
              onTap: (i) => _controller.animateToPage(
                i,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
              ),
            ),
          ),
      ],
    );
  }
}

class _TilePage<T> extends StatelessWidget {
  const _TilePage({
    required this.items,
    required this.columns,
    required this.rows,
    required this.rowHeight,
    required this.rowSpacing,
    required this.tileBuilder,
  });

  final List<T> items;
  final int columns;
  final int rows;
  final double rowHeight;
  final double rowSpacing;
  final Widget Function(BuildContext context, T item) tileBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var r = 0; r < rows; r++) ...[
          if (r > 0) SizedBox(height: rowSpacing),
          SizedBox(
            height: rowHeight,
            child: Row(
              children: [
                for (var c = 0; c < columns; c++)
                  Expanded(
                    child: r * columns + c < items.length
                        ? tileBuilder(context, items[r * columns + c])
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Pill-shaped page indicator (active = accent, inactive = muted), matching
/// the Figma quick-menu dots. Tapping a pill jumps to that page.
class PagePillIndicator extends StatelessWidget {
  const PagePillIndicator({
    required this.count,
    required this.current,
    super.key,
    this.onTap,
    this.width = 56,
    this.height = 4,
    this.gap = AppSpacing.xl,
  });

  final int count;
  final int current;
  final ValueChanged<int>? onTap;
  final double width;
  final double height;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      label: 'Page ${current + 1} of $count',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) SizedBox(width: gap),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap == null ? null : () => onTap!(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: i == current
                      ? colors.accent
                      : colors.textMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
