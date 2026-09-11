part of 'kundli_strings.dart';

class _En extends KundliStrings {
  const _En();
  @override
  String get kundli => 'Kundli';
  @override
  String get savedCharts => 'Saved charts';
  @override
  String get newChart => 'New chart';
  @override
  String get noChartsTitle => 'No charts yet';
  @override
  String get noChartsBody =>
      'Save a birth chart for yourself or family and it will be ready every '
      'time you consult.';
  @override
  String get createFirstChart => 'Create a chart';
  @override
  String get matchKundli => 'Match kundli';
  @override
  String get matchKundliSubtitle => 'Compare two charts on the 36 gunas';
  @override
  String get deleteChart => 'Delete chart';
  @override
  String get deleteChartBody =>
      'This chart will be removed from your saved list.';
  @override
  String get delete => 'Delete';
  @override
  String get cancel => 'Cancel';
  @override
  String get chartDetails => 'Birth details';
  @override
  String get name => 'Name';
  @override
  String get namePlaceholder => 'Full name';
  @override
  String get relation => 'Relation';
  @override
  String get gender => 'Gender';
  @override
  String get female => 'Female';
  @override
  String get male => 'Male';
  @override
  String get dateOfBirth => 'Date of birth';
  @override
  String get timeOfBirth => 'Time of birth';
  @override
  String get timeUnknown => 'Birth time unknown';
  @override
  String get timeUnknownNote =>
      'Without a birth time the ascendant and houses cannot be calculated. '
      'Planets in signs are still shown.';
  @override
  String get placeOfBirth => 'Place of birth';
  @override
  String get placePlaceholder => 'City or district';
  @override
  String get saveChart => 'Save chart';
  @override
  String get select => 'Select';
  @override
  String get chart => 'Chart';
  @override
  String get planets => 'Planets';
  @override
  String get dasha => 'Dasha';
  @override
  String get dosha => 'Dosha';
  @override
  String get northIndian => 'North';
  @override
  String get southIndian => 'South';
  @override
  String get ascendant => 'Ascendant';
  @override
  String get moonSign => 'Moon sign';
  @override
  String get sunSign => 'Sun sign';
  @override
  String get birthStar => 'Birth star';
  @override
  String get pada => 'Pada';
  @override
  String get house => 'House';
  @override
  String get sign => 'Sign';
  @override
  String get degree => 'Degree';
  @override
  String get retrograde => 'Retrograde';
  @override
  String get noHousesTitle => 'Houses unavailable';
  @override
  String get noHousesBody =>
      'This chart was saved without a birth time, so house positions are not '
      'shown.';
  @override
  String get currentPeriod => 'Running now';
  @override
  String get mahadasha => 'Mahadasha';
  @override
  String get antardasha => 'Antardasha';
  @override
  String get vimshottariNote =>
      'Vimshottari dasha, calculated from your birth star.';
  @override
  String get noDoshaTitle => 'No major dosha found';
  @override
  String get noDoshaBody =>
      'None of the common afflictions apply to this chart.';
  @override
  String get cancelled => 'Cancelled';
  @override
  String get consultAboutThis => 'Ask an astrologer';
  @override
  String get gunMilan => 'Gun Milan';
  @override
  String get bride => 'Bride';
  @override
  String get groom => 'Groom';
  @override
  String get selectChart => 'Select a chart';
  @override
  String get checkMatch => 'Check compatibility';
  @override
  String get needTwoCharts => 'Save two charts first';
  @override
  String get needTwoChartsBody =>
      'Matching compares two birth charts, so you need at least two saved.';
  @override
  String get outOf36 => 'out of 36';
  @override
  String get manglikStatus => 'Manglik';
  @override
  String get manglikBoth => 'Both Manglik — traditionally considered cancelled';
  @override
  String get manglikNeither => 'Neither chart is Manglik';
  @override
  String get manglikOneSided => 'Only one chart is Manglik';
  @override
  String get kootaBreakdown => 'Koota breakdown';
  @override
  String get blockingTitle => 'A blocking koota scored zero';
  @override
  String get blockingBody =>
      'Nadi and Bhakoot carry the most weight. A zero in either is usually '
      'discussed with an astrologer before proceeding.';
  @override
  String get consultAstrologer => 'Discuss with an astrologer';
  @override
  String relationName(ChartRelation value) => switch (value) {
    ChartRelation.self => 'Myself',
    ChartRelation.spouse => 'Spouse',
    ChartRelation.child => 'Child',
    ChartRelation.parent => 'Parent',
    ChartRelation.sibling => 'Sibling',
    ChartRelation.friend => 'Friend',
    ChartRelation.match => 'Prospective match',
    ChartRelation.other => 'Other',
  };
  @override
  String doshaName(DoshaKind value) => switch (value) {
    DoshaKind.manglik => 'Manglik (Mangal dosha)',
    DoshaKind.kaalSarp => 'Kaal Sarp dosha',
    DoshaKind.sadeSati => 'Sade Sati',
    DoshaKind.pitra => 'Pitra dosha',
    DoshaKind.nadiDosha => 'Nadi dosha',
  };
  @override
  String severityName(DoshaSeverity value) => switch (value) {
    DoshaSeverity.none => 'Not present',
    DoshaSeverity.mild => 'Mild',
    DoshaSeverity.moderate => 'Moderate',
    DoshaSeverity.high => 'Strong',
  };
  @override
  String doshaExplanation(DoshaKind kind, DoshaSeverity severity) =>
      switch (kind) {
        DoshaKind.manglik =>
          'Mars sits in a house that classically affects marriage timing and '
              'temperament.',
        DoshaKind.kaalSarp =>
          'Every graha falls on one side of the Rahu–Ketu axis, which is said '
              'to concentrate effort into fewer areas of life.',
        DoshaKind.sadeSati =>
          'Saturn is transiting near your Moon sign — a demanding but '
              'formative period.',
        DoshaKind.pitra => 'Indications relating to ancestral obligations.',
        DoshaKind.nadiDosha => 'Relevant mainly to marriage matching.',
      };
  @override
  String kootaName(Koota value) => switch (value) {
    Koota.varna => 'Varna',
    Koota.vashya => 'Vashya',
    Koota.tara => 'Tara',
    Koota.yoni => 'Yoni',
    Koota.grahaMaitri => 'Graha Maitri',
    Koota.gana => 'Gana',
    Koota.bhakoot => 'Bhakoot',
    Koota.nadi => 'Nadi',
  };
  @override
  String kootaMeaning(Koota value) => switch (value) {
    Koota.varna => 'Spiritual compatibility',
    Koota.vashya => 'Mutual influence',
    Koota.tara => 'Health and wellbeing',
    Koota.yoni => 'Physical compatibility',
    Koota.grahaMaitri => 'Mental affinity',
    Koota.gana => 'Temperament',
    Koota.bhakoot => 'Family and prosperity',
    Koota.nadi => 'Health of children',
  };
  @override
  String verdictName(MatchVerdict value) => switch (value) {
    MatchVerdict.excellent => 'Excellent match',
    MatchVerdict.good => 'Good match',
    MatchVerdict.average => 'Acceptable match',
    MatchVerdict.poor => 'Needs discussion',
  };
  @override
  String verdictBody(MatchVerdict value) => switch (value) {
    MatchVerdict.excellent =>
      'A strong score across the kootas that matter most.',
    MatchVerdict.good => 'A comfortable match by the classical standard.',
    MatchVerdict.average =>
      'Above the usual minimum of 18, but worth reviewing the weaker kootas.',
    MatchVerdict.poor =>
      'Below the usual minimum, or a blocking koota scored zero.',
  };
  @override
  String scoreOf(String points, String total) => '$points of $total';
  @override
  String grahaName(Graha value) => switch (value) {
    Graha.sun => 'Sun',
    Graha.moon => 'Moon',
    Graha.mars => 'Mars',
    Graha.mercury => 'Mercury',
    Graha.jupiter => 'Jupiter',
    Graha.venus => 'Venus',
    Graha.saturn => 'Saturn',
    Graha.rahu => 'Rahu',
    Graha.ketu => 'Ketu',
  };
  @override
  String grahaShort(Graha value) => switch (value) {
    Graha.sun => 'Su',
    Graha.moon => 'Mo',
    Graha.mars => 'Ma',
    Graha.mercury => 'Me',
    Graha.jupiter => 'Ju',
    Graha.venus => 'Ve',
    Graha.saturn => 'Sa',
    Graha.rahu => 'Ra',
    Graha.ketu => 'Ke',
  };
  @override
  String rashiName(Rashi value) => switch (value) {
    Rashi.mesha => 'Mesha',
    Rashi.vrishabha => 'Vrishabha',
    Rashi.mithuna => 'Mithuna',
    Rashi.karka => 'Karka',
    Rashi.simha => 'Simha',
    Rashi.kanya => 'Kanya',
    Rashi.tula => 'Tula',
    Rashi.vrishchika => 'Vrishchika',
    Rashi.dhanu => 'Dhanu',
    Rashi.makara => 'Makara',
    Rashi.kumbha => 'Kumbha',
    Rashi.meena => 'Meena',
  };
  @override
  String nakshatraName(Nakshatra value) => switch (value) {
    Nakshatra.ashwini => 'Ashwini',
    Nakshatra.bharani => 'Bharani',
    Nakshatra.krittika => 'Krittika',
    Nakshatra.rohini => 'Rohini',
    Nakshatra.mrigashira => 'Mrigashira',
    Nakshatra.ardra => 'Ardra',
    Nakshatra.punarvasu => 'Punarvasu',
    Nakshatra.pushya => 'Pushya',
    Nakshatra.ashlesha => 'Ashlesha',
    Nakshatra.magha => 'Magha',
    Nakshatra.purvaPhalguni => 'Purva Phalguni',
    Nakshatra.uttaraPhalguni => 'Uttara Phalguni',
    Nakshatra.hasta => 'Hasta',
    Nakshatra.chitra => 'Chitra',
    Nakshatra.swati => 'Swati',
    Nakshatra.vishakha => 'Vishakha',
    Nakshatra.anuradha => 'Anuradha',
    Nakshatra.jyeshtha => 'Jyeshtha',
    Nakshatra.mula => 'Mula',
    Nakshatra.purvaAshadha => 'Purva Ashadha',
    Nakshatra.uttaraAshadha => 'Uttara Ashadha',
    Nakshatra.shravana => 'Shravana',
    Nakshatra.dhanishta => 'Dhanishta',
    Nakshatra.shatabhisha => 'Shatabhisha',
    Nakshatra.purvaBhadrapada => 'Purva Bhadrapada',
    Nakshatra.uttaraBhadrapada => 'Uttara Bhadrapada',
    Nakshatra.revati => 'Revati',
  };
}
