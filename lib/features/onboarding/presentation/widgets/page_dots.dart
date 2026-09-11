import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';

/// Onboarding progress indicator (four 10-px dots, active one in accent).
class PageDots extends StatelessWidget {
  const PageDots({required this.count, required this.activeIndex, super.key});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : 7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? colors.accent : colors.border,
          ),
        );
      }),
    );
  }
}
