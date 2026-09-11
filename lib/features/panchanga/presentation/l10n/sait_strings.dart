import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';

/// Strings of the full "शुभ साइत तथा मुहूर्तहरू" panel (monthly / yearly
/// tables) – split from [PanchangaStrings] to keep files small.
///
/// Nepal wording is "साइत", India wording is "मुहूर्त"; English getters take
/// the [RegionConfig] to pick between "Suva Sait" and "Shubh Muhurat".
abstract class SaitStrings {
  const SaitStrings();

  static SaitStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String title(RegionConfig c);
  String monthlyTab(RegionConfig c);
  String yearlyTab(RegionConfig c);
  String previousMonth(RegionConfig c);
  String nextMonth(RegionConfig c);
  String previousYear(RegionConfig c);
  String nextYear(RegionConfig c);

  /// "फागुन महिनाको शुभ साइत" / "Suva Sait of Falgun".
  String monthTitle(String month, RegionConfig c);

  /// "२०७९ सालको शुभ साइत" / "Suva Sait of 2079".
  String yearTitle(String year, RegionConfig c);
  String noSaitToday(RegionConfig c);

  /// Nothing published at all, as opposed to "none falls today". Saits are
  /// editorial — an empty list means no panel has published, not that every
  /// day is inauspicious.
  String noSaitsPublished(RegionConfig c);
  String noSaitInMonth(RegionConfig c);
}

class _Ne extends SaitStrings {
  const _Ne();
  @override
  String title(RegionConfig c) => 'शुभ साइत तथा मुहूर्तहरू';
  @override
  String monthlyTab(RegionConfig c) => 'मासिक शुभ साइत';
  @override
  String yearlyTab(RegionConfig c) => 'वार्षिक शुभ साइत';
  @override
  String previousMonth(RegionConfig c) => 'अघिल्लो महिना';
  @override
  String nextMonth(RegionConfig c) => 'आगामी महिना';
  @override
  String previousYear(RegionConfig c) => 'अघिल्लो वर्ष';
  @override
  String nextYear(RegionConfig c) => 'आगामी वर्ष';
  @override
  String monthTitle(String month, RegionConfig c) => '$month महिनाको शुभ साइत';
  @override
  String yearTitle(String year, RegionConfig c) => '$year सालको शुभ साइत';
  @override
  String noSaitToday(RegionConfig c) =>
      'आज कुनै शुभ साइत तथा मुहूर्त फेला परेन ।';
  @override
  String noSaitsPublished(RegionConfig c) => c.isIndia
      ? 'हाल कुनै शुभ मुहूर्त प्रकाशित भएको छैन ।'
      : 'हाल कुनै शुभ साइत प्रकाशित भएको छैन ।';
  @override
  String noSaitInMonth(RegionConfig c) => 'यस महिनामा कुनै साइत छैन ।';
}

class _Hi extends SaitStrings {
  const _Hi();
  @override
  String title(RegionConfig c) => 'शुभ मुहूर्त';
  @override
  String monthlyTab(RegionConfig c) => 'मासिक शुभ मुहूर्त';
  @override
  String yearlyTab(RegionConfig c) => 'वार्षिक शुभ मुहूर्त';
  @override
  String previousMonth(RegionConfig c) => 'पिछला महीना';
  @override
  String nextMonth(RegionConfig c) => 'अगला महीना';
  @override
  String previousYear(RegionConfig c) => 'पिछला वर्ष';
  @override
  String nextYear(RegionConfig c) => 'अगला वर्ष';
  @override
  String monthTitle(String month, RegionConfig c) =>
      '$month माह के शुभ मुहूर्त';
  @override
  String yearTitle(String year, RegionConfig c) => '$year के शुभ मुहूर्त';
  @override
  String noSaitToday(RegionConfig c) => 'आज कोई शुभ मुहूर्त नहीं मिला ।';
  @override
  String noSaitsPublished(RegionConfig c) => c.isIndia
      ? 'अभी कोई शुभ मुहूर्त प्रकाशित नहीं हुआ है ।'
      : 'अभी कोई शुभ साइत प्रकाशित नहीं हुआ है ।';
  @override
  String noSaitInMonth(RegionConfig c) => 'इस माह कोई मुहूर्त नहीं है ।';
}

class _En extends SaitStrings {
  const _En();
  String _w(RegionConfig c) => c.isIndia ? 'Shubh Muhurat' : 'Suva Sait';
  @override
  String title(RegionConfig c) =>
      c.isIndia ? 'Shubh Muhurat' : 'Suva Sait And Muhurat';
  @override
  String monthlyTab(RegionConfig c) => 'Monthly ${_w(c)}';
  @override
  String yearlyTab(RegionConfig c) => 'Yearly ${_w(c)}';
  @override
  String previousMonth(RegionConfig c) => 'Previous Month';
  @override
  String nextMonth(RegionConfig c) => 'Next Month';
  @override
  String previousYear(RegionConfig c) => 'Previous Year';
  @override
  String nextYear(RegionConfig c) => 'Next Year';
  @override
  String monthTitle(String month, RegionConfig c) => '${_w(c)} of $month';
  @override
  String yearTitle(String year, RegionConfig c) => '${_w(c)} of $year';
  @override
  String noSaitToday(RegionConfig c) => c.isIndia
      ? 'No Shubh Muhurat found today.'
      : 'No Sait and Muhurat Found Today.';
  @override
  String noSaitsPublished(RegionConfig c) => c.isIndia
      ? 'No muhurats have been published yet.'
      : 'No saits have been published yet.';
  @override
  String noSaitInMonth(RegionConfig c) =>
      c.isIndia ? 'No muhurat this month.' : 'No sait this month.';
}
