import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../l10n/profile_strings.dart';

/// "5 day ago" / "11 hours ago" / "15 mins ago" style label (Figma order
/// cards), with Devanagari digits in Nepali mode.
String relativeTime(BuildContext context, DateTime time, {DateTime? now}) {
  final s = ProfileStrings.of(context);
  final diff = (now ?? DateTime.now()).difference(time);
  if (diff.inMinutes < 1) return s.justNow;
  final String value;
  if (diff.inDays >= 1) {
    value = '${diff.inDays} ${s.days}';
  } else if (diff.inHours >= 1) {
    value = '${diff.inHours} ${s.hours}';
  } else {
    value = '${diff.inMinutes} ${s.minutes}';
  }
  return s.ago(localizeDigits(context, value));
}

/// Formats an amount in the active region's currency (`रु. 10,000` /
/// `₹10,000`) with Devanagari digits for Nepali / Hindi.
String formatMoney(BuildContext context, num amount) => RegionFormat.money(
  amount,
  config: context.regionConfig,
  languageCode: context.languageCode,
);
