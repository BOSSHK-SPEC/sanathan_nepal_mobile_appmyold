import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/account_entities.dart';

part 'account_strings_en.dart';
part 'account_strings_hi.dart';
part 'account_strings_ne.dart';

/// Feature-local strings for addresses, security, privacy, support,
/// offers and referrals.
abstract class AccountStrings {
  const AccountStrings();

  static AccountStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  String get addresses;
  String get addAddress;
  String get editAddress;
  String get noAddresses;
  String get noAddressesBody;
  String get fullName;
  String get phone;
  String get addressLine1;
  String get addressLine2;
  String get city;
  String get district;
  String get state;
  String get postalCode;
  String get labelHome;
  String get labelWork;
  String get labelOther;
  String get setDefault;
  String get defaultLabel;
  String get saveAddress;
  String get deleteAddress;
  String get deleteAddressBody;
  String get delete;
  String get cancel;
  String get security;
  String get signInDetails;
  String get email;
  String get twoFactor;
  String get twoFactorNote;
  String get loginAlerts;
  String get devices;
  String get thisDevice;
  String get lastActive;
  String get revoke;
  String get revokeAll;
  String get revokeAllBody;
  String get staleDeviceNote;
  String get privacy;
  String get exportTitle;
  String get exportBody;
  String get deleteTitle;
  String get deleteBody;
  String get requestExport;
  String get requestDeletion;
  String get requestPending;
  String get requestNote;
  String get confirmDeletion;
  String get support;
  String get myTickets;
  String get newTicket;
  String get noTickets;
  String get noTicketsBody;
  String get subject;
  String get subjectHint;
  String get topic;
  String get describe;
  String get describeHint;
  String get submitTicket;
  String get ticketSubmitted;
  String get replyHint;
  String get send;
  String get ticketClosed;
  String get topicPayment;
  String get topicConsultation;
  String get topicOrder;
  String get topicAccount;
  String get topicOther;
  String get statusOpen;
  String get statusWaitingOnYou;
  String get statusResolved;
  String get statusClosed;
  String get supportTeam;
  String get offers;
  String get availableOffers;
  String get usedOffers;
  String get noOffers;
  String get noOffersBody;
  String get copyCode;
  String get codeCopied;
  String get expiresIn;
  String get expiringSoon;
  String get usedLabel;
  String get expiredLabel;
  String get minimumSpend;
  String get referral;
  String get referralBody;
  String get yourCode;
  String get invited;
  String get joined;
  String get earnedLabel;
  String get shareCode;
  String get perReferral;

  String labelName(AddressLabel value);
  String topicName(TicketTopic value);
  String ticketStatusName(TicketStatus value);

  /// "3 days"
  String daysLabel(String days);
}
