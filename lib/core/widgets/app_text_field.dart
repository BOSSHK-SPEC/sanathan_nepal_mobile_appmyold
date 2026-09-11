import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Standard labelled text field used across forms (Figma "Input" component).
///
/// Pass [initialValue] to show a value the user has already saved. It is not
/// the same as [hint]: a hint is grey guidance that disappears the moment
/// someone types, so a saved rate or account number passed as a hint reads as
/// an empty form — and editing it starts from blank rather than from what is
/// stored. Several screens had exactly that, which is why this exists.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.required = false,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.validator,
    this.prefix,
    this.suffix,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
  }) : assert(
         controller == null || initialValue == null,
         'Give a controller or an initialValue, not both — two owners of one '
         'value is how a field starts fighting whoever is typing in it.',
       );

  final TextEditingController? controller;

  /// Seeds an internally-owned controller, and follows later changes while the
  /// field is not focused.
  final String? initialValue;
  final String? label;
  final String? hint;
  final bool required;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? prefix;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  /// Only created when the caller did not bring its own.
  TextEditingController? _owned;

  TextEditingController? get _controller => widget.controller ?? _owned;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null && widget.initialValue != null) {
      _owned = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  void didUpdateWidget(AppTextField old) {
    super.didUpdateWidget(old);
    final next = widget.initialValue;
    if (_owned == null || next == null || old.initialValue == next) return;
    // Never while it has focus: replacing the text under a cursor moves it to
    // the start and eats half-typed input.
    final focused = widget.focusNode?.hasFocus ?? false;
    if (!focused && _owned!.text != next) _owned!.text = next;
  }

  @override
  void dispose() {
    _owned?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: context.textTheme.titleSmall,
              children: [
                if (widget.required)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: colors.error),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.textInputAction,
          style: context.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
          ),
        ),
      ],
    );
  }
}
