import 'package:flutter/widgets.dart';

import '../extensions/context_extensions.dart';
import '../extensions/string_extensions.dart';

/// "Just now" / "5 min ago" / "Yesterday" / "3 days ago".
///
/// Uses the shared ARB strings so every feature phrases elapsed time the
/// same way, and renders digits in Devanagari for Nepali and Hindi.
String relativeTime(BuildContext context, DateTime time, {DateTime? now}) {
  final l10n = context.l10n;
  final diff = (now ?? DateTime.now()).difference(time);

  String digits(String value) =>
      context.usesDevanagariDigits ? value.toDevanagariDigits() : value;

  if (diff.inMinutes < 1) return l10n.justNow;
  if (diff.inMinutes < 60) return digits(l10n.minutesAgo(diff.inMinutes));
  if (diff.inHours < 24) return digits(l10n.hoursAgo(diff.inHours));
  if (diff.inDays == 1) return l10n.yesterday;
  if (diff.inDays < 30) return digits(l10n.daysAgo(diff.inDays));
  if (diff.inDays < 365) return digits(l10n.monthsAgo(diff.inDays ~/ 30));
  return digits(l10n.yearsAgo(diff.inDays ~/ 365));
}
