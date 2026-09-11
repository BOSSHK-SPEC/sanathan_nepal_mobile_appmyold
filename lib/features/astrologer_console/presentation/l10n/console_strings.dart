import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/application.dart';
import '../../domain/entities/boost.dart';
import '../../domain/entities/compliance_notice.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/payout.dart';

part 'console_strings_en.dart';
part 'console_strings_hi.dart';
part 'console_strings_ne.dart';

/// Feature-local strings for the astrologer console.
abstract class ConsoleStrings {
  const ConsoleStrings();

  static ConsoleStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  String get becomeAstrologer;
  String get applyIntroTitle;
  String get applyIntroBody;
  String get requirements;
  String get requirementId;
  String get requirementExperience;
  String get requirementPricing;
  String get requirementTime;
  String get startApplication;
  String get continueApplication;
  String get stepIdentity;
  String get stepCredentials;
  String get stepExpertise;
  String get stepPricing;
  String get stepIntroduction;
  String get fullName;
  String get phone;
  String get email;
  String get idFront;
  String get idBack;
  String get selfie;
  String get certificate;
  String get addressProof;
  String uploadHint(String maxSize);

  /// Confirms a private document is stored, since it cannot be previewed.
  String get documentAttached;

  /// Confirmation before discarding an attached document. Worded as a
  /// deletion because the stored file goes with it and cannot be restored —
  /// "remove" alone reads as unlinking something still recoverable.
  String get removeDocumentTitle;
  String removeDocumentMessage(String label);
  String get removeDocumentConfirm;
  String get documentRemoved;
  String get yearsExperience;
  String get aboutYou;
  String get aboutYouHint;
  String get specialities;
  String get languagesYouSpeak;
  String get setYourRates;
  String get ratesNote;
  String get youKeep;

  /// "A 30-min booking costs ₹30,000" — what this rate means for a sitting
  /// somebody books in advance, shown while the rate is being typed.
  String bookedSittingCosts(String money, String minutes);

  /// Shown when the typed rate is outside what the platform will accept.
  String rateTooHigh(String max);
  String get compliance;
  String get complianceNeedsAction;
  String get compliancePast;
  String get noNoticesTitle;
  String get noNoticesBody;
  String get acknowledge;
  String get acknowledged;
  String get appeal;
  String get appealTitle;
  String get appealBody;
  String get appealReasonHint;
  String get submitAppeal;
  String get appealSubmitted;
  String get underAppeal;
  String get amountWithheld;
  String get actionRequired;
  String get dueBy;
  String get overdue;
  String get relatedSession;
  String noticeKind(ComplianceKind kind);
  String get workSettings;
  String get alerts;
  String get newRequestAlerts;
  String get newRequestAlertsNote;
  String get alertSound;
  String get ringUntilAnswered;
  String get ringUntilAnsweredNote;
  String get scheduleReminders;
  String get payoutAlerts;
  String get reviewAlerts;
  String get marketingAlerts;
  String get quietHours;
  String get quietHoursNote;
  String get quietFrom;
  String get quietTo;
  String get requestRouting;
  String get channelsYouAccept;
  String get allChannels;
  String get maxQueueLength;
  String get maxQueueLengthNote;
  String get noQueueCap;
  String get autoDeclineAfter;
  String get autoDeclineAfterNote;
  String get autoAcceptRepeat;
  String get autoAcceptRepeatNote;
  String seconds(int value);
  String peopleWaiting(int value);
  String get editProfile;
  String get profileHeadline;
  String get profileHeadlineHint;
  String get profilePhoto;
  String get profilePhotoHint;
  String get profileVisibility;
  String get hideFromSearch;
  String get hideFromSearchNote;
  String get profileStrength;
  String get publishProfile;
  String get profilePublished;
  String get profilePreview;
  String get introVideo;
  String get introVideoHint;
  String get termsTitle;
  String get termsBody;
  String get acceptTerms;
  String get submitApplication;
  String get back;
  String get next;

  /// Names what is still outstanding on the current step, so a disabled
  /// Next button is never unexplained.
  String stepIncomplete(String what);

  /// Names what is still wrong with the bio, with how much is missing —
  /// "About you" alone reads as "you left it blank" when it is filled.
  String aboutYouShort(int remaining);

