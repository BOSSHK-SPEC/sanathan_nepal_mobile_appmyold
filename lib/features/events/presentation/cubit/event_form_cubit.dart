import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../../domain/usecases/create_event.dart';
import '../../domain/usecases/update_event.dart';
import '../../../../core/state/app_cubit.dart';

part 'event_form_cubit.freezed.dart';
part 'event_form_state.dart';

/// Holds and validates the "New Event" form; persists via create/update.
class EventFormCubit extends AppCubit<EventFormState> {
  EventFormCubit({
    required CreateEvent createEvent,
    required UpdateEvent updateEvent,
    DateTime? now,
  }) : _create = createEvent,
       _update = updateEvent,
       super(EventFormState(date: _today(now ?? DateTime.now())));

  final CreateEvent _create;
  final UpdateEvent _update;
  int _itemCounter = 0;

  static DateTime _today(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Pre-fills the form from an existing event. An empty `id` means the
  /// event is only a template (e.g. "Add reminder" for a festival) and a new
  /// event will be created on submit.
  void initWith(Event event) {
    emit(
      EventFormState(
        editingId: event.id.isEmpty ? null : event.id,
        group: event.group == EventGroup.festival
            ? EventGroup.personal
            : event.group,
        category: event.category,
        title: event.title.en.isNotEmpty ? event.title.en : event.title.ne,
        description: event.description.en.isNotEmpty
            ? event.description.en
            : event.description.ne,
        location: event.location.en.isNotEmpty
            ? event.location.en
            : event.location.ne,
        date: _today(event.date),
        time: event.time,
        repeats: event.repeat != EventRepeat.none,
        repeat: event.repeat == EventRepeat.none
            ? EventRepeat.yearly
            : event.repeat,
        checklist: event.checklist,
        reminderEnabled: event.reminder != null,
        reminderDays: event.reminder?.daysBefore ?? 1,
        reminderTime:
            event.reminder?.time ?? const EventTime(hour: 0, minute: 0),
      ),
    );
  }

  void setGroup(EventGroup group) {
    if (group == EventGroup.festival) return;
    emit(
      state.copyWith(
        group: group,
        category: group == EventGroup.todo
            ? EventCategory.todo
            : (state.category.group == EventGroup.personal
                  ? state.category
                  : EventCategory.personal),
      ),
    );
  }

  void setCategory(EventCategory category) =>
      emit(state.copyWith(category: category));

  void setTitle(String value) => emit(
    state.copyWith(
      title: value,
      titleMissing: state.titleMissing && value.trim().isEmpty,
    ),
  );

  void setDescription(String value) => emit(state.copyWith(description: value));
  void setLocation(String value) => emit(state.copyWith(location: value));
  void setDate(DateTime date) => emit(state.copyWith(date: _today(date)));
  void setDateMode(DateDisplayMode mode) =>
      emit(state.copyWith(dateMode: mode));
  void setTime(EventTime? time) => emit(state.copyWith(time: time));
  void setRepeats(bool repeats) => emit(state.copyWith(repeats: repeats));
  void setRepeat(EventRepeat repeat) =>
      emit(state.copyWith(repeat: repeat, repeats: true));
  void setReminderEnabled(bool enabled) =>
      emit(state.copyWith(reminderEnabled: enabled));
  void setReminderDays(int days) =>
      emit(state.copyWith(reminderDays: days < 0 ? 0 : days));
  void setReminderTime(EventTime time) =>
      emit(state.copyWith(reminderTime: time));

  void addChecklistItem(String label) {
    final text = label.trim();
    if (text.isEmpty) return;
    emit(
      state.copyWith(
        checklist: [
          ...state.checklist,
          ChecklistItem(id: 'new-${++_itemCounter}', label: text),
        ],
      ),
    );
  }

  void toggleChecklistItem(String id) => emit(
    state.copyWith(
      checklist: state.checklist
          .map((c) => c.id == id ? c.copyWith(isDone: !c.isDone) : c)
          .toList(),
    ),
  );

  void removeChecklistItem(String id) => emit(
    state.copyWith(
      checklist: state.checklist.where((c) => c.id != id).toList(),
    ),
  );

  /// Validates and persists. [EventFormState.saved] becomes `Loaded` with
  /// the stored event on success.
  Future<void> submit() async {
    if (!state.isValid) {
      emit(state.copyWith(titleMissing: true));
      return;
    }
    if (state.isSaving) return;
    emit(state.copyWith(saved: state.saved.toLoading()));
    final event = Event(
      id: state.editingId ?? '',
      title: LocalizedText.same(state.title.trim()),
      description: LocalizedText.same(state.description.trim()),
      date: state.date,
      time: state.time,
      category: state.category,
      location: LocalizedText.same(state.location.trim()),
      checklist: state.checklist,
      reminder: state.reminderEnabled
          ? EventReminder(
              daysBefore: state.reminderDays,
              time: state.reminderTime,
            )
          : null,
      repeat: state.repeats ? state.repeat : EventRepeat.none,
    );
    final result = state.isEditing
        ? await _update(event)
        : await _create(event);
    emit(
      state.copyWith(
        saved: result.fold(state.saved.toFailed, LoadState.loaded),
      ),
    );
  }
}
