part of 'astrologers_strings.dart';

class _En extends AstrologersStrings {
  const _En();
  @override
  String get title => 'Astrologers';
  @override
  String get searchHint => 'Search by name or speciality';
  @override
  String get onlineNow => 'Online now';
  @override
  String get offline => 'Offline';
  @override
  String get busy => 'Busy';
  @override
  String get free => 'Available';
  @override
  String get consultNow => 'Consult now';
  @override
  String get currentlyOffline => 'Currently offline';

  @override
  String get bookLater => 'Book a slot';
  @override
  String get perMinute => '/min';
  @override
  String get from => 'from';
  @override
  String get yearsExperience => 'years';
  @override
  String get consultations => 'consultations';
  @override
  String get followers => 'followers';
  @override
  String get follow => 'Follow';
  @override
  String get following => 'Following';
  @override
  String get followingTitle => 'Astrologers you follow';

  @override
  String get noFollowingTitle => 'You are not following anyone yet';

  @override
  String get noFollowingBody =>
      'Follow an astrologer and they show up here, so you can see when they come online.';

  @override
  String get browseAstrologers => 'Browse astrologers';

  @override
  String get followingOnlineNote => 'online now';

  @override
  String get noResults => 'No astrologers match';
  @override
  String get noResultsHint => 'Try widening your filters or clearing them.';
  @override
  String get clearFilters => 'Clear filters';
  @override
  String get recentSearches => 'Recent searches';
  @override
  String get clearAll => 'Clear all';
  @override
  String get searchEmpty => 'Search for an astrologer by name or speciality.';
  @override
  String get filters => 'Filters';
  @override
  String get reset => 'Reset';
  @override
  String get speciality => 'Speciality';
  @override
  String get language => 'Language';
  @override
  String get channel => 'Consultation type';
  @override
  String get maxPricePerMinute => 'Maximum price per minute';
  @override
  String get minimumRating => 'Minimum rating';
  @override
  String get minimumExperience => 'Minimum experience';
  @override
  String get onlyOnline => 'Online only';
  @override
  String get sortBy => 'Sort by';
  @override
  String get anyPrice => 'Any price';
  @override
  String get any => 'Any';
  @override
  String get about => 'About';
  @override
  String get services => 'Services';
  @override
  String get reviews => 'Reviews';
  @override
  String get contact => 'Contact';
  @override
  String get recommended => 'recommended';
  @override
  String get basedOn => 'Based on';
  @override
  String get readMore => 'Read more';
  @override
  String get readLess => 'Read less';
  @override
  String get report => 'Report';
  @override
  String get block => 'Block';
  @override
  String get shareProfile => 'Share profile';
  @override
  String get noReviewsYet => 'No reviews yet';
  @override
  String get astrologerReplied => 'Astrologer replied';
  @override
  String get writeReview => 'Write a review';
  @override
  String get rateYourExperience => 'How was your consultation?';
  @override
  String get whatStoodOut => 'What stood out?';
  @override
  String get commentHint => 'Share what was helpful for others…';
  @override
  String get commentOptional => 'Your review (optional)';
  @override
  String get submitReview => 'Post review';
  @override
  String get reviewThanksTitle => 'Review posted';
  @override
  String get reviewThanksMessage =>
      'Thank you. Your review helps others choose.';
  @override
  String get tapAStar => 'Tap a star to rate';
  @override
  String get reportTitle => 'Report this astrologer';
  @override
  String get reportSubtitle => 'Tell us what went wrong. Reports are private.';
  @override
  String get reportDetailsHint => 'Add any details that would help us…';
  @override
  String get alsoBlock => 'Also hide this astrologer from my feed';
  @override
  String get submitReport => 'Submit report';
  @override
  String get reportThanks => 'Report submitted. Thank you.';
  @override
  String get cancel => 'Cancel';
  @override
  String specialty(Specialty value) => switch (value) {
    Specialty.vedic => 'Vedic',
    Specialty.numerology => 'Numerology',
    Specialty.tarot => 'Tarot',
    Specialty.vaastu => 'Vaastu',
    Specialty.palmistry => 'Palmistry',
    Specialty.kundliMatching => 'Kundli matching',
    Specialty.prashna => 'Prashna',
    Specialty.gemstone => 'Gemstone',
    Specialty.muhurta => 'Muhurta',
    Specialty.nadi => 'Nadi',
  };
  @override
  String channelName(ConsultChannel value) => switch (value) {
    ConsultChannel.chat => 'Chat',
    ConsultChannel.voice => 'Voice call',
    ConsultChannel.video => 'Video call',
  };
  @override
  String sortName(AstrologerSort value) => switch (value) {
    AstrologerSort.recommended => 'Recommended',
    AstrologerSort.ratingHigh => 'Highest rated',
    AstrologerSort.experienceHigh => 'Most experienced',
    AstrologerSort.priceLow => 'Price: low to high',
    AstrologerSort.priceHigh => 'Price: high to low',
    AstrologerSort.popularity => 'Most followed',
  };
  @override
  String reportReason(ReportReason value) => switch (value) {
    ReportReason.misleading => 'Misleading predictions',
    ReportReason.rude => 'Rude or unprofessional',
    ReportReason.spam => 'Spam or promotion',
    ReportReason.pricing => 'Pricing was not as shown',
    ReportReason.impersonation => 'Pretending to be someone else',
    ReportReason.other => 'Something else',
  };
  @override
  String reviewTag(String key) => switch (key) {
    'accurate' => 'Accurate',
    'patient' => 'Patient',
    'knowledgeable' => 'Knowledgeable',
    'honest' => 'Honest',
    'quick' => 'Quick',
    'practical' => 'Practical',
    _ => key,
  };
  @override
  String languageName(String code) => switch (code) {
    'ne' => 'Nepali',
    'hi' => 'Hindi',
    'en' => 'English',
    _ => code,
  };
  @override
  String showResults(String count) => 'Show $count astrologers';
  @override
  String waitingCount(String count, String minutes) =>
      '$count waiting · ~$minutes min';
  @override
  String yearsLabel(String years) => '$years yrs';
}
