import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../../domain/entities/astrologer_review.dart';
import '../../domain/entities/consult_channel.dart';
import '../../domain/entities/specialty.dart';

part 'astrologers_strings_en.dart';
part 'astrologers_strings_hi.dart';
part 'astrologers_strings_ne.dart';

/// Feature-local strings for astrologer discovery.
abstract class AstrologersStrings {
  const AstrologersStrings();

  static AstrologersStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  // Listing
  String get title;
  String get searchHint;
  String get onlineNow;
  String get offline;
  String get busy;
  String get free;
  String get consultNow;
  /// Label when the astrologer is not online.
  ///
  /// Replaces the old "book later": astrologers have no bookable slots —
  /// only service providers do — so offering to book one led nowhere.
  String get currentlyOffline;

  String get bookLater;
  String get perMinute;
  String get from;
  String get yearsExperience;
  String get consultations;
  String get followers;
  String get follow;
  String get following;
  String get followingTitle;
  String get noFollowingTitle;
  String get noFollowingBody;
  String get browseAstrologers;
  String get followingOnlineNote;
  String get noResults;
  String get noResultsHint;
  String get clearFilters;

  // Search
  String get recentSearches;
  String get clearAll;
  String get searchEmpty;

  // Filters
  String get filters;
  String get reset;
  String get speciality;
  String get language;
  String get channel;
  String get maxPricePerMinute;
  String get minimumRating;
  String get minimumExperience;
  String get onlyOnline;
  String get sortBy;
  String get anyPrice;
  String get any;

  // Profile
  String get about;
  String get services;
  String get reviews;
  String get contact;
  String get recommended;
  String get basedOn;
  String get readMore;
  String get readLess;
  String get report;
  String get block;
  String get shareProfile;
  String get noReviewsYet;
  String get astrologerReplied;

  // Write review
  String get writeReview;
  String get rateYourExperience;
  String get whatStoodOut;
  String get commentHint;
  String get commentOptional;
  String get submitReview;
  String get reviewThanksTitle;
  String get reviewThanksMessage;
  String get tapAStar;

  // Report
  String get reportTitle;
  String get reportSubtitle;
  String get reportDetailsHint;
  String get alsoBlock;
  String get submitReport;
  String get reportThanks;
  String get cancel;

  String specialty(Specialty value);
  String channelName(ConsultChannel value);
  String sortName(AstrologerSort value);
  String reportReason(ReportReason value);
  String reviewTag(String key);
  String languageName(String code);

  /// "24 astrologers" — the apply button on the filter sheet.
  String showResults(String count);

  /// "3rd in queue · ~24 min wait"
  String waitingCount(String count, String minutes);

  String yearsLabel(String years);
}
