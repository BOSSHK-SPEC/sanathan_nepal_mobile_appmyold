import 'package:freezed_annotation/freezed_annotation.dart';

part 'astrologer_slot.freezed.dart';

/// A bookable half hour with an astrologer.
///
/// Separate from [TimeSlot], which carries only an hour and a minute because a
/// astrologer's booking wizard picks a date first and then a time within it. An
/// astrologer's slots are published as a rolling two-week calendar generated
/// from the weekly hours they keep in the console, so each one has to carry the
/// day it falls on.
@freezed
abstract class AstrologerSlot with _$AstrologerSlot {
  const AstrologerSlot._();

  const factory AstrologerSlot({
    required String id,
    required DateTime startsAt,
    required DateTime endsAt,
    @Default(true) bool available,
  }) = _AstrologerSlot;

  Duration get length => endsAt.difference(startsAt);

  /// Local calendar day, for grouping a flat list into "Mon 14", "Tue 15".
  DateTime get day => DateTime(startsAt.year, startsAt.month, startsAt.day);
}
