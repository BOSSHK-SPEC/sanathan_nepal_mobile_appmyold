part of 'console_strings.dart';

class _En extends ConsoleStrings {
  const _En();
  @override
  String get becomeAstrologer => 'Become an astrologer';
  @override
  String get applyIntroTitle => 'Consult on Sanatan';
  @override
  String get applyIntroBody =>
      'Take chat, voice and video consultations on your own schedule. You set your rates and your hours; we handle payments and support.';
  @override
  String get requirements => 'What you will need';
  @override
  String get requirementId => 'A government ID and a selfie';
  @override
  String get requirementExperience => 'Your experience and specialities';
  @override
  String get requirementPricing => 'The rates you want to charge';
  @override
  String get requirementTime => 'About 10 minutes';
  @override
  String get startApplication => 'Start application';
  @override
  String get continueApplication => 'Continue application';
  @override
  String get stepIdentity => 'Identity';
  @override
  String get stepCredentials => 'Experience';
  @override
  String get stepExpertise => 'Expertise';
  @override
  String get stepPricing => 'Pricing';
  @override
  String get stepIntroduction => 'Finish';
  @override
  String get fullName => 'Full name';
  @override
  String get phone => 'Phone number';
  @override
  String get email => 'Email';
  @override
  String get idFront => 'ID — front';
  @override
  String get idBack => 'ID — back';
  @override
  String get selfie => 'Selfie holding your ID';
  @override
  String get certificate => 'Certificate (optional)';
  @override
  String get addressProof => 'Address proof (optional)';
  @override
  String uploadHint(String maxSize) => 'JPG or PNG, up to $maxSize';

  @override
  String get documentAttached => 'Document attached';
  @override
  String get removeDocumentTitle => 'Discard this document?';
  @override
  String removeDocumentMessage(String label) =>
      '$label will be deleted from your application. You can upload it again.';
  @override
  String get removeDocumentConfirm => 'Discard';
  @override
  String get documentRemoved => 'Document discarded';
  @override
  String get yearsExperience => 'Years of experience';
  @override
  String get aboutYou => 'About you';
  @override
  String get aboutYouHint =>
      'How you read, where you trained, what you are known for. At least 40 characters.';
  @override
  String get specialities => 'Specialities';
  @override
  String get languagesYouSpeak => 'Languages you consult in';
  @override
  String get setYourRates => 'Set your per-minute rates';
  @override
  String get ratesNote => 'Leave a channel blank if you do not offer it.';
  @override
  String get youKeep => 'You keep';

  @override
  String bookedSittingCosts(String money, String minutes) =>
      'A $minutes-min booking costs $money';

  @override
  String rateTooHigh(String max) => 'Highest allowed rate is $max/min';
  @override
  String get compliance => 'Notices';

  @override
  String get complianceNeedsAction => 'Needs your attention';

  @override
  String get compliancePast => 'Earlier notices';

  @override
  String get noNoticesTitle => 'Nothing to review';

  @override
  String get noNoticesBody =>
      'Warnings, penalties and policy updates will appear here.';

  @override
  String get acknowledge => 'I understand';

  @override
  String get acknowledged => 'Acknowledged';

  @override
  String get appeal => 'Appeal this';

  @override
  String get appealTitle => 'Appeal this notice';

  @override
  String get appealBody =>
      'Tell us what happened. A person reviews every appeal, usually within three working days.';

  @override
  String get appealReasonHint => 'What happened from your side?';

  @override
  String get submitAppeal => 'Submit appeal';

  @override
  String get appealSubmitted => 'Appeal submitted.';

  @override
  String get underAppeal => 'Under appeal';

  @override
  String get amountWithheld => 'Amount withheld';

  @override
  String get actionRequired => 'What you need to do';

  @override
  String get dueBy => 'Due by';

  @override
  String get overdue => 'Overdue';

  @override
  String get relatedSession => 'Related session';

