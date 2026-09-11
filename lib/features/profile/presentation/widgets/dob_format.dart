import 'package:flutter/widgets.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/user_profile.dart';
import '../l10n/profile_strings.dart';

/// Helpers for the `YYYY/MM/DD` date-of-birth strings stored on
/// [UserProfile], resolved against the active region's traditional calendar.
abstract final class DobFormat {
  /// `YYYY/MM/DD`.
  static String ymd(int y, int m, int d) =>
      '$y/${m.toString().padLeft(2, '0')}/${d.toString().padLeft(2, '0')}';

  static String traditional(TraditionalDate d) => ymd(d.year, d.month, d.day);

  /// Parses a `YYYY/MM/DD` Gregorian string.
  static DateTime? parseAd(String? v) {
    if (v == null) return null;
    final parts = v.split('/');
    if (parts.length != 3) return null;
    return DateTime.tryParse('${parts[0]}-${parts[1]}-${parts[2]}');
  }

  /// Traditional-calendar DOB for the active region: derived from [dobAd]
  /// through `context.traditionalCalendar` when possible (so a Nepal profile
  /// viewed in India shows Saka, and vice-versa), else the stored value.
  static String? traditionalFor(
    BuildContext context, {
    String? dobAd,
    String? stored,
  }) {
    final ad = parseAd(dobAd);
    if (ad == null) return stored;
    return traditional(context.traditionalCalendar.fromGregorian(ad));
  }

  /// "2054/12/20 B.S. · 1998/04/02 A.D." style display for the profile card
  /// (Devanagari digits in Nepali / Hindi). Returns `null` when nothing is
  /// known.
  static String? display(
    BuildContext context, {
    String? dobAd,
    String? stored,
  }) {
    final s = ProfileStrings.of(context);
    final era = context.traditionalCalendar.eraLabel(
      languageCode: context.languageCode,
    );
    final trad = traditionalFor(context, dobAd: dobAd, stored: stored);
    final parts = [
      if (trad != null && trad.isNotEmpty) '$trad $era',
      if (dobAd != null && dobAd.isNotEmpty) '$dobAd ${s.eraAd}',
    ];
    if (parts.isEmpty) return null;
    return localizeDigits(context, parts.join(' · '));
  }
}
