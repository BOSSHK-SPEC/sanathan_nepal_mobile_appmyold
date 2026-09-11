import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

/// Row with a label on the left and a compact switch on the right.
class LabeledToggle extends StatelessWidget {
  const LabeledToggle({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
    this.dense = true,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool dense;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: context.textTheme.bodyMedium),
      Transform.scale(
        scale: dense ? 0.8 : 1,
        child: Switch(value: value, onChanged: onChanged),
      ),
    ],
  );
}
