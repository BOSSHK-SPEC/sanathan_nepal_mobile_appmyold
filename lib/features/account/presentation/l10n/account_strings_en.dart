part of 'account_strings.dart';

class _En extends AccountStrings {
  const _En();
  @override
  String get addresses => 'Addresses';
  @override
  String get addAddress => 'Add address';
  @override
  String get editAddress => 'Edit address';
  @override
  String get noAddresses => 'No saved addresses';
  @override
  String get noAddressesBody =>
      'Save an address once and checkout stops asking for it.';
  @override
  String get fullName => 'Full name';
  @override
  String get phone => 'Phone';
  @override
  String get addressLine1 => 'Address';
  @override
  String get addressLine2 => 'Apartment, landmark (optional)';
  @override
  String get city => 'City';
  @override
  String get district => 'District';
  @override
  String get state => 'State';
  @override
  String get postalCode => 'Postal code';
  @override
  String get labelHome => 'Home';
  @override
  String get labelWork => 'Work';
  @override
  String get labelOther => 'Other';
  @override
  String get setDefault => 'Set as default';
  @override
  String get defaultLabel => 'Default';
  @override
  String get saveAddress => 'Save address';
  @override
  String get deleteAddress => 'Delete address';
  @override
  String get deleteAddressBody => 'This address will be removed from checkout.';
  @override
  String get delete => 'Delete';
  @override
  String get cancel => 'Cancel';
  @override
  String get security => 'Security';
  @override
  String get signInDetails => 'Sign-in details';
  @override
  String get email => 'Email';
  @override
  String get twoFactor => 'Two-step verification';
  @override
  String get twoFactorNote =>
      'Ask for a code from your phone whenever you sign in on a new device.';
  @override
  String get loginAlerts => 'Alert me about new sign-ins';
  @override
  String get devices => 'Signed-in devices';
  @override
  String get thisDevice => 'This device';
  @override
  String get lastActive => 'Last active';
  @override
  String get revoke => 'Sign out';
  @override
  String get revokeAll => 'Sign out everywhere else';
  @override
  String get revokeAllBody =>
      'Every device except this one will be signed out.';
  @override
  String get staleDeviceNote => 'Not used in over a month';
  @override
  String get privacy => 'Data & privacy';
  @override
  String get exportTitle => 'Download your data';
  @override
  String get exportBody =>
      'We will prepare a copy of your profile, consultations and orders.';
  @override
  String get deleteTitle => 'Delete your account';
  @override
  String get deleteBody =>
      'Your profile, saved charts and history are removed. Completed transactions are kept for legal and tax reasons.';
  @override
  String get requestExport => 'Request download';
  @override
  String get requestDeletion => 'Request deletion';
  @override
  String get requestPending => 'In progress';
  @override
  String get requestNote => 'We respond to data requests within 30 days.';
  @override
  String get confirmDeletion => 'Delete account';
  @override
  String get support => 'Support';
  @override
  String get myTickets => 'My tickets';
  @override
  String get newTicket => 'New ticket';
  @override
  String get noTickets => 'No tickets yet';
  @override
  String get noTicketsBody =>
      'If something goes wrong, open a ticket and we will follow it up.';
  @override
  String get subject => 'Subject';
  @override
  String get subjectHint => 'A short summary';
  @override
  String get topic => 'What is it about?';
  @override
  String get describe => 'What happened?';
  @override
  String get describeHint => 'Include any reference numbers you have.';
  @override
  String get submitTicket => 'Open ticket';
  @override
  String get ticketSubmitted => 'Ticket opened';
  @override
  String get replyHint => 'Write a reply';
  @override
  String get send => 'Send';
  @override
  String get ticketClosed =>
      'This ticket is closed. Open a new one if you still need help.';
  @override
  String get topicPayment => 'Payment';
  @override
  String get topicConsultation => 'Consultation';
  @override
  String get topicOrder => 'Order';
  @override
  String get topicAccount => 'Account';
  @override
  String get topicOther => 'Something else';
  @override
  String get statusOpen => 'Open';
  @override
  String get statusWaitingOnYou => 'Needs your reply';
  @override
  String get statusResolved => 'Resolved';
  @override
  String get statusClosed => 'Closed';
  @override
  String get supportTeam => 'Support';
  @override
  String get offers => 'Offers';
  @override
  String get availableOffers => 'Available';
  @override
  String get usedOffers => 'Used and expired';
  @override
  String get noOffers => 'No offers right now';
  @override
  String get noOffersBody =>
      'Offers appear here during festivals and after your first session.';
  @override
  String get copyCode => 'Copy code';
  @override
  String get codeCopied => 'Code copied';
  @override
  String get expiresIn => 'Expires in';
  @override
  String get expiringSoon => 'Ending soon';
  @override
  String get usedLabel => 'Used';
  @override
  String get expiredLabel => 'Expired';
  @override
  String get minimumSpend => 'Minimum spend';
  @override
  String get referral => 'Invite friends';
  @override
  String get referralBody =>
      'Share your code. You both get wallet credit when they finish their first consultation.';
  @override
  String get yourCode => 'Your code';
  @override
  String get invited => 'Invited';
  @override
  String get joined => 'Joined';
  @override
  String get earnedLabel => 'Earned';
  @override
  String get shareCode => 'Share code';
  @override
  String get perReferral => 'per friend';
  @override
  String labelName(AddressLabel value) => switch (value) {
    AddressLabel.home => labelHome,
    AddressLabel.work => labelWork,
    AddressLabel.other => labelOther,
  };
  @override
  String topicName(TicketTopic value) => switch (value) {
    TicketTopic.payment => topicPayment,
    TicketTopic.consultation => topicConsultation,
    TicketTopic.order => topicOrder,
    TicketTopic.account => topicAccount,
    TicketTopic.other => topicOther,
  };
  @override
  String ticketStatusName(TicketStatus value) => switch (value) {
    TicketStatus.open => statusOpen,
    TicketStatus.waitingOnYou => statusWaitingOnYou,
    TicketStatus.resolved => statusResolved,
    TicketStatus.closed => statusClosed,
  };
  @override
  String daysLabel(String days) => '$days days';
}
