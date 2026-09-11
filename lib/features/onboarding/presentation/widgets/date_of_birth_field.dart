import 'package:flutter/material.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../domain/entities/user_profile_draft.dart';
import '../l10n/onboarding_strings.dart';
import 'bs_date_picker_dialog.dart';

/// Date-of-birth input with a traditional / Gregorian toggle (BS / AD in
/// Nepal, Saka / A.D. in India). The value is always stored as Gregorian; the
/// toggle changes both the picker and the display format.
class DateOfBirthField extends StatefulWidget {
  const DateOfBirthField({
    required this.value,
    required this.system,
    required this.onDateChanged,
    required this.onSystemChanged,
    super.key,
    this.errorText,
  });

  final DateTime? value;
  final DateSystem system;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<DateSystem> onSystemChanged;
  final String? errorText;

  /// Formats [date] either in the region's [calendar] ("Falgun 11, 2079" /
  /// "फागुन ११, २०७९", "Chaitra 22, 1945") or as ISO Gregorian
  /// ("1998-05-12"). Digits follow the [languageCode] (Devanagari for ne/hi).
  static String format(
    DateTime? date, {
    required DateSystem system,
    required TraditionalCalendar calendar,
    required String languageCode,
  }) {
    if (date == null) return '';
    final devanagari = TraditionalCalendar.devanagariDigits(languageCode);
    final String raw;
    if (system == DateSystem.bs) {
      final t = calendar.fromGregorian(date);
      final month = calendar.monthName(t.month, languageCode: languageCode);
      raw = '$month ${t.day}, ${t.year}';
    } else {
      final mm = date.month.toString().padLeft(2, '0');
      final dd = date.day.toString().padLeft(2, '0');
      raw = '${date.year}-$mm-$dd';
    }
    return devanagari ? raw.toDevanagariDigits() : raw;
  }

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final _controller = TextEditingController();
  var _mountedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // First call happens before the field is built → safe to set directly;
    // later calls (locale / region change) must not notify mid-build.
    _sync(deferred: _mountedOnce);
    _mountedOnce = true;
  }

  @override
  void didUpdateWidget(DateOfBirthField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value || old.system != widget.system) {
      _sync(deferred: true);
    }
  }

  /// Mirrors the widget value into the read-only text field. When [deferred]
  /// the update is applied after the current frame, because setting the
  /// controller text notifies the enclosing [Form] (setState during build).
  void _sync({required bool deferred}) {
    final text = DateOfBirthField.format(
      widget.value,
      system: widget.system,
      calendar: context.traditionalCalendar,
      languageCode: context.languageCode,
    );
    if (_controller.text == text) return;
    if (!deferred) {
      _controller.text = text;
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.text = text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final value = widget.value;
    final initial = value ?? DateTime(now.year - 25, now.month, now.day);
    final DateTime? picked;
    if (widget.system == DateSystem.bs) {
      picked = await TraditionalDatePickerDialog.show(
        context,
        initial: initial,
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(1920),
        lastDate: now,
      );
    }
    if (picked != null) widget.onDateChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    final system = widget.system;
    final calendarId = context.traditionalCalendar.id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: s.dateOfBirth,
                  style: context.textTheme.titleSmall,
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: colors.error),
                    ),
                  ],
                ),
              ),
            ),
            PillTabs(
              labels: [
                s.traditionalEra(calendarId),
                s.gregorianEra(calendarId),
              ],
              selectedIndex: system == DateSystem.bs ? 0 : 1,
              onChanged: (i) => widget.onSystemChanged(
                i == 0 ? DateSystem.bs : DateSystem.ad,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AppTextField(
          controller: _controller,
          hint: s.pickDate,
          readOnly: true,
          onTap: () => _pick(context),
          suffix: Icon(Icons.calendar_today_outlined, color: colors.iconMuted),
          validator: (_) => widget.value == null ? s.requiredField : null,
        ),
      ],
    );
  }
}
