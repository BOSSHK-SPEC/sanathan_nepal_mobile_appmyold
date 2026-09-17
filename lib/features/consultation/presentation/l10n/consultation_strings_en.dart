part of 'consultation_strings.dart';

class _En extends ConsultationStrings {
  const _En();
  @override
  String get startConsultation => 'Start consultation';
  @override
  String get consultationType => 'How would you like to talk?';
  @override
  String get yourDetails => 'Birth details';
  @override
  String get whoIsThisFor => 'Who is this reading for?';
  @override
  String get namePlaceholder => 'Full name';
  @override
  String get dateOfBirth => 'Date of birth';
  @override
  String get timeOfBirth => 'Time of birth';
  @override
  String get timeUnknown => 'I do not know the time';
  @override
  String get timeUnknownNote =>
      'The astrologer will use Prashna instead of a birth chart.';
  @override
  String get placeOfBirth => 'Place of birth';
  @override
  String get placePlaceholder => 'City or district';
  @override
  String get yourQuestion => 'What would you like to ask?';
  @override
  String get questionPlaceholder =>
      'A short question helps the astrologer prepare…';
  @override
  String get questionOptional => 'Optional';
  @override
  String get ratePerMinute => 'Rate';
  @override
  String get yourBalance => 'Your balance';
  @override
  String get youCanTalkFor => 'You can talk for';
  @override
  String get notEnoughBalance => 'Add money to start this consultation';
  @override
  String get addMoney => 'Add money';
  @override
  String get startNow => 'Start now';
  @override
  String get selectDate => 'Select';
  @override
  String get waitingRoom => 'Waiting room';
  @override
  String get inQueue => 'You are in the queue';
  @override
  String get connecting => 'Connecting you now';
  @override
  String get ringingBody =>
      'The astrologer is being notified. This usually takes a few seconds.';
  @override
  String get leaveQueue => 'Leave queue';
  @override
  String get leaveQueueConfirm => 'Leave the queue?';
  @override
  String get leaveQueueBody =>
      'You will lose your place. Nothing has been charged.';
  @override
  String get stayInQueue => 'Stay';
  @override
  String get noChargeYet => 'You are not charged until the session starts';
  @override
  String get typeMessage => 'Type a message';
  @override
  String get sessionStarted => 'Session started';
  @override
  String get endSession => 'End';
  @override
  String get endSessionConfirm => 'End this session?';
  @override
  String get endSessionBody =>
      'You will be charged for the minutes used so far.';
  @override
  String get keepTalking => 'Keep talking';
  @override
  String get lowBalanceTitle => 'Balance running low';
  @override
  String get outOfBalanceTitle => 'Out of balance';
  @override
  String get lowBalanceBody =>
      'Top up to keep the session going, or end it now.';
  @override
  String get topUpNow => 'Top up';
  @override
  String get costSoFar => 'Cost so far';
  @override
  String get astrologerTyping => 'typing…';
  @override
  String get muted => 'Muted';
  @override
  String get speaker => 'Speaker';
  @override
  String get camera => 'Camera';
  @override
  String get reconnecting => 'Reconnecting…';
  @override
  String get callEnded => 'Call ended';
  @override
  String get connectingCall => 'Connecting…';
  @override
  String get callFailed => 'Could not connect the call';
  @override
  String get retry => 'Retry';
  @override
  String get waitingForOther => 'Waiting for them to join…';
  @override
  String get cameraOff => 'Camera off';
  @override
  String get sessionSummary => 'Session summary';
  @override
  String get duration => 'Duration';
  @override
  String get totalCharged => 'Total charged';
  @override
  String get astrologerNotes => 'Notes from your astrologer';
  @override
  String get remedies => 'Suggested remedies';
  @override
  String get awaitingNotes => 'Notes are on the way';
  @override
  String get awaitingNotesBody =>
      'Your astrologer usually adds notes within a few hours. We will notify '
      'you.';
  @override
  String get viewTranscript => 'View transcript';
  @override
  String get playRecording => 'Play recording';
  @override
  String get rateSession => 'Rate this session';
  @override
  String get bookAgain => 'Consult again';
  @override
  String get done => 'Done';
  @override
  String get shopRemedy => 'Shop';
  @override
  String get consultationHistory => 'My consultations';
  @override
  String get noHistory => 'No consultations yet';
  @override
  String get noHistoryBody =>
      'Your past sessions, notes and remedies will appear here.';
  @override
  String get findAstrologer => 'Find an astrologer';
  @override
  String get totalSpent => 'Total spent';
  @override
  String get totalMinutes => 'Total minutes';
  @override
  String get consoleTitle => 'Session';
  @override
  String get clientDetails => 'Client';
  @override
  String get theirQuestion => 'Their question';
  @override
  String get earnedSoFar => 'Earned so far';
  @override
  String get writeUp => 'Write up the session';
  @override
  String get writeUpBody =>
      'Your notes and remedies appear on the seeker\'s summary screen.';
  @override
  String get notesLabel => 'Notes';
  @override
  String get notesHint => 'What you read, and what it means for them.';
  @override
  String get addRemedy => 'Add a remedy';
  @override
  String get remedyTitle => 'Remedy';
  @override
  String get remedyDescription => 'How to do it';
  @override
  String get saveWriteUp => 'Save write-up';
  @override
  String get writeUpSaved => 'Write-up saved';
  @override
  String get noRemedies => 'No remedies added';
  @override
  String get addLabel => 'Add';
  @override
  String get skipWriteUp => 'Do it later';
  @override
  String get chatEmptyTitle => 'Connected';

  @override
  String get chatEmptyBody =>
      'The session is live. Send the first message to begin.';

  @override
  String get sessionEnded => 'Session ended';
  @override
  String get clientOnCall => 'On call with';
  @override
  String get openChat => 'Open chat';
  @override
  String get backToCall => 'Back to call';
  @override
  String get transcript => 'Transcript';
  @override
  String get recording => 'Recording';
  @override
  String get recordingUnavailable => 'The recording is still being prepared.';
  @override
  String get noTranscript => 'This session has no transcript.';
  @override
  String statusName(ConsultationStatus value) => switch (value) {
    ConsultationStatus.queued => 'In queue',
    ConsultationStatus.ringing => 'Connecting',
    ConsultationStatus.active => 'Live',
    ConsultationStatus.completed => 'Completed',
    ConsultationStatus.cancelled => 'Cancelled',
    ConsultationStatus.declined => 'Declined',
    ConsultationStatus.missed => 'Missed',
  };
  @override
  String remedyKind(RemedyKind value) => switch (value) {
    RemedyKind.gemstone => 'Gemstone',
    RemedyKind.mantra => 'Mantra',
    RemedyKind.puja => 'Puja',
    RemedyKind.donation => 'Donation',
    RemedyKind.fasting => 'Fasting',
    RemedyKind.practice => 'Practice',
  };
  @override
  String aheadOfYou(String count) => '$count ahead of you';
  @override
  String estimatedWait(String minutes) => '~ $minutes min wait';
  @override
  String minutesAtRate(String minutes, String rate) =>
      '$minutes min at $rate/min';
  @override
  String minutesLabel(String minutes) => '$minutes min';
}
