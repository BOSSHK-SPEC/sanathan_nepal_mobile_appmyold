import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/calendar_event.dart';

part 'calendar_event_model.freezed.dart';
part 'calendar_event_model.g.dart';

/// Serialisable [CalendarEvent] (future backend contract: JSON, snake_case
/// keys, `date` as `YYYY-MM-DD`).
@freezed
abstract class CalendarEventModel with _$CalendarEventModel {
  const CalendarEventModel._();

  const factory CalendarEventModel({
    required String id,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required DateTime date,
    @Default('') String titleNe,
    @Default('') String titleEn,
    @Default('') String titleHi,
    @Default('') String descriptionNe,
    @Default('') String descriptionEn,
    @Default('') String descriptionHi,
    @Default('') String tithiNe,
    @Default('') String tithiEn,
    @Default(false) bool isHoliday,
    String? imageUrl,
  }) = _CalendarEventModel;

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);

  factory CalendarEventModel.fromEntity(CalendarEvent e) => CalendarEventModel(
    id: e.id,
    date: e.date,
    titleNe: e.titleNe,
    titleEn: e.titleEn,
    titleHi: e.titleHi,
    descriptionNe: e.descriptionNe,
    descriptionEn: e.descriptionEn,
    descriptionHi: e.descriptionHi,
    tithiNe: e.tithiNe,
    tithiEn: e.tithiEn,
    isHoliday: e.isHoliday,
    imageUrl: e.imageUrl,
  );

  CalendarEvent toEntity() => CalendarEvent(
    id: id,
    date: date,
    titleNe: titleNe,
    titleEn: titleEn,
    titleHi: titleHi,
    descriptionNe: descriptionNe,
    descriptionEn: descriptionEn,
    descriptionHi: descriptionHi,
    tithiNe: tithiNe,
    tithiEn: tithiEn,
    isHoliday: isHoliday,
    imageUrl: imageUrl,
  );
}

DateTime _dateFromJson(String value) => DateTime.parse(value);

String _dateToJson(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';
