import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

/// Wire shape of [LocalizedText]: `{ne, en, hi}`.
@freezed
abstract class LocalizedTextModel with _$LocalizedTextModel {
  const LocalizedTextModel._();

  const factory LocalizedTextModel({
    @Default('') String ne,
    @Default('') String en,
    @Default('') String hi,
  }) = _LocalizedTextModel;

  factory LocalizedTextModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizedTextModelFromJson(json);

  factory LocalizedTextModel.fromEntity(LocalizedText e) =>
      LocalizedTextModel(ne: e.ne, en: e.en, hi: e.hi);

  LocalizedText toEntity() => LocalizedText(ne: ne, en: en, hi: hi);
}

/// Wire shape of [EventTime]: `{hour, minute}`.
@freezed
abstract class EventTimeModel with _$EventTimeModel {
  const EventTimeModel._();

  const factory EventTimeModel({@Default(0) int hour, @Default(0) int minute}) =
      _EventTimeModel;

  factory EventTimeModel.fromJson(Map<String, dynamic> json) =>
      _$EventTimeModelFromJson(json);

  factory EventTimeModel.fromEntity(EventTime e) =>
      EventTimeModel(hour: e.hour, minute: e.minute);

  EventTime toEntity() => EventTime(hour: hour, minute: minute);
}

/// Wire shape of [EventReminder]: `{days_before, time}`.
@freezed
abstract class EventReminderModel with _$EventReminderModel {
  const EventReminderModel._();

  const factory EventReminderModel({
    @Default(1) int daysBefore,
    @Default(EventTimeModel()) EventTimeModel time,
  }) = _EventReminderModel;

  factory EventReminderModel.fromJson(Map<String, dynamic> json) =>
      _$EventReminderModelFromJson(json);

  factory EventReminderModel.fromEntity(EventReminder e) => EventReminderModel(
    daysBefore: e.daysBefore,
    time: EventTimeModel.fromEntity(e.time),
  );

  EventReminder toEntity() =>
      EventReminder(daysBefore: daysBefore, time: time.toEntity());
}

/// Wire shape of [ChecklistItem]: `{id, label, is_done}`.
@freezed
abstract class ChecklistItemModel with _$ChecklistItemModel {
  const ChecklistItemModel._();

  const factory ChecklistItemModel({
    required String id,
    required String label,
    @Default(false) bool isDone,
  }) = _ChecklistItemModel;

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemModelFromJson(json);

  factory ChecklistItemModel.fromEntity(ChecklistItem e) =>
      ChecklistItemModel(id: e.id, label: e.label, isDone: e.isDone);

  ChecklistItem toEntity() =>
      ChecklistItem(id: id, label: label, isDone: isDone);
}

/// Serializable [Event] (JSON shape is what a future backend would return:
/// snake_case keys, ISO-8601 `date`, enum names for `category` / `repeat`).
@freezed
abstract class EventModel with _$EventModel {
  const EventModel._();

  const factory EventModel({
    required String id,
    required LocalizedTextModel title,
    required DateTime date,
    @JsonKey(unknownEnumValue: EventCategory.personal)
    required EventCategory category,
    @Default(LocalizedTextModel()) LocalizedTextModel description,
    EventTimeModel? time,
    @Default(false) bool isHoliday,
    @Default(false) bool isVrat,
    @Default(false) bool isImportant,
    String? imagePath,
    @Default(LocalizedTextModel()) LocalizedTextModel location,
    @Default(LocalizedTextModel()) LocalizedTextModel tithi,
    @Default(LocalizedTextModel()) LocalizedTextModel howToCelebrate,
    @Default(LocalizedTextModel()) LocalizedTextModel attractionPlaces,
    String? videoUrl,
    @Default([]) List<ChecklistItemModel> checklist,
    EventReminderModel? reminder,
    @JsonKey(unknownEnumValue: EventRepeat.none)
    @Default(EventRepeat.none)
    EventRepeat repeat,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  factory EventModel.fromEntity(Event e) => EventModel(
    id: e.id,
    title: LocalizedTextModel.fromEntity(e.title),
    date: e.date,
    category: e.category,
    description: LocalizedTextModel.fromEntity(e.description),
    time: e.time == null ? null : EventTimeModel.fromEntity(e.time!),
    isHoliday: e.isHoliday,
    isVrat: e.isVrat,
    isImportant: e.isImportant,
    imagePath: e.imagePath,
    location: LocalizedTextModel.fromEntity(e.location),
    tithi: LocalizedTextModel.fromEntity(e.tithi),
    howToCelebrate: LocalizedTextModel.fromEntity(e.howToCelebrate),
    attractionPlaces: LocalizedTextModel.fromEntity(e.attractionPlaces),
    videoUrl: e.videoUrl,
    checklist: [for (final c in e.checklist) ChecklistItemModel.fromEntity(c)],
    reminder: e.reminder == null
        ? null
        : EventReminderModel.fromEntity(e.reminder!),
    repeat: e.repeat,
  );

  Event toEntity() => Event(
    id: id,
    title: title.toEntity(),
    date: date,
    category: category,
    description: description.toEntity(),
    time: time?.toEntity(),
    isHoliday: isHoliday,
    isVrat: isVrat,
    isImportant: isImportant,
    imagePath: imagePath,
    location: location.toEntity(),
    tithi: tithi.toEntity(),
    howToCelebrate: howToCelebrate.toEntity(),
    attractionPlaces: attractionPlaces.toEntity(),
    videoUrl: videoUrl,
    checklist: [for (final c in checklist) c.toEntity()],
    reminder: reminder?.toEntity(),
    repeat: repeat,
  );
}
