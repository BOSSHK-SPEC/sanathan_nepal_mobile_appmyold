import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region_all.dart';
import '../l10n/marketplace_strings.dart';

/// Number / price / relative-time formatting for the marketplace UI.
abstract final class MarketplaceFormat {
  /// Region-aware price: lakh/crore grouping with the region's currency
  /// symbol ("रु. 40,00,000" · "₹40,00,000") and Devanagari digits for
  /// Nepali / Hindi ("रु. ४०,००,०००"). Delegates to [RegionFormat.money].
  static String price(
    num amount, {
    required RegionConfig config,
    required String languageCode,
    bool decimals = false,
  }) => RegionFormat.money(
    amount,
    config: config,
    languageCode: languageCode,
    decimals: decimals ? 2 : 0,
  );

  /// Convenience for widgets: `MarketplaceFormat.priceOf(context, 1500)`.
  static String priceOf(
    BuildContext context,
    num amount, {
    bool decimals = false,
  }) => price(
    amount,
    config: context.regionConfig,
    languageCode: context.languageCode,
    decimals: decimals,
  );

  /// Formats a plain count ("1,408" / "१,४०८").
  static String count(num n, {required bool devanagari}) {
    final grouped = groupNepali(n);
    return devanagari ? grouped.toDevanagariDigits() : grouped;
  }

  static String countOf(BuildContext context, num n) =>
      count(n, devanagari: context.usesDevanagariDigits);

  /// Digits only, localised (Devanagari for Nepali / Hindi).
  static String digits(BuildContext context, Object n) =>
      context.usesDevanagariDigits
      ? n.toString().toDevanagariDigits()
      : n.toString();

  /// Indian/Nepali digit grouping: last 3 digits, then pairs.
  static String groupNepali(num amount, {bool decimals = false}) {
    final abs = amount.abs();
    final whole = abs.floor();
    final fraction = decimals
        ? '.${((abs - whole) * 100).round().toString().padLeft(2, '0')}'
        : '';
    final digits = whole.toString();
    String grouped;
    if (digits.length <= 3) {
      grouped = digits;
    } else {
      final tail = digits.substring(digits.length - 3);
      var head = digits.substring(0, digits.length - 3);
      final parts = <String>[];
      while (head.length > 2) {
        parts.insert(0, head.substring(head.length - 2));
        head = head.substring(0, head.length - 2);
      }
      if (head.isNotEmpty) parts.insert(0, head);
      grouped = '${parts.join(',')},$tail';
    }
    return '${amount < 0 ? '-' : ''}$grouped$fraction';
  }

  /// "4 minutes ago" / "४ मिनेट अघि".
  static String timeAgo(BuildContext context, DateTime time, {DateTime? now}) {
    final s = MarketplaceStrings.of(context);
    final diff = (now ?? DateTime.now()).difference(time);
    String d(int n) => digits(context, n);
    if (diff.inMinutes < 1) return s.justNow();
    if (diff.inHours < 1) return s.minutesAgo(d(diff.inMinutes));
    if (diff.inDays < 1) return s.hoursAgo(d(diff.inHours));
    return s.daysAgo(d(diff.inDays));
  }

  /// "2023-06-03" with localised digits.
  static String isoDate(BuildContext context, DateTime date) {
    final text =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return digits(context, text);
  }
}
