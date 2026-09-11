import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/event.dart';

/// Figma "CHECKLIST POPUP" – compact list of checkbox rows.
///
/// Stateless: the parent owns the items and receives [onToggle]. Show it via
/// [ChecklistPopup.show].
class ChecklistPopup extends StatelessWidget {
  const ChecklistPopup({
    required this.items,
    required this.onToggle,
    super.key,
    this.title,
  });

  final List<ChecklistItem> items;
  final ValueChanged<String> onToggle;
  final String? title;

  /// Opens the popup as a dialog. [builder] must return a [ChecklistPopup]
  /// (wrap it in a `BlocBuilder` / `BlocProvider.value` to keep it live).
  static Future<void> show(
    BuildContext context, {
    required WidgetBuilder builder,
  }) => showDialog<void>(
    context: context,
    builder: (ctx) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 48),
      child: builder(ctx),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: context.textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
          ],
          for (final item in items)
            InkWell(
              onTap: () => onToggle(item.id),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    _CheckBox(checked: item.isDone),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        item.label,
                        style: context.textTheme.labelMedium?.copyWith(
                          decoration: item.isDone
                              ? TextDecoration.lineThrough
                              : null,
                          color: item.isDone
                              ? colors.textMuted
                              : colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 10×10 square check box in the Figma style.
class _CheckBox extends StatelessWidget {
  const _CheckBox({required this.checked});
  final bool checked;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: checked ? colors.accent : Colors.transparent,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: checked ? colors.accent : colors.textMuted),
      ),
      child: checked
          ? Icon(Icons.check, size: 9, color: colors.onPrimary)
          : null,
    );
  }
}
