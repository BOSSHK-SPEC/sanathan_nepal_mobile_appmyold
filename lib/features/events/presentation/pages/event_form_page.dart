import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../cubit/event_form_cubit.dart';
import '../l10n/events_strings.dart';
import '../widgets/event_date_section.dart';
import '../widgets/event_form_sections.dart';
import '../widgets/form_widgets.dart';

/// "New Event" form (Figma "ADD NEW EVENT FORM" 671:1975 / 736:9788).
///
/// Pass [initial] to edit an existing event; an [initial] with an empty id is
/// treated as a template (e.g. "Add reminder" from a festival). Pass
/// [initialDate] to pre-select a day (date converter "Add Event/Reminder").
/// Pops with the saved [Event].
class EventFormPage extends StatelessWidget {
  const EventFormPage({super.key, this.initial, this.initialDate});

  final Event? initial;
  final DateTime? initialDate;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = sl<EventFormCubit>();
      if (initial != null) cubit.initWith(initial!);
      if (initialDate != null) cubit.setDate(initialDate!);
      return cubit;
    },
    child: const _EventFormView(),
  );
}

class _EventFormView extends StatefulWidget {
  const _EventFormView();

  @override
  State<_EventFormView> createState() => _EventFormViewState();
}

class _EventFormViewState extends State<_EventFormView> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _location;
  final _newItem = TextEditingController();

  @override
  void initState() {
    super.initState();
    final s = context.read<EventFormCubit>().state;
    _title = TextEditingController(text: s.title);
    _description = TextEditingController(text: s.description);
    _location = TextEditingController(text: s.location);
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _location.dispose();
    _newItem.dispose();
    super.dispose();
  }

  Future<void> _pickTime(
    BuildContext context,
    EventTime? current,
    ValueChanged<EventTime> onPicked,
  ) async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: current?.hour ?? 9,
        minute: current?.minute ?? 0,
      ),
    );
    if (t != null) onPicked(EventTime(hour: t.hour, minute: t.minute));
  }

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    return BlocConsumer<EventFormCubit, EventFormState>(
      listenWhen: (p, c) => p.saved != c.saved,
      listener: (context, state) {
        switch (state.saved) {
          case Loaded(:final data):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(s.eventSaved)));
            context.pop(data);
          case Failed(:final failure):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          case Idle() || Loading():
            break;
        }
      },
      builder: (context, state) {
        final cubit = context.read<EventFormCubit>();
        final isTodo = state.group == EventGroup.todo;
        return Scaffold(
          appBar: AppTopBar(
            title: state.isEditing ? s.formTitleEdit : s.formTitleNew,
            showBack: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.md,
                AppSpacing.pageGutter,
                AppSpacing.xxl,
              ),
              children: [
                // Create Event / Create To-Do
                Wrap(
                  spacing: AppSpacing.md,
                  children: [
                    AppRadioOption<EventGroup>(
                      value: EventGroup.personal,
                      groupValue: state.group,
                      label: s.createEvent,
                      textStyle: context.textTheme.labelMedium,
                      onChanged: cubit.setGroup,
                    ),
                    AppRadioOption<EventGroup>(
                      value: EventGroup.todo,
                      groupValue: state.group,
                      label: s.createTodo,
                      textStyle: context.textTheme.labelMedium,
                      onChanged: cubit.setGroup,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _title,
                  hint: s.titleHint,
                  onChanged: cubit.setTitle,
                  textInputAction: TextInputAction.next,
                ),
                if (state.titleMissing)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      s.titleRequired,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.lg),
                EventDateSection(
                  state: state,
                  onModeChanged: cubit.setDateMode,
                  onDateChanged: cubit.setDate,
                  onPickTime: () =>
                      _pickTime(context, state.time, cubit.setTime),
                  onClearTime: () => cubit.setTime(null),
                ),
                if (!isTodo) ...[
                  const SizedBox(height: AppSpacing.lg),
                  FormLabel(s.category),
                  CategoryDropdown(
                    value: state.category,
                    onChanged: cubit.setCategory,
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                RepeatSection(
                  state: state,
                  onRepeatsChanged: cubit.setRepeats,
                  onRepeatChanged: cubit.setRepeat,
                ),
                const SizedBox(height: AppSpacing.lg),
                FormLabel(s.addDescription, icon: Icons.add),
                AppTextField(
                  controller: _description,
                  hint: s.descriptionHint,
                  minLines: 2,
                  maxLines: 4,
                  onChanged: cubit.setDescription,
                ),
                const SizedBox(height: AppSpacing.lg),
                ChecklistSection(
                  state: state,
                  controller: _newItem,
                  onAdd: () {
                    cubit.addChecklistItem(_newItem.text);
                    _newItem.clear();
                  },
                  onToggle: cubit.toggleChecklistItem,
                  onRemove: cubit.removeChecklistItem,
                ),
                if (!isTodo) ...[
                  const SizedBox(height: AppSpacing.lg),
                  FormLabel(s.location),
                  AppTextField(
                    controller: _location,
                    hint: s.locationHint,
                    prefix: const Icon(Icons.location_on_outlined, size: 18),
                    onChanged: cubit.setLocation,
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                ReminderSection(
                  state: state,
                  onEnabledChanged: cubit.setReminderEnabled,
                  onDaysChanged: cubit.setReminderDays,
                  onPickTime: () => _pickTime(
                    context,
                    state.reminderTime,
                    cubit.setReminderTime,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        label: s.cancel,
                        height: 36,
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxxl),
                    Expanded(
                      child: PrimaryButton(
                        label: state.isEditing ? s.update : s.create,
                        height: 36,
                        padding: EdgeInsets.zero,
                        isLoading: state.isSaving,
                        onPressed: cubit.submit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
