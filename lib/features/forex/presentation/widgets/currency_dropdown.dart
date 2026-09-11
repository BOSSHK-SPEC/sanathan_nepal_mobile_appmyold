import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/currency.dart';
import 'currency_flag.dart';
import 'forex_format.dart';

/// Bordered pill showing flag + currency name with a chevron
/// (Figma dropdown nodes `1112:2912` / `1112:2969`). Tapping opens a
/// bottom sheet listing [options].
class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
    this.dense = true,
    this.showFlag = true,
    this.hint,
  });

  final Currency? value;
  final List<Currency> options;
  final ValueChanged<Currency> onChanged;
  final bool dense;
  final bool showFlag;

  /// Shown when [value] is null.
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final label =
        value?.displayName(
          languageCode: context.languageCode,
          withUnit: false,
        ) ??
        hint ??
        '';
    return InkWell(
      onTap: () => _open(context),
      borderRadius: BorderRadius.circular(AppRadius.xs),
      child: Container(
        height: dense ? 26 : 40,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showFlag && value != null) ...[
              CurrencyFlag(value!, width: dense ? 16 : 22),
              const SizedBox(width: AppSpacing.sm),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    (dense
                            ? context.textTheme.labelSmall
                            : context.textTheme.bodyMedium)
                        ?.copyWith(
                          color: value == null
                              ? colors.textMuted
                              : colors.textPrimary,
                        ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.keyboard_arrow_down,
              size: dense ? 14 : 20,
              color: colors.iconMuted,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _open(BuildContext context) async {
    final picked = await showModalBottomSheet<Currency>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: context.colors.surface,
      builder: (_) => CurrencyPickerSheet(options: options, selected: value),
    );
    if (picked != null) onChanged(picked);
  }
}

/// Scrollable list of currencies with flags (used by [CurrencyDropdown]).
class CurrencyPickerSheet extends StatelessWidget {
  const CurrencyPickerSheet({required this.options, super.key, this.selected});
  final List<Currency> options;
  final Currency? selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dv = context.usesDevanagariDigits;
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      itemCount: options.length,
      separatorBuilder: (_, _) => Divider(height: 1, color: colors.divider),
      itemBuilder: (context, i) {
        final c = options[i];
        final isSelected = c.iso3 == selected?.iso3;
        return ListTile(
          dense: true,
          leading: CurrencyFlag(c, width: 26),
          title: Text(
            ForexFormat.digits(
              c.displayName(languageCode: context.languageCode),
              devanagari: dv,
            ),
          ),
          subtitle: Text(c.iso3, style: context.textTheme.labelSmall),
          trailing: isSelected
              ? Icon(Icons.check_circle, color: colors.accent, size: 20)
              : null,
          onTap: () => Navigator.of(context).pop(c),
        );
      },
    );
  }
}
