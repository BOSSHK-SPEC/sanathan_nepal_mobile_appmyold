import 'package:freezed_annotation/freezed_annotation.dart';

part 'traditional_date.freezed.dart';

/// A date in a region's traditional calendar (Bikram Sambat for Nepal,
/// Indian national/Saka calendar for India). Month is 1-based.
@freezed
abstract class TraditionalDate
    with _$TraditionalDate
    implements Comparable<TraditionalDate> {
  const TraditionalDate._();

  const factory TraditionalDate(int year, int month, int day) =
      _TraditionalDate;

  int get key => year * 10000 + month * 100 + day;

  bool isSameDay(TraditionalDate other) => key == other.key;

  @override
  int compareTo(TraditionalDate other) => key.compareTo(other.key);
}
