import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/traditional_calendar.dart';

part 'suva_sait.freezed.dart';

/// An auspicious-timing category (शुभ साइत / मुहूर्त) with its dates.
///
/// [dates] spans the whole browsable range of the mock/back-end (previous,
/// current and next traditional year) so the monthly / yearly tables of the
/// Panchanga page can be built without further requests.
@freezed
abstract class SuvaSait with _$SuvaSait {
  const SuvaSait._();

  const factory SuvaSait({
    required String id,

    /// e.g. "होम गर्ने साइत".
    required String titleNe,

    /// e.g. "Hom (fire ritual) sait".
    required String titleEn,

    /// Auspicious dates, ascending.
    required List<DateTime> dates,
    @Default('') String noteNe,
    @Default('') String noteEn,
  }) = _SuvaSait;

  String title({required bool nepali}) => nepali ? titleNe : titleEn;
  String note({required bool nepali}) => nepali ? noteNe : noteEn;

  /// True if one of [dates] falls on [day].
  bool isOn(DateTime day) => dates.any((d) => _sameDay(d, day));

  /// Dates on or after [from] (ascending), at most [max] when given.
  List<DateTime> upcoming(DateTime from, {int? max}) {
    final start = DateTime(from.year, from.month, from.day);
    final list = dates.where((d) => !d.isBefore(start)).toList(growable: false);
    return max == null || list.length <= max ? list : list.sublist(0, max);
  }

  /// Days of the traditional month [year]/[month] (in [calendar]) that carry
  /// this sait, ascending and de-duplicated.
  List<int> daysIn(TraditionalCalendar calendar, int year, int month) {
    final days = <int>{};
    for (final d in dates) {
      final t = calendar.fromGregorian(d);
      if (t.year == year && t.month == month) days.add(t.day);
    }
    return days.toList(growable: false)..sort();
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
