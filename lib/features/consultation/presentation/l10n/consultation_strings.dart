import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/entities/session_summary.dart';

part 'consultation_strings_en.dart';
part 'consultation_strings_hi.dart';
part 'consultation_strings_ne.dart';

/// Feature-local strings for live consultations.
abstract class ConsultationStrings {
  const ConsultationStrings();

  static ConsultationStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  // Intake
  String get startConsultation;
  String get consultationType;
  String get yourDetails;
  String get whoIsThisFor;
  String get namePlaceholder;
  String get dateOfBirth;
  String get timeOfBirth;
  String get timeUnknown;
  String get timeUnknownNote;
  String get placeOfBirth;
  String get placePlaceholder;
  String get yourQuestion;
  String get questionPlaceholder;
  String get questionOptional;
  String get ratePerMinute;
  String get yourBalance;
  String get youCanTalkFor;
  String get notEnoughBalance;
  String get addMoney;
  String get startNow;
  String get selectDate;

  // Queue
  String get waitingRoom;
  String get inQueue;
  String get connecting;
  String get ringingBody;
  String get leaveQueue;
  String get leaveQueueConfirm;
  String get leaveQueueBody;
  String get stayInQueue;
  String get noChargeYet;

  // Chat / call
  String get typeMessage;
  String get sessionStarted;
  String get endSession;
  String get endSessionConfirm;
  String get endSessionBody;
  String get keepTalking;
  String get lowBalanceTitle;
  String get outOfBalanceTitle;
  String get lowBalanceBody;
  String get topUpNow;
  String get costSoFar;
  String get astrologerTyping;
  String get muted;
  String get speaker;
  String get camera;
  String get reconnecting;
  String get callEnded;

  // Summary
  String get sessionSummary;
  String get duration;
  String get totalCharged;
  String get astrologerNotes;
  String get remedies;
  String get awaitingNotes;
  String get awaitingNotesBody;
  String get viewTranscript;
  String get playRecording;
  String get rateSession;
  String get bookAgain;
  String get done;
  String get shopRemedy;

  // History
  String get consultationHistory;
  String get noHistory;
  String get noHistoryBody;
  String get findAstrologer;
  String get totalSpent;
  String get totalMinutes;

  String get consoleTitle;
  String get clientDetails;
  String get theirQuestion;
  String get earnedSoFar;
  String get writeUp;
  String get writeUpBody;
  String get notesLabel;
  String get notesHint;
  String get addRemedy;
  String get remedyTitle;
  String get remedyDescription;
  String get saveWriteUp;
  String get writeUpSaved;
  String get noRemedies;
  String get addLabel;
  String get skipWriteUp;
  /// Shown on a live chat that has no messages yet — the normal state of a
  /// session that has only just been accepted.
  String get chatEmptyTitle;

  String get chatEmptyBody;

  String get sessionEnded;

  String get clientOnCall;
  String get openChat;
  String get backToCall;
  String get transcript;
  String get recording;
  String get recordingUnavailable;
  String get noTranscript;

  String statusName(ConsultationStatus value);
  String remedyKind(RemedyKind value);

  /// "3 ahead of you"
  String aheadOfYou(String count);

  /// "~ 4 min"
  String estimatedWait(String minutes);

  /// "12 min at रु. 25/min"
  String minutesAtRate(String minutes, String rate);

  String minutesLabel(String minutes);
}
