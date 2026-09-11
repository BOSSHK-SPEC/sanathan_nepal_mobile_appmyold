import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/book_appointment_cubit.dart';
import '../l10n/appointment_strings.dart';
import 'appointment_format.dart';
import 'upload_box.dart';

/// Step 2 – customer + birth details (Figma `757:2802` second state).
class BookingDetailsStep extends StatefulWidget {
  const BookingDetailsStep({super.key});

  @override
  State<BookingDetailsStep> createState() => _BookingDetailsStepState();
}

class _BookingDetailsStepState extends State<BookingDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _country;
  late final TextEditingController _birthPlace;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    final s = context.read<BookAppointmentCubit>().state;
    _name = TextEditingController(text: s.customerName);
    _email = TextEditingController(text: s.email);
    _phone = TextEditingController(text: s.phone);
    _country = TextEditingController(text: s.country);
    _birthPlace = TextEditingController(text: s.birthPlace);
    _notes = TextEditingController(text: s.notes);
  }

  /// Copies state into any field the user has not typed in.
  ///
  /// The profile prefill is asynchronous, so it can land after this step is
  /// already on screen. Without this the fields would sit empty while the
  /// booking carried the prefilled values — the form showing one thing and
  /// submitting another.
  void _seed(BookAppointmentState state) {
    void fill(TextEditingController controller, String value) {
      if (controller.text.isEmpty && value.isNotEmpty) controller.text = value;
    }

    fill(_name, state.customerName);
    fill(_email, state.email);
    fill(_phone, state.phone);
    fill(_country, state.country);
    fill(_birthPlace, state.birthPlace);
    fill(_notes, state.notes);
  }

  @override
  void dispose() {
    for (final c in [_name, _email, _phone, _country, _birthPlace, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookAppointmentCubit>();
    final state = context.watch<BookAppointmentCubit>().state;
    _seed(state);
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final textTheme = context.textTheme;
    final fmt = AppointmentFormat.of(context);
    final phonePrefix = context.regionConfig.phonePrefix;
    String? required(String? v) =>
        (v ?? '').trim().isEmpty ? strings.requiredField : null;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: _name,
                  label: strings.fullName,
                  required: true,
                  validator: required,
                  onChanged: (v) => cubit.updateDetails(customerName: v),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: _email,
                  label: strings.email,
                  keyboardType: TextInputType.emailAddress,
                  // Optional, but if it is filled it has to be an address the
                  // API will take — it rejects anything else, and that
                  // rejection would otherwise arrive at "Confirm booking",
                  // two steps away from this field.
                  validator: (v) {
                    final value = (v ?? '').trim();
                    if (value.isEmpty) return null;
                    return BookAppointmentState.emailPattern.hasMatch(value)
                        ? null
                        : strings.invalidEmail;
                  },
                  onChanged: (v) => cubit.updateDetails(email: v),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: _phone,
                  label: strings.phoneNumber,
                  required: true,
                  keyboardType: TextInputType.phone,
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.sm),
                    child: Text(
                      phonePrefix,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                  validator: (v) => (v ?? '').trim().length < 7
                      ? strings.requiredField
                      : null,
                  onChanged: (v) => cubit.updateDetails(phone: v),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: _country,
                  label: strings.country,
                  onChanged: (v) => cubit.updateDetails(country: v),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            strings.cheenaNote,
            style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          UploadBox(
            label: strings.uploadCheena,
            mediaId: state.cheenaMediaId,
            onChanged: cubit.setCheena,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            strings.noCheenaNote,
            style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: _birthPlace,
                  label: strings.birthPlace,
                  onChanged: (v) => cubit.updateDetails(birthPlace: v),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _PickerField(
                  label: strings.birthDate,
                  value: state.birthDate == null
                      ? '--'
                      : fmt.adIso(state.birthDate!),
                  icon: Icons.calendar_today_outlined,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: state.birthDate ?? DateTime(1995),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) cubit.setBirthDate(picked);
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _PickerField(
                  label: strings.birthTime,
                  value: state.birthTime == null
                      ? '--'
                      : fmt.time(
                          int.parse(state.birthTime!.split(':').first),
                          int.parse(state.birthTime!.split(':').last),
                        ),
                  icon: Icons.access_time,
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 12, minute: 0),
                    );
                    if (picked != null) {
                      cubit.setBirthTime(
                        '${picked.hour.toString().padLeft(2, '0')}:'
                        '${picked.minute.toString().padLeft(2, '0')}',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _notes,
            label: strings.notes,
            maxLines: 2,
            onChanged: (v) => cubit.updateDetails(notes: v),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: strings.back,
                  height: 34,
                  onPressed: cubit.previousStep,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: PrimaryButton(
                  label: strings.next,
                  height: 34,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) cubit.nextStep();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: onTap,
          borderRadius: AppRadius.input,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            decoration: BoxDecoration(
              border: Border.all(color: colors.border),
              borderRadius: AppRadius.input,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall,
                  ),
                ),
                Icon(icon, size: 12, color: colors.accent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
