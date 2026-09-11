import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot.freezed.dart';

/// A bookable time-of-day slot.
@freezed
abstract class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    required String id,

    /// 0–23.
    required int hour,
    required int minute,
    @Default(true) bool available,
  }) = _TimeSlot;
}
