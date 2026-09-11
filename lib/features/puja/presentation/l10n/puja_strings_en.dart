part of 'puja_strings.dart';

class _En extends PujaStrings {
  const _En();

  @override
  String get pujas => 'Online puja';

  @override
  String get pujasSubtitle =>
      'Rituals performed by temple priests in your name, streamed live.';

  @override
  String get myPujas => 'My pujas';

  @override
  String get bookPuja => 'Book this puja';

  @override
  String get chooseMode => 'How should it be performed?';

  @override
  String get modeOnline => 'At the temple, streamed';

  @override
  String get modeOnlineNote =>
      'Priests perform it in your name. Watch live and receive prasad by courier.';

  @override
  String get modeAtHome => 'At your home';

  @override
  String get modeAtHomeNote =>
      'A priest travels to you with everything needed.';

  @override
  String get chooseDate => 'Pick a date';

  @override
  String get chooseMuhurta => 'Pick a muhurta';

  @override
  String get noMuhurtaTitle => 'No muhurta left on this day';

  @override
  String get noMuhurtaBody => 'Auspicious hours are limited. Try the next day.';

  @override
  String get sankalpTitle => 'Sankalp details';

  @override
  String get sankalpNote => 'The priest recites these names during the ritual.';

  @override
  String get devoteeName => 'Name of the devotee';

  @override
  String get gotra => 'Gotra';

  @override
  String get gotraOptional => 'Leave blank if you do not know it';

  @override
  String get rashiNakshatra => 'Rashi or nakshatra';

  @override
  String get addressTitle => 'Where should the priest come?';

  @override
  String get addressHint => 'Full address with a landmark';

  @override
  String get samagriTitle => 'Puja samagri';

  @override
  String get samagriNote =>
      'All the materials the ritual needs, arranged for you.';

  @override
  String get includeSamagri => 'Include samagri';

  @override
  String get iHaveSamagri => 'I will arrange it myself';

  @override
  String get paymentTitle => 'Payment method';

  @override
  String get summaryTitle => 'Summary';

  @override
  String get basePriceLabel => 'Puja';

  @override
  String get samagriLabel => 'Samagri';

  @override
  String get travelLabel => 'Priest travel';

  @override
  String get totalLabel => 'Total';

  @override
  String get confirmBooking => 'Confirm booking';

  @override
  String get bookedTitle => 'Your puja is booked';

  @override
  String get bookedBody =>
      'The priest will begin at the muhurta you chose. We will remind you before it starts.';

  @override
  String get viewBooking => 'View booking';

  @override
  String get upcomingPujas => 'Upcoming';

  @override
  String get pastPujas => 'Completed';

  @override
  String get noPujasTitle => 'No pujas booked';

  @override
  String get noPujasBody =>
      'Pujas you book appear here, with the live link and the recording afterwards.';

  @override
  String get browsePujas => 'Browse pujas';

  @override
  String get joinLive => 'Join live';

  @override
  String get streamOpensSoon =>
      'The live link opens 30 minutes before the muhurta.';

  @override
  String get priest => 'Priest';

  @override
  String get temple => 'Temple';

  @override
  String get watchRecording => 'Watch the recording';

  @override
  String get prasadPhotos => 'Photos';

  @override
  String get cancelBooking => 'Cancel booking';

  @override
  String get cancelReasonHint => 'Why are you cancelling?';

  @override
  String get cancelConfirmTitle => 'Cancel this puja?';

  @override
  String get cancelConfirmBody =>
      'The priest and the muhurta are released. This cannot be undone.';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get cannotCancel => 'Too close to the muhurta to cancel.';

  @override
  String get recordingUnavailable =>
      'Playback is not available in this build yet.';

  @override
  String get duration => 'Duration';

  @override
  String get procedureTitle => 'How it is performed';

  @override
  String get bookingsThisMonth => 'booked this month';

  @override
  String get popular => 'Most booked';

  @override
  String purposeName(PujaPurpose purpose) => switch (purpose) {
    PujaPurpose.prosperity => 'Wealth',
    PujaPurpose.health => 'Health',
    PujaPurpose.marriage => 'Marriage',
    PujaPurpose.career => 'Career',
    PujaPurpose.protection => 'Protection',
    PujaPurpose.ancestors => 'Ancestors',
    PujaPurpose.education => 'Education',
  };

  @override
  String statusName(PujaBookingStatus status) => switch (status) {
    PujaBookingStatus.pendingPayment => 'Payment due',
    PujaBookingStatus.confirmed => 'Confirmed',
    PujaBookingStatus.inProgress => 'In progress',
    PujaBookingStatus.completed => 'Completed',
    PujaBookingStatus.cancelled => 'Cancelled',
  };

  @override
  String railName(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => 'eSewa',
    PaymentRail.khalti => 'Khalti',
    PaymentRail.bankTransfer => 'Bank transfer',
    PaymentRail.upi => 'UPI',
    PaymentRail.card => 'Card',
    PaymentRail.netBanking => 'Net banking',
    PaymentRail.cashOnDelivery => 'Pay in person',
  };

  @override
  String minutes(int value) => '$value minutes';
}
