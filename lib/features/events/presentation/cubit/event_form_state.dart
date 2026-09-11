part of 'event_form_cubit.dart';

/// Which calendar the date field is displayed in.
enum DateDisplayMode { bs, ad, tithi }

/// Form state for creating / editing an event or to-do.
@freezed
abstract class EventFormState with _$EventFormState {
  const EventFormState._();

  const factory EventFormState({
    required DateTime date,

    /// `null` when creating a new event.
    String? editingId,
    @Default(EventGroup.personal) EventGroup group,
    @Default(EventCategory.personal) EventCategory category,
    @Default('') String title,
    @Default('') String description,
    @Default('') String location,
    @Default(DateDisplayMode.bs) DateDisplayMode dateMode,
    EventTime? time,
    @Default(false) bool repeats,
    @Default(EventRepeat.yearly) EventRepeat repeat,
    @Default([]) List<ChecklistItem> checklist,
    @Default(true) bool reminderEnabled,
    @Default(1) int reminderDays,
    @Default(EventTime(hour: 0, minute: 0)) EventTime reminderTime,

    /// `true` after a submit attempt with an empty title.
    @Default(false) bool titleMissing,

    /// Persisting the form: `loading` while saving, `loaded` with the stored
    /// event once done, `failed` when create / update failed.
    @Default(LoadState.idle()) LoadState<Event> saved,
  }) = _EventFormState;

  bool get isEditing => editingId != null;
  bool get isValid => title.trim().isNotEmpty;
  bool get isSaving => saved.isLoading;
}
