import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_window.freezed.dart';

/// Kind of a muhurta window (drives icon/tint and localised label).
enum TimeWindowKind {
  rahuKaal,
  yamaganda,
  gulikaKaal,
  abhijit,
  choghadiya;

  static TimeWindowKind fromName(String? name) => values.firstWhere(
    (k) => k.name == name,
    orElse: () => TimeWindowKind.choghadiya,
  );
}

/// Choghadiya quality: auspicious (शुभ/लाभ/अमृत/चर) vs. inauspicious
/// (उद्वेग/काल/रोग).
enum ChoghadiyaQuality { good, neutral, bad }

/// A named local-time interval of the day, e.g. Rahu Kaal 09:00–10:30 or a
/// Choghadiya segment "Amrit 07:15–08:45".
@freezed
abstract class TimeWindow with _$TimeWindow {
  const TimeWindow._();

  const factory TimeWindow({
    required TimeWindowKind kind,
    required DateTime start,
    required DateTime end,

    /// Segment name (Choghadiya: अमृत / Amrit …). Empty for kaal windows whose
    /// label comes from [kind].
    @Default('') String nameNe,
    @Default('') String nameEn,
    @Default(ChoghadiyaQuality.neutral) ChoghadiyaQuality quality,
  }) = _TimeWindow;

  String name({required bool nepali}) => nepali ? nameNe : nameEn;

  Duration get duration => end.difference(start);

  bool contains(DateTime t) => !t.isBefore(start) && t.isBefore(end);
}
