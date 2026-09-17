import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// One-time-code entry: [length] boxes backed by a single text field.
///
/// It used to be one `TextField` per box. Each inherited the theme's input
/// height and Mukta's tall line metrics, so typed digits sat off-centre in
/// their boxes; backspace in an empty box did nothing (a field gets no change
/// callback when it is already empty), trapping the caret; and there was no
/// SMS autofill. One field drawn as boxes fixes all three:
/// * each digit is laid out centred in its own box, independent of the field;
/// * backspace always removes the last digit;
/// * SMS autofill ([AutofillHints.oneTimeCode]) and paste fill every box at
///   once, with spaces and dashes stripped and extra digits dropped.
class OtpCodeInput extends StatefulWidget {
  const OtpCodeInput({
    required this.onChanged,
    super.key,
    this.length = 6,
    this.onCompleted,
    this.enabled = true,
    this.hasError = false,
    this.autofocus = true,
  });

  final int length;
  final ValueChanged<String> onChanged;

  /// Called when the last digit is entered.
  final ValueChanged<String>? onCompleted;
  final bool enabled;

  /// Outlines every box in the error colour (e.g. after a wrong code).
  final bool hasError;
  final bool autofocus;

  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> {
  static const double _gap = AppSpacing.sm;
  static const double _maxBox = 48;
  static const double _minBox = 28;

  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_refresh);
  }

  @override
  void dispose() {
    _focus
      ..removeListener(_refresh)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _onChanged(String code) {
    setState(() {});
    widget.onChanged(code);
    if (code.length == widget.length) widget.onCompleted?.call(code);
  }

  /// Digits are only ever appended or removed at the end, like a keypad; a
  /// tap must not drop the caret in the middle of the code.
  void _keepCaretAtEnd() {
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final code = _controller.text;
    final n = widget.length;
    return LayoutBuilder(
      builder: (context, constraints) {
        final box = ((constraints.maxWidth - _gap * (n - 1)) / n).clamp(
          _minBox,
          _maxBox,
        );
        final height = box * 1.15;
        return Opacity(
          opacity: widget.enabled ? 1 : 0.6,
          child: SizedBox(
            height: height,
            child: Stack(
              children: [
                // The boxes are only a picture of the field's value; the
                // field carries the semantics.
                ExcludeSemantics(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < n; i++) ...[
                        if (i > 0) const SizedBox(width: _gap),
                        _OtpBox(
                          key: Key('otp_box_$i'),
                          digit: i < code.length ? code[i] : '',
                          width: box,
                          height: height,
                          isActive:
                              _focus.hasFocus &&
                              widget.enabled &&
                              i == code.length.clamp(0, n - 1),
                          hasError: widget.hasError,
                        ),
                      ],
                    ],
                  ),
                ),
                Positioned.fill(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focus,
                    enabled: widget.enabled,
                    autofocus: widget.autofocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    autocorrect: false,
                    enableSuggestions: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(n),
                    ],
                    // Invisible: the boxes draw the value.
                    showCursor: false,
                    cursorColor: Colors.transparent,
                    style: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 1,
                    ),
                    // Every border spelled out: the app's input theme
                    // fills in any left null, which drew an outline over
                    // the boxes when focused.
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      filled: false,
                      counterText: '',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    onTap: _keepCaretAtEnd,
                    onChanged: _onChanged,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.digit,
    required this.width,
    required this.height,
    required this.isActive,
    required this.hasError,
    super.key,
  });

  final String digit;
  final double width;
  final double height;
  final bool isActive;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final filled = digit.isNotEmpty;
    final borderColor = hasError
        ? colors.error
        : isActive
        ? colors.primary
        : filled
        ? colors.primary.withValues(alpha: 0.5)
        : colors.border;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: filled || isActive ? colors.surface : colors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
          width: isActive || hasError ? 2 : 1.2,
        ),
      ),
      child: filled
          ? Text(
              digit,
              textAlign: TextAlign.center,
              // Height 1 without the font's extra leading above and below,
              // so the glyph sits on the box's centre line.
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: context.textTheme.headlineSmall?.copyWith(
                height: 1,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            )
          : isActive
          ? Container(
              width: 2,
              height: height * 0.4,
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(1),
              ),
            )
          : null,
    );
  }
}
