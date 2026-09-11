import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/birth_profile.dart';
import '../cubit/chart_form_cubit.dart';
import '../l10n/kundli_strings.dart';

/// Create a birth chart.
class ChartFormPage extends StatelessWidget {
  const ChartFormPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ChartFormCubit>(),
    child: const _ChartFormView(),
  );
}

class _ChartFormView extends StatefulWidget {
  const _ChartFormView();

  @override
  State<_ChartFormView> createState() => _ChartFormViewState();
}

class _ChartFormViewState extends State<_ChartFormView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _place = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _place.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final cubit = context.read<ChartFormCubit>();
    final picked = await showDatePicker(
      context: context,
      initialDate: cubit.state.profile.birthDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) cubit.setDate(picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final cubit = context.read<ChartFormCubit>();
    final current = cubit.state.profile.birthDateTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current.hour, minute: current.minute),
    );
    if (picked != null) cubit.setTime(picked.hour, picked.minute);
  }

  @override
  Widget build(BuildContext context) {
    final s = KundliStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<ChartFormCubit, ChartFormState>(
      listenWhen: (p, n) => p.saving != n.saving,
      listener: (context, state) {
        if (state.saving.isFailed) {
          AppSnack.error(
            context,
            state.saving.errorMessage ?? context.l10n.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ChartFormCubit>();
        final profile = state.profile;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.newChart, showBack: true),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                AppTextField(
                  controller: _name,
                  label: s.name,
                  hint: s.namePlaceholder,
                  required: true,
                  onChanged: cubit.setName,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(s.relation, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final relation in ChartRelation.values)
                      _Chip(
                        label: s.relationName(relation),
                        selected: profile.relation == relation,
                        onTap: () => cubit.setRelation(relation),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(s.gender, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                AppSegmentedControl(
                  segments: [s.male, s.female],
                  selectedIndex: profile.isFemale ? 1 : 0,
                  onChanged: (i) => cubit.setFemale(isFemale: i == 1),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  label: s.dateOfBirth,
                  required: true,
                  readOnly: true,
                  hint: DateFormat.yMMMd(
                    context.languageCode,
                  ).format(profile.birthDateTime),
                  onTap: () => _pickDate(context),
                  suffix: Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: colors.iconMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Opacity(
                  opacity: profile.timeUnknown ? 0.5 : 1,
                  child: AppTextField(
                    label: s.timeOfBirth,
                    required: !profile.timeUnknown,
                    readOnly: true,
                    enabled: !profile.timeUnknown,
                    hint: DateFormat.Hm().format(profile.birthDateTime),
                    onTap: profile.timeUnknown
                        ? null
                        : () => _pickTime(context),
                    suffix: Icon(
                      Icons.schedule_outlined,
                      size: 18,
                      color: colors.iconMuted,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                LabeledToggle(
                  label: s.timeUnknown,
                  value: profile.timeUnknown,
                  onChanged: (v) => cubit.setTimeUnknown(unknown: v),
                ),
                if (profile.timeUnknown)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(
                      s.timeUnknownNote,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _place,
                  label: s.placeOfBirth,
                  hint: s.placePlaceholder,
                  required: true,
                  onChanged: cubit.setPlace,
                ),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: s.saveChart,
                  height: 46,
                  isLoading: state.saving.isLoading,
                  onPressed: state.canSubmit
                      ? () async {
                          final saved = await cubit.submit();
                          if (saved != null && context.mounted) {
                            context.pushReplacement(
                              AppRoutes.kundliChartPath(saved.id),
                            );
                          }
                        }
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.12)
              : colors.chipBackground,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? colors.accent : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: 14,
            color: selected ? colors.accent : colors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
