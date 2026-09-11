import 'package:freezed_annotation/freezed_annotation.dart';

import 'vedic_basics.dart';

part 'dasha.freezed.dart';

/// One Vimshottari period. Mahadashas contain antardashas as [children].
@freezed
abstract class DashaPeriod with _$DashaPeriod {
  const DashaPeriod._();

  const factory DashaPeriod({
    required Graha graha,
    required DateTime start,
    required DateTime end,
    @Default(<DashaPeriod>[]) List<DashaPeriod> children,
  }) = _DashaPeriod;

  bool isCurrent({DateTime? now}) {
    final at = now ?? DateTime.now();
    return !at.isBefore(start) && at.isBefore(end);
  }

  bool isPast({DateTime? now}) => (now ?? DateTime.now()).isAfter(end);

  Duration get length => end.difference(start);

  /// How far through the period we are, 0–1 — drives the progress bar.
  double progress({DateTime? now}) {
    final at = now ?? DateTime.now();
    if (at.isBefore(start)) return 0;
    if (at.isAfter(end)) return 1;
    final total = length.inSeconds;
    return total == 0 ? 0 : at.difference(start).inSeconds / total;
  }

  /// The running antardasha, when this mahadasha is the current one.
  DashaPeriod? currentChild({DateTime? now}) {
    for (final child in children) {
      if (child.isCurrent(now: now)) return child;
    }
    return null;
  }
}
