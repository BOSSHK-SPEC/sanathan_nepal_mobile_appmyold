import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Vertical wheel picker column (Figma "SELECT DATE" popup / date converter):
/// three visible rows, selected row between two hairlines, optional up/down
/// chevrons.
///
/// Shared by the calendar month picker and the date converter.
class WheelPicker extends StatefulWidget {
  const WheelPicker({
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
    this.showArrows = false,
    this.itemExtent = 36,
    this.width = 90,
    this.textStyle,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool showArrows;
  final double itemExtent;
  final double width;
  final TextStyle? textStyle;

  @override
  State<WheelPicker> createState() => _WheelPickerState();
}

class _WheelPickerState extends State<WheelPicker> {
  late final FixedExtentScrollController _controller =
      FixedExtentScrollController(initialItem: widget.selectedIndex);

  @override
  void didUpdateWidget(covariant WheelPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex &&
        _controller.hasClients &&
        _controller.selectedItem != widget.selectedIndex) {
      _controller.jumpToItem(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _step(int delta) {
    final next = (widget.selectedIndex + delta).clamp(
      0,
      widget.items.length - 1,
    );
    if (next == widget.selectedIndex) return;
    _controller.animateToItem(
      next,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style =
        widget.textStyle ??
        context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500);
    final wheelHeight = widget.itemExtent * 3;
    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showArrows)
            _Arrow(icon: Icons.keyboard_arrow_up, onTap: () => _step(-1)),
          SizedBox(
            height: wheelHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: widget.itemExtent,
                  left: 0,
                  right: 0,
                  child: Divider(height: 1, color: colors.border),
                ),
                Positioned(
                  top: widget.itemExtent * 2,
                  left: 0,
                  right: 0,
                  child: Divider(height: 1, color: colors.border),
                ),
                ListWheelScrollView.useDelegate(
                  controller: _controller,
                  itemExtent: widget.itemExtent,
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 5,
                  perspective: 0.002,
                  overAndUnderCenterOpacity: 0.55,
                  onSelectedItemChanged: widget.onChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.items.length,
                    builder: (context, i) => Center(
                      child: Text(
                        widget.items[i],
                        style: style?.copyWith(
                          color: i == widget.selectedIndex
                              ? colors.textPrimary
                              : colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.showArrows)
            _Arrow(icon: Icons.keyboard_arrow_down, onTap: () => _step(1)),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.pill),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Icon(icon, size: 22, color: context.colors.icon),
    ),
  );
}