  @override
  String noticeKind(ComplianceKind kind) => switch (kind) {
    ComplianceKind.policyUpdate => 'Policy update',
    ComplianceKind.qualityWarning => 'Quality warning',
    ComplianceKind.lateResponse => 'Missed requests',
    ComplianceKind.refundIssued => 'Refund issued',
    ComplianceKind.penalty => 'Penalty',
    ComplianceKind.documentExpiring => 'Document expiring',
    ComplianceKind.suspension => 'Suspension',
  };

  @override
  String get workSettings => 'Work settings';

  @override
  String get alerts => 'Alerts';

  @override
  String get newRequestAlerts => 'New request alerts';

  @override
  String get newRequestAlertsNote =>
      'Turn this off and requests will not reach you at all.';

  @override
  String get alertSound => 'Play a sound';

  @override
  String get ringUntilAnswered => 'Keep ringing until answered';

  @override
  String get ringUntilAnsweredNote =>
      'A single alert is easy to miss between sessions.';

  @override
  String get scheduleReminders => 'Schedule reminders';

  @override
  String get payoutAlerts => 'Payout updates';

  @override
  String get reviewAlerts => 'New reviews';

  @override
  String get marketingAlerts => 'Tips and offers';

  @override
  String get quietHours => 'Quiet hours';

  @override
  String get quietHoursNote =>
      'No alerts during this window. Scheduled sessions still notify you.';

  @override
  String get quietFrom => 'From';

  @override
  String get quietTo => 'To';

  @override
  String get requestRouting => 'Which requests reach you';

  @override
  String get channelsYouAccept => 'Channels you accept';

  @override
  String get allChannels => 'All channels';

  @override
  String get maxQueueLength => 'Queue limit';

  @override
  String get maxQueueLengthNote =>
      'New requests stop when this many people are already waiting.';

  @override
  String get noQueueCap => 'No limit';

  @override
  String get autoDeclineAfter => 'Decline unanswered requests after';

  @override
  String get autoDeclineAfterNote =>
      'A seeker should not wait on an offer you did not see.';

  @override
  String get autoAcceptRepeat => 'Auto-accept returning clients';

  @override
  String get autoAcceptRepeatNote =>
      'Requests from people you have consulted before connect straight away.';

  @override
  String seconds(int value) => '$value s';

  @override
  String peopleWaiting(int value) => '$value waiting';

  @override
  String get editProfile => 'Edit public profile';

  @override
  String get profileHeadline => 'Headline';

  @override
  String get profileHeadlineHint => 'One line seekers see under your name.';

  @override
  String get profilePhoto => 'Profile photo';

  @override
  String get profilePhotoHint =>
      'A clear face photo. Seekers skip profiles without one.';

  @override
  String get profileVisibility => 'Visibility';

  @override
  String get hideFromSearch => 'Hide me from search';

  @override
  String get hideFromSearchNote =>
      'Existing clients can still reach you. Use this while you are away.';

  @override
  String get profileStrength => 'Profile strength';

  @override
  String get publishProfile => 'Publish changes';

  @override
  String get profilePublished => 'Profile updated.';

  @override
  String get profilePreview => 'Preview as seeker';

  @override
  String get introVideo => 'Introduction video (optional)';
  @override
  String get introVideoHint => 'A short clip helps seekers choose you.';
  @override
  String get termsTitle => 'Commission and conduct';
  @override
  String get termsBody =>
      'The platform retains a commission on each completed session. You agree to respond to accepted requests, to keep client details confidential, and not to guarantee outcomes.';
  @override
  String get acceptTerms => 'I accept these terms';
  @override
  String get submitApplication => 'Submit application';
  @override
  String get back => 'Back';
  @override
  String get next => 'Next';
  @override
  String stepIncomplete(String what) => 'Add $what to continue';

  @override
  String aboutYouShort(int remaining) =>
      'About you ($remaining more characters)';

