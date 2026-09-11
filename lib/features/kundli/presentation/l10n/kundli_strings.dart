import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/dosha.dart';
import '../../domain/entities/gun_milan.dart';
import '../../domain/entities/vedic_basics.dart';

part 'kundli_strings_en.dart';
part 'kundli_strings_hi.dart';
part 'kundli_strings_ne.dart';

/// Feature-local strings for charts, dashas, doshas and matching.
///
/// Sanskrit terms are kept as Sanskrit in every language — "Rahu" is Rahu in
/// English too, and translating it would make the reading unrecognisable to
/// anyone who knows the subject.
abstract class KundliStrings {
  const KundliStrings();

  static KundliStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  // Saved charts
  String get kundli;
  String get savedCharts;
  String get newChart;
  String get noChartsTitle;
  String get noChartsBody;
  String get createFirstChart;
  String get matchKundli;
  String get matchKundliSubtitle;
  String get deleteChart;
  String get deleteChartBody;
  String get delete;
  String get cancel;

  // Form
  String get chartDetails;
  String get name;
  String get namePlaceholder;
  String get relation;
  String get gender;
  String get female;
  String get male;
  String get dateOfBirth;
  String get timeOfBirth;
  String get timeUnknown;
  String get timeUnknownNote;
  String get placeOfBirth;
  String get placePlaceholder;
  String get saveChart;
  String get select;

  // Chart view
  String get chart;
  String get planets;
  String get dasha;
  String get dosha;
  String get northIndian;
  String get southIndian;
  String get ascendant;
  String get moonSign;
  String get sunSign;
  String get birthStar;
  String get pada;
  String get house;
  String get sign;
  String get degree;
  String get retrograde;
  String get noHousesTitle;
  String get noHousesBody;

  // Dasha
  String get currentPeriod;
  String get mahadasha;
  String get antardasha;
  String get vimshottariNote;

  // Dosha
  String get noDoshaTitle;
  String get noDoshaBody;
  String get cancelled;
  String get consultAboutThis;

  // Gun Milan
  String get gunMilan;
  String get bride;
  String get groom;
  String get selectChart;
  String get checkMatch;
  String get needTwoCharts;
  String get needTwoChartsBody;
  String get outOf36;
  String get manglikStatus;
  String get manglikBoth;
  String get manglikNeither;
  String get manglikOneSided;
  String get kootaBreakdown;
  String get blockingTitle;
  String get blockingBody;
  String get consultAstrologer;

  String relationName(ChartRelation value);
  String grahaName(Graha value);
  String grahaShort(Graha value);
  String rashiName(Rashi value);
  String nakshatraName(Nakshatra value);
  String doshaName(DoshaKind value);
  String severityName(DoshaSeverity value);
  String doshaExplanation(DoshaKind kind, DoshaSeverity severity);
  String kootaName(Koota value);
  String kootaMeaning(Koota value);
  String verdictName(MatchVerdict value);
  String verdictBody(MatchVerdict value);

  /// "12 of 36"
  String scoreOf(String points, String total);
}
