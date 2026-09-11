import 'package:freezed_annotation/freezed_annotation.dart';

part 'forex_history_point.freezed.dart';

/// One day of buy / sell history for a currency (used by the trend chart).
@freezed
abstract class ForexHistoryPoint with _$ForexHistoryPoint {
  const factory ForexHistoryPoint({
    required DateTime date,
    required double buy,
    required double sell,
  }) = _ForexHistoryPoint;
}
