import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_entities.freezed.dart';

// --- Addresses ---------------------------------------------------------

/// What an address is for, which changes the delivery expectation.
enum AddressLabel { home, work, other }

@freezed
abstract class SavedAddress with _$SavedAddress {
  const SavedAddress._();

  const factory SavedAddress({
    required String id,
    required String fullName,
    required String phone,
    required String line1,
    required String city,
    @Default(AddressLabel.home) AddressLabel label,
    @Default('') String line2,

    /// District in Nepal, state in India — the field's meaning is regional,
    /// so it is stored generically and labelled per region in the UI.
    @Default('') String region,
    @Default('') String postalCode,
    @Default(false) bool isDefault,
  }) = _SavedAddress;

  /// Single-line form for order summaries.
  String get summary => [
    line1,
    if (line2.isNotEmpty) line2,
    city,
    if (region.isNotEmpty) region,
    if (postalCode.isNotEmpty) postalCode,
  ].join(', ');

  bool get isValid =>
      fullName.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      line1.trim().isNotEmpty &&
      city.trim().isNotEmpty;
}

// --- Security ----------------------------------------------------------

/// A signed-in device.
@freezed
abstract class DeviceSession with _$DeviceSession {
  const DeviceSession._();

  const factory DeviceSession({
    required String id,
    required String deviceName,
    required String platform,
    required DateTime lastActiveAt,
    @Default('') String location,

    /// The device this list is being viewed on, which cannot be revoked
    /// from here without locking the user out mid-action.
    @Default(false) bool isCurrent,
  }) = _DeviceSession;

  bool get isStale =>
      DateTime.now().difference(lastActiveAt) > const Duration(days: 30);
}

/// Account-level security settings.
@freezed
abstract class SecuritySettings with _$SecuritySettings {
  const SecuritySettings._();

  const factory SecuritySettings({
    @Default('') String phone,
    @Default('') String email,
    @Default(false) bool twoFactorEnabled,
    @Default(false) bool loginAlertsEnabled,
    DateTime? passwordChangedAt,
  }) = _SecuritySettings;

  bool get hasEmail => email.trim().isNotEmpty;
}

// --- Privacy -----------------------------------------------------------

enum DataRequestKind { export, deletion }

enum DataRequestStatus { none, pending, ready, completed, rejected }

/// A DPDP / GDPR-style data request.
@freezed
abstract class DataRequest with _$DataRequest {
  const DataRequest._();

  const factory DataRequest({
    required DataRequestKind kind,
    required DataRequestStatus status,
    DateTime? requestedAt,
    DateTime? readyAt,

    /// Download reference once an export is ready.
    String? downloadRef,
  }) = _DataRequest;

  bool get isOpen =>
      status == DataRequestStatus.pending || status == DataRequestStatus.ready;
}

// --- Support -----------------------------------------------------------

enum TicketStatus { open, waitingOnYou, resolved, closed }

enum TicketTopic { payment, consultation, order, account, other }

@freezed
abstract class TicketMessage with _$TicketMessage {
  const factory TicketMessage({
    required String id,
    required String body,
    required DateTime sentAt,
    @Default(false) bool fromSupport,
    @Default(<String>[]) List<String> attachments,
  }) = _TicketMessage;
}

@freezed
abstract class SupportTicket with _$SupportTicket {
  const SupportTicket._();

  const factory SupportTicket({
    required String id,
    required String reference,
    required String subject,
    required TicketTopic topic,
    required TicketStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(<TicketMessage>[]) List<TicketMessage> messages,
  }) = _SupportTicket;

  bool get isOpen =>
      status == TicketStatus.open || status == TicketStatus.waitingOnYou;

  /// A resolved ticket can still be replied to; a closed one cannot.
  bool get canReply => status != TicketStatus.closed;

  TicketMessage? get lastMessage => messages.isEmpty ? null : messages.last;
}

// --- Offers & referrals ------------------------------------------------

enum OfferKind { firstConsultation, walletBonus, freeMinutes, productDiscount }

@freezed
abstract class Offer with _$Offer {
  const Offer._();

  const factory Offer({
    required String id,
    required String code,
    required String title,
    required String description,
    required OfferKind kind,
    required DateTime expiresAt,
    @Default(false) bool used,

    /// Minimum spend, when the offer has one.
    @Default(0) double minimumSpend,
  }) = _Offer;

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  bool get isUsable => !used && !isExpired;

  int get daysLeft =>
      expiresAt.difference(DateTime.now()).inDays.clamp(0, 9999);

  /// Highlighted when it is nearly gone — an offer that quietly expires is
  /// worth nothing to either side.
  bool get isExpiringSoon => isUsable && daysLeft <= 3;
}

@freezed
abstract class ReferralSummary with _$ReferralSummary {
  const ReferralSummary._();

  const factory ReferralSummary({
    required String code,
    @Default(0) int invited,
    @Default(0) int joined,
    @Default(0) double earned,

    /// What each side gets, for the share message.
    @Default(0) double rewardPerReferral,
  }) = _ReferralSummary;

  /// Invites that have not converted yet.
  int get pending => (invited - joined).clamp(0, invited);

  double get conversionRate => invited == 0 ? 0 : joined / invited;
}