  @override
  String get stepIncompleteGeneric => 'Complete this step to continue';
  @override
  String get submittedTitle => 'Application submitted';
  @override
  String get submittedBody =>
      'We review applications within two working days and will notify you.';
  @override
  String get applicationStatus => 'Application status';
  @override
  String get statusSubmitted => 'Submitted';
  @override
  String get statusUnderReview => 'Under review';
  @override
  String get statusMoreInfo => 'More information needed';
  @override
  String get statusApproved => 'Approved';
  @override
  String get statusRejected => 'Not approved';
  @override
  String get statusDraft => 'Draft';
  @override
  String get statusNotStarted => 'Not started';
  @override
  String get reviewerNote => 'Reviewer note';
  @override
  String get fixAndResubmit => 'Fix and resubmit';
  @override
  String get openConsole => 'Open console';
  @override
  String get console => 'Console';
  @override
  String get navQueue => 'Queue';
  @override
  String get navSchedule => 'Schedule';
  @override
  String get navEarnings => 'Earnings';
  @override
  String get navClients => 'Clients';
  @override
  String get switchToPersonal => 'Switch to personal';
  @override
  String get switchToAstrologer => 'Switch to astrologer';
  @override
  String get goOnline => 'Go online';
  @override
  String get goOffline => 'Go offline';
  @override
  String get youAreOnline => 'You are online';
  @override
  String get youAreOffline => 'You are offline';
  @override
  String get setScheduleFirst => 'Set your weekly hours before going online';
  @override
  String get setScheduleAction => 'Set schedule';
  @override
  String get availabilityUnavailable => 'Could not check your availability';
  @override
  String get onlineChangeFailed => 'Could not change your status';
  @override
  String get earningsToday => 'Today';
  @override
  String get earningsWeek => 'This week';
  @override
  String get sessionsToday => 'Sessions';
  @override
  String get waitingNow => 'Waiting';
  @override
  String get yourRating => 'Rating';
  @override
  String get acceptanceRate => 'Acceptance';
  @override
  String get responseTime => 'Response';
  @override
  String get repeatRate => 'Repeat clients';
  @override
  String get acceptanceWarning =>
      'Low acceptance means fewer requests are sent to you';
  @override
  String get ongoingSessions => 'Ongoing consultations';

  @override
  String get rejoin => 'Rejoin';

