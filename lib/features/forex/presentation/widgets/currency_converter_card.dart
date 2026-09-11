import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/conversion_result.dart';
import '../../domain/entities/currency.dart';
import '../l10n/forex_strings.dart';
import 'currency_dropdown.dart';
import 'forex_format.dart';

/// "मुद्रा रूपान्तरण" card: from-currency dropdown + amount, to-currency
/// dropdown + buy / sell results (Figma "CURRENCY CONVERTER" 320×78).
class CurrencyConverterCard extends StatefulWidget {
  const CurrencyConverterCard({
    required this.from,
    required this.to,
    required this.amount,
    required this.options,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onAmountChanged,
    super.key,
    this.conversion,
    this.onSwap,
    this.local = Currency.npr,
  });

  final Currency from;
  final Currency to;

  /// Local (quote) currency offered as a conversion target (NPR / INR).
  final Currency local;
  final double amount;
  final ConversionResult? conversion;
  final List<Currency> options;
  final ValueChanged<Currency> onFromChanged;
  final ValueChanged<Currency> onToChanged;
  final ValueChanged<double> onAmountChanged;
  final VoidCallback? onSwap;

  @override
  State<CurrencyConverterCard> createState() => _CurrencyConverterCardState();
}

class _CurrencyConverterCardState extends State<CurrencyConverterCard> {
  static const double _colWidth = 56;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _text(widget.amount));
  }

  @override
  void didUpdateWidget(covariant CurrencyConverterCard old) {
    super.didUpdateWidget(old);
    final parsed = double.tryParse(_controller.text);
    if (parsed != widget.amount) {
      _controller.text = _text(widget.amount);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static String _text(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ForexStrings.of(context);
    final dv = context.usesDevanagariDigits;
    final c = widget.conversion;
    final small = context.textTheme.labelSmall?.copyWith(fontSize: 10);
    final result = context.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: colors.textPrimary,
    );

    Widget underlined(Widget child) => Container(
      width: _colWidth,
      padding: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.textMuted)),
      ),
      alignment: Alignment.center,
      child: child,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.conversion,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: CurrencyDropdown(
                  value: widget.from,
                  options: widget.options,
                  onChanged: widget.onFromChanged,
                ),
              ),
              const SizedBox(width: _colWidth + AppSpacing.md * 2),
              underlined(
                TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  style: result,
                  decoration: const InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    filled: false,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (v) =>
                      widget.onAmountChanged(double.tryParse(v) ?? 0),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                width: _colWidth,
                child: Center(child: Text(s.buy, style: small)),
              ),
              const SizedBox(width: AppSpacing.md),
              SizedBox(
                width: _colWidth,
                child: Center(child: Text(s.sell, style: small)),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: CurrencyDropdown(
                  value: widget.to,
                  options: [widget.local, ...widget.options],
                  onChanged: widget.onToChanged,
                ),
              ),
              if (widget.onSwap != null)
                IconButton(
                  onPressed: widget.onSwap,
                  icon: Icon(
                    Icons.swap_vert,
                    size: 16,
                    color: colors.iconMuted,
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              const SizedBox(width: AppSpacing.md),
              underlined(
                Text(
                  c == null
                      ? '—'
                      : ForexFormat.rate(c.buyResult, devanagari: dv),
                  style: result,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              underlined(
                Text(
                  c == null
                      ? '—'
                      : ForexFormat.rate(c.sellResult, devanagari: dv),
                  style: result,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