  /// Fallback when a step is incomplete for a reason with no field.
  String get stepIncompleteGeneric;
  String get submittedTitle;
  String get submittedBody;
  String get applicationStatus;
  String get statusSubmitted;
  String get statusUnderReview;
  String get statusMoreInfo;
  String get statusApproved;
  String get statusRejected;
  String get statusDraft;
  String get statusNotStarted;
  String get reviewerNote;
  String get fixAndResubmit;
  String get openConsole;
  String get console;
  String get navQueue;
  String get navSchedule;
  String get navEarnings;
  String get navClients;
  String get switchToPersonal;
  String get switchToAstrologer;
  String get goOnline;
  String get goOffline;
  String get youAreOnline;
  String get youAreOffline;
  String get setScheduleFirst;

  /// Action on the online card when no schedule exists — an explanation with
  /// no way to act on it just tells the astrologer they are stuck.
  String get setScheduleAction;

  /// Shown when availability itself could not be read, which is a different
  /// problem from having no schedule and needs a different fix.
  String get availabilityUnavailable;
  String get onlineChangeFailed;
  String get earningsToday;
  String get earningsWeek;
  String get sessionsToday;
  String get waitingNow;
  String get yourRating;
  String get acceptanceRate;
  String get responseTime;
  String get repeatRate;
  String get acceptanceWarning;
  /// Sessions already running — the way back into a chat or call the
  /// astrologer has navigated away from.
  String get ongoingSessions;

  /// Verb on an ongoing session's tile.
  String get rejoin;

  String get liveQueue;
  String get queueEmpty;
  String get queueEmptyOffline;
  String get queueEmptyOnline;
  String get repeatClient;
  String get lowBalanceWarning;
  String get newRequest;
  String get accept;
  String get decline;
  String get waitingFor;
  String get weeklyHours;
  String get addWindow;
  String get copyToWeekdays;
  String get noWindows;
  String get blackoutDates;
  String get addBlackout;
  String get noBlackouts;
  String get bufferBetween;
  String get saveSchedule;
  String get scheduleSaved;
  String get from;
  String get to;
  String get add;
  String get cancel;
  String get reason;
  String get searchClients;
  String get noClients;
  String get noClientsBody;
  String get sortRecent;
  String get sortValue;
  String get sortSessions;
  String get sessions;
  String get lifetimeValue;
  String get lastSession;
  String get birthDetails;
  String get privateNotes;
  String get notesHint;
  String get saveNotes;
  String get earnings;
  String get gross;
  String get commission;
  String get net;
  String get pendingBalance;
  String get availableBalance;
  String get rangeToday;
  String get rangeWeek;
  String get rangeMonth;
  String get rangeYear;
  String get noEarnings;
  String get withdraw;
  String get payoutAccount;
  String get addPayoutAccount;
  String get payoutAccountBody;
  String get accountHolder;
  String get accountNumber;
  String get bankName;
  String get walletId;
  String get upiId;
  String get saveAccount;
  String get verificationPending;
  String get verified;
  String get withdrawAmount;
  String get withdrawAll;
  String get processingFee;
  String get youWillReceive;
  String get requestPayout;
  String get payoutRequested;
  String get payoutHistory;
  String get noPayouts;
  String get payoutRequestedStatus;
  String get payoutProcessing;
  String get payoutPaid;
  String get payoutFailed;
  String get taxDocuments;
  String get financialYear;
  String get download;
  String get pricing;
  String get perMinute;
  String get freeFirstMinutes;
  String get freeMinutesNote;
  String get savePricing;
  String get pricingSaved;
  String get notOffered;
  String get reviews;
  String get needsReply;
  String get allReviews;
  String get critical;
  String get writeReply;
  String get replyHint;
  String get sendReply;
  String get replyPosted;
  String get noReviews;
  String get analytics;
  String get totalSessions;
  String get totalMinutes;
  String get avgSession;
  String get avgEarning;
  String get byChannel;
  String get earningsTrend;

  String get boost;
  String get popular;
  String get boostBody;
  String get activeBoosts;
  String get pastBoosts;
  String get choosePlan;
  String get placementTopOfList;
  String get placementHomeRail;
  String get placementTargeted;
  String get daysLabel;
  String get estimatedImpressions;
  String get perDay;
  String get buyBoost;
  String get boostBought;
  String get cannotAfford;
  String get impressions;
  String get profileViews;
  String get consultationsFromBoost;
  String get costPerConsultation;
  String get daysLeft;
  String get noBoosts;
  String get noBoostsBody;

  String placementName(BoostPlacement value);
  String weekdayShort(int weekday);
  String statusName(ApplicationStatus value);
  String rangeName(EarningsRange value);
  String payoutStatusName(PayoutStatus value);
  String destinationName(PayoutDestination value);
  String stepName(KycStep value);

  /// "3 of 5"
  String stepCounter(String current, String total);

  /// "12 min"
  String minutesLabel(String minutes);
}
