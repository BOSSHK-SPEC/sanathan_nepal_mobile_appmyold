import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../consultation/domain/entities/session_summary.dart';

part 'console_appointment.freezed.dart';

/// Where a booked sitting stands. Mirrors the server's appointment status.
enum ConsoleAppointmentStatus {
  pending,
  confirmed,
  completed,
  cancelled,
  noShow,
  rescheduled,

  /// Live sessions only: nobody answered, or the astrologer declined.
  missed,
  declined;

  /// Still to happen, or happening: the only states an astrologer can act on.
  bool get isOpen => this == pending || this == confirmed;
}

/// Which of the astrologer's appointments to list.
///
/// `past` is everything already over — sittings and finished live sessions
/// alike; an astrologer who only takes live sessions has a history too.
enum AppointmentScope { upcoming, past }

/// A sitting booked ahead, or a live session that already happened.
enum ConsoleAppointmentKind { appointment, consultation }

/// A sitting a seeker booked with this astrologer, seen from the console.
///
/// Carries the client's contact and birth details: what the astrologer needs
/// to prepare, and why the server only returns their own bookings.
@freezed
abstract class ConsoleAppointment with _$ConsoleAppointment {
  const ConsoleAppointment._();

  const factory ConsoleAppointment({
    required String id,

    /// Empty for a live session, which has no booking reference.
    required String reference,
    @Default(ConsoleAppointmentKind.appointment) ConsoleAppointmentKind kind,

    /// `chat`, `voice` or `video` for a live session; null for a sitting.
    String? channel,
    required ConsoleAppointmentStatus status,
    required DateTime startsAt,
    required DateTime endsAt,
    required double price,
    required String currency,
    @Default(1) int quantity,
    String? paymentMethod,
    required String clientId,
    required String clientName,
    @Default('') String clientPhone,
    @Default('') String clientEmail,
    @Default('') String country,

    /// As the client typed it: `YYYY-MM-DD`.
    String? birthDate,

    /// 24-hour `HH:mm`.
    String? birthTime,
    String? birthPlace,
    @Default('') String note,
    String? cancelReason,
    @Default(false) bool hasBirthChart,
    @Default(false) bool hasReceipt,

    /// Short-lived links, present only when one appointment is opened.
    String? birthChartUrl,
    String? receiptUrl,

    /// What the astrologer wrote up after a live session, and what they
    /// prescribed. Sent only when one appointment is opened.
    @Default('') String adviceNotes,
    @Default(<Remedy>[]) List<Remedy> remedies,
    DateTime? followUpAt,
  }) = _ConsoleAppointment;

  Duration get length => endsAt.difference(startsAt);

  bool get isSession => kind == ConsoleAppointmentKind.consultation;

  /// Whether this session has a write-up to show back to the astrologer.
  bool get hasAdvice => adviceNotes.trim().isNotEmpty || remedies.isNotEmpty;

  bool get hasBirthDetails =>
      birthDate != null || birthTime != null || birthPlace != null;

  bool get hasAttachments => hasBirthChart || hasReceipt;

  /// How the sitting went can be recorded once it has begun.
  bool canRecordOutcome(DateTime now) =>
      status.isOpen && !startsAt.isAfter(now);

  /// A sitting can be called off until it ends.
  bool canCancel(DateTime now) => status.isOpen && endsAt.isAfter(now);
}
