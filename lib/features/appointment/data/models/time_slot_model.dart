import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/time_slot.dart';

part 'time_slot_model.freezed.dart';
part 'time_slot_model.g.dart';

/// JSON-serialisable [TimeSlot].
@freezed
abstract class TimeSlotModel with _$TimeSlotModel {
  const TimeSlotModel._();

  const factory TimeSlotModel({
    required String id,
    required int hour,
    @Default(0) int minute,
    @Default(true) bool available,
  }) = _TimeSlotModel;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotModelFromJson(json);

  factory TimeSlotModel.fromEntity(TimeSlot e) => TimeSlotModel(
    id: e.id,
    hour: e.hour,
    minute: e.minute,
    available: e.available,
  );

  TimeSlot toEntity() =>
      TimeSlot(id: id, hour: hour, minute: minute, available: available);
}
