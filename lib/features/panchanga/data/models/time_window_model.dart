import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/time_window.dart';

part 'time_window_model.freezed.dart';
part 'time_window_model.g.dart';

/// Wire shape of [TimeWindow] (enums travel by name; unknown values fall
/// back to `choghadiya` / `neutral`).
@freezed
abstract class TimeWindowModel with _$TimeWindowModel {
  const TimeWindowModel._();

  const factory TimeWindowModel({
    @JsonKey(unknownEnumValue: TimeWindowKind.choghadiya)
    @Default(TimeWindowKind.choghadiya)
    TimeWindowKind kind,
    required DateTime start,
    required DateTime end,
    @Default('') String nameNe,
    @Default('') String nameEn,
    @JsonKey(unknownEnumValue: ChoghadiyaQuality.neutral)
    @Default(ChoghadiyaQuality.neutral)
    ChoghadiyaQuality quality,
  }) = _TimeWindowModel;

  factory TimeWindowModel.fromJson(Map<String, dynamic> json) =>
      _$TimeWindowModelFromJson(json);

  factory TimeWindowModel.fromEntity(TimeWindow e) => TimeWindowModel(
    kind: e.kind,
    start: e.start,
    end: e.end,
    nameNe: e.nameNe,
    nameEn: e.nameEn,
    quality: e.quality,
  );

  TimeWindow toEntity() => TimeWindow(
    kind: kind,
    start: start,
    end: end,
    nameNe: nameNe,
    nameEn: nameEn,
    quality: quality,
  );
}