  @override
  String get liveQueue => 'Waiting now';
  @override
  String get queueEmpty => 'Nobody waiting';
  @override
  String get queueEmptyOffline => 'Go online to start receiving requests.';
  @override
  String get queueEmptyOnline =>
      'You will be notified as soon as someone joins.';
  @override
  String get repeatClient => 'Repeat';
  @override
  String get lowBalanceWarning => 'Low balance';
  @override
  String get newRequest => 'New consultation request';
  @override
  String get accept => 'Accept';
  @override
  String get decline => 'Decline';
  @override
  String get waitingFor => 'Waiting';
  @override
  String get weeklyHours => 'Weekly hours';
  @override
  String get addWindow => 'Add hours';
  @override
  String get copyToWeekdays => 'Copy to all weekdays';
  @override
  String get noWindows => 'No hours set';
  @override
  String get blackoutDates => 'Days off';
  @override
  String get addBlackout => 'Add a day off';
  @override
  String get noBlackouts => 'No days off scheduled';
  @override
  String get bufferBetween => 'Break between sessions';
  @override
  String get saveSchedule => 'Save schedule';
  @override
  String get scheduleSaved => 'Schedule saved';
  @override
  String get from => 'From';
  @override
  String get to => 'To';
  @override
  String get add => 'Add';
  @override
  String get cancel => 'Cancel';
  @override
  String get reason => 'Reason';
  @override
  String get searchClients => 'Search clients';
  @override
  String get noClients => 'No clients yet';
  @override
  String get noClientsBody =>
      'People you consult will appear here with their history.';
  @override
  String get sortRecent => 'Recent';
  @override
  String get sortValue => 'Highest value';
  @override
  String get sortSessions => 'Most sessions';
  @override
  String get sessions => 'sessions';
  @override
  String get lifetimeValue => 'Lifetime value';
  @override
  String get lastSession => 'Last session';
  @override
  String get birthDetails => 'Birth details';
  @override
  String get privateNotes => 'Your private notes';
  @override
  String get notesHint => 'Only you can see these.';
  @override
  String get saveNotes => 'Save notes';
  @override
  String get earnings => 'Earnings';
  @override
  String get gross => 'Gross';
  @override
  String get commission => 'Commission';
  @override
  String get net => 'You earned';
  @override
  String get pendingBalance => 'Pending';
  @override
  String get availableBalance => 'Available to withdraw';
  @override
  String get rangeToday => 'Today';
  @override
  String get rangeWeek => 'Week';
  @override
  String get rangeMonth => 'Month';
  @override
  String get rangeYear => 'Year';
  @override
  String get noEarnings => 'No earnings in this range';
  @override
  String get withdraw => 'Withdraw';
  @override
  String get payoutAccount => 'Payout account';
  @override
  String get addPayoutAccount => 'Add a payout account';
  @override
  String get payoutAccountBody =>
      'We need somewhere to send your earnings before you can withdraw.';
  @override
  String get accountHolder => 'Account holder name';
  @override
  String get accountNumber => 'Account number';
  @override
  String get bankName => 'Bank name';
  @override
  String get walletId => 'Wallet ID';
  @override
  String get upiId => 'UPI ID';
  @override
  String get saveAccount => 'Save account';
  @override
  String get verificationPending =>
      'We are verifying this account. Withdrawals open once it is confirmed.';
  @override
  String get verified => 'Verified';
  @override
  String get withdrawAmount => 'Amount to withdraw';
  @override
  String get withdrawAll => 'All';
  @override
  String get processingFee => 'Processing fee';
  @override
  String get youWillReceive => 'You will receive';
  @override
  String get requestPayout => 'Request payout';
  @override
  String get payoutRequested => 'Payout requested';
  @override
  String get payoutHistory => 'Payout history';
  @override
  String get noPayouts => 'No payouts yet';
  @override
  String get payoutRequestedStatus => 'Requested';
  @override
  String get payoutProcessing => 'Processing';
  @override
  String get payoutPaid => 'Paid';
  @override
  String get payoutFailed => 'Failed';
  @override
  String get taxDocuments => 'Tax documents';
  @override
  String get financialYear => 'Financial year';
  @override
  String get download => 'Download';
  @override
  String get pricing => 'Pricing';
  @override
  String get perMinute => '/min';
  @override
  String get freeFirstMinutes => 'Free minutes for new clients';
  @override
  String get freeMinutesNote =>
      'A short free window raises first-session conversion.';
  @override
  String get savePricing => 'Save pricing';
  @override
  String get pricingSaved => 'Pricing saved';
  @override
  String get notOffered => 'Not offered';
  @override
  String get reviews => 'Reviews';
  @override
  String get needsReply => 'Needs reply';
  @override
  String get allReviews => 'All';
  @override
  String get critical => 'Critical';
  @override
  String get writeReply => 'Write a reply';
  @override
  String get replyHint =>
      'A calm, specific reply reads better than a defensive one.';
  @override
  String get sendReply => 'Post reply';
  @override
  String get replyPosted => 'Reply posted';
  @override
  String get noReviews => 'Nothing to reply to';
  @override
  String get analytics => 'Performance';
  @override
  String get totalSessions => 'Sessions';
  @override
  String get totalMinutes => 'Minutes';
  @override
  String get avgSession => 'Average session';
  @override
  String get avgEarning => 'Average per session';
  @override
  String get byChannel => 'By channel';
  @override
  String get earningsTrend => 'Earnings trend';
  @override
  String get boost => 'Boost';
  @override
  String get popular => 'Popular';
  @override
  String get boostBody =>
      'Pay to appear higher in discovery. You are charged from your available balance.';
  @override
  String get activeBoosts => 'Running now';
  @override
  String get pastBoosts => 'Past boosts';
  @override
  String get choosePlan => 'Choose a plan';
  @override
  String get placementTopOfList => 'Top of search';
  @override
  String get placementHomeRail => 'Featured on home';
  @override
  String get placementTargeted => 'Matched seekers';
  @override
  String get daysLabel => 'days';
  @override
  String get estimatedImpressions => 'Estimated views';
  @override
  String get perDay => 'per day';
  @override
  String get buyBoost => 'Buy boost';
  @override
  String get boostBought => 'Boost started';
  @override
  String get cannotAfford => 'Not enough available balance for this plan.';
  @override
  String get impressions => 'Views';
  @override
  String get profileViews => 'Profile opens';
  @override
  String get consultationsFromBoost => 'Consultations';
  @override
  String get costPerConsultation => 'Cost per consultation';
  @override
  String get daysLeft => 'left';
  @override
  String get noBoosts => 'No boosts yet';
  @override
  String get noBoostsBody =>
      'A boost puts you in front of more seekers for a fixed period.';
  @override
  String placementName(BoostPlacement value) => switch (value) {
    BoostPlacement.topOfList => placementTopOfList,
    BoostPlacement.homeRail => placementHomeRail,
    BoostPlacement.targeted => placementTargeted,
  };
  @override
  String weekdayShort(int weekday) => const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ][(weekday - 1).clamp(0, 6)];
  @override
  String statusName(ApplicationStatus value) => switch (value) {
    ApplicationStatus.notStarted => statusNotStarted,
    ApplicationStatus.draft => statusDraft,
    ApplicationStatus.submitted => statusSubmitted,
    ApplicationStatus.underReview => statusUnderReview,
    ApplicationStatus.moreInfoNeeded => statusMoreInfo,
    ApplicationStatus.approved => statusApproved,
    ApplicationStatus.rejected => statusRejected,
  };
  @override
  String rangeName(EarningsRange value) => switch (value) {
    EarningsRange.today => rangeToday,
    EarningsRange.week => rangeWeek,
    EarningsRange.month => rangeMonth,
    EarningsRange.year => rangeYear,
  };
  @override
  String payoutStatusName(PayoutStatus value) => switch (value) {
    PayoutStatus.requested => payoutRequestedStatus,
    PayoutStatus.processing => payoutProcessing,
    PayoutStatus.paid => payoutPaid,
    PayoutStatus.failed => payoutFailed,
  };
  @override
  String destinationName(PayoutDestination value) => switch (value) {
    PayoutDestination.bankAccount => bankName,
    PayoutDestination.esewa => 'eSewa',
    PayoutDestination.khalti => 'Khalti',
    PayoutDestination.upi => 'UPI',
  };
  @override
  String stepName(KycStep value) => switch (value) {
    KycStep.identity => stepIdentity,
    KycStep.credentials => stepCredentials,
    KycStep.expertise => stepExpertise,
    KycStep.pricing => stepPricing,
    KycStep.introduction => stepIntroduction,
  };
  @override
  String stepCounter(String current, String total) => '$current / $total';
  @override
  String minutesLabel(String minutes) => '$minutes min';

  // --- Appointments ---
  @override
  String get apptTitle => 'Appointments';
  @override
  String get apptUpcomingSection => 'Upcoming appointments';
  @override
  String get apptUpcomingTab => 'Upcoming';
  @override
  String get apptPastTab => 'Past';
  @override
  String get apptSeeAll => 'See all';
  @override
  String get apptNoUpcoming => 'No upcoming appointments';
  @override
  String get apptNoUpcomingHint =>
      'When someone books a sitting with you, it appears here with their details.';
  @override
  String get apptNoPast => 'No past appointments yet';
  @override
  String get apptDetails => 'Appointment';
  @override
  String get apptClient => 'Client';
  @override
  String get apptPhone => 'Phone';
  @override
  String get apptEmail => 'Email';
  @override
  String get apptCountry => 'Country';
  @override
  String get apptCall => 'Call';
  @override
  String get apptWhatsapp => 'WhatsApp';
  @override
  String get apptBirthDetails => 'Birth details';
  @override
  String get apptBirthDate => 'Date of birth';
  @override
  String get apptBirthTime => 'Time of birth';
  @override
  String get apptBirthPlace => 'Place of birth';
  @override
  String get apptBirthMissing => 'The client did not give their birth details.';
  @override
  String get apptClientNote => 'Note from the client';
  @override
  String get apptAttachments => 'Attachments';
  @override
  String get apptBirthChart => 'Birth chart (cheena)';
  @override
  String get apptReceipt => 'Payment receipt';
  @override
  String get apptOpenFile => 'Open';
  @override
  String get apptFileUnavailable => 'This file is no longer available.';
  @override
  String get apptSitting => 'Sitting';
  @override
  String get apptType => 'Type';
  @override
  String get apptAdvice => 'What you advised';
  @override
  String get apptFollowUp => 'Follow-up';
  @override
  String get apptWhen => 'When';
  @override
  String get apptLength => 'Length';
  @override
  String get apptAmount => 'Amount';
  @override
  String get apptPayment => 'Payment';
  @override
  String get apptMarkCompleted => 'Mark as completed';
  @override
  String get apptMarkNoShow => 'Client did not come';
  @override
  String get apptCancel => 'Cancel appointment';
  @override
  String get apptOutcomeAfterStart =>
      'You can mark how it went once the sitting starts.';
  @override
  String get apptCancelTitle => 'Cancel this appointment?';
  @override
  String get apptCancelBody =>
      'The client will see that you cancelled, with your reason, and the time goes back on your calendar.';
  @override
  String get apptCancelReasonHint => 'Reason for the client';
  @override
  String get apptCancelReasonTooShort => 'Tell the client why, in a few words.';
  @override
  String get apptConfirmCancel => 'Cancel appointment';
  @override
  String get apptKeep => 'Keep it';
  @override
  String get apptMarkedCompleted => 'Marked as completed.';
  @override
  String get apptMarkedNoShow => 'Marked as a no-show.';
  @override
  String get apptCancelled => 'Appointment cancelled.';
  @override
  String get apptCouldNotOpen => 'Could not open it on this phone.';
  @override
  String apptReference(String reference) => 'Booking $reference';
  @override
  String apptSeats(String count) => 'For $count people';
  @override
  String apptStatus(ConsoleAppointmentStatus status) => switch (status) {
    ConsoleAppointmentStatus.pending => 'Pending',
    ConsoleAppointmentStatus.confirmed => 'Confirmed',
    ConsoleAppointmentStatus.completed => 'Completed',
    ConsoleAppointmentStatus.cancelled => 'Cancelled',
    ConsoleAppointmentStatus.noShow => 'No-show',
    ConsoleAppointmentStatus.rescheduled => 'Rescheduled',
    ConsoleAppointmentStatus.missed => 'Missed',
    ConsoleAppointmentStatus.declined => 'Declined',
  };
  @override
  String apptChannel(String? channel) => switch (channel) {
    'chat' => 'Chat',
    'voice' => 'Voice call',
    'video' => 'Video call',
    _ => 'Session',
  };
  @override
  String apptRemedyKind(RemedyKind kind) => switch (kind) {
    RemedyKind.gemstone => 'Gemstone',
    RemedyKind.mantra => 'Mantra',
    RemedyKind.puja => 'Puja',
    RemedyKind.donation => 'Donation',
    RemedyKind.fasting => 'Fasting',
    RemedyKind.practice => 'Practice',
  };
}
