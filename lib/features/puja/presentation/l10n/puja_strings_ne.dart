part of 'puja_strings.dart';

class _Ne extends PujaStrings {
  const _Ne();

  @override
  String get pujas => 'अनलाइन पूजा';

  @override
  String get pujasSubtitle =>
      'मन्दिरका पुजारीले तपाईंको नाममा गर्ने पूजा, प्रत्यक्ष प्रसारण सहित।';

  @override
  String get myPujas => 'मेरा पूजा';

  @override
  String get bookPuja => 'यो पूजा बुक गर्नुहोस्';

  @override
  String get chooseMode => 'कसरी गर्ने?';

  @override
  String get modeOnline => 'मन्दिरमा, प्रत्यक्ष प्रसारण';

  @override
  String get modeOnlineNote =>
      'पुजारीले तपाईंको नाममा गर्नुहुन्छ। प्रत्यक्ष हेर्नुहोस्, प्रसाद कुरियरबाट आउँछ।';

  @override
  String get modeAtHome => 'तपाईंको घरमा';

  @override
  String get modeAtHomeNote => 'पुजारी सबै सामग्री सहित तपाईंकहाँ आउनुहुन्छ।';

  @override
  String get chooseDate => 'मिति छान्नुहोस्';

  @override
  String get chooseMuhurta => 'मुहूर्त छान्नुहोस्';

  @override
  String get noMuhurtaTitle => 'यस दिन मुहूर्त बाँकी छैन';

  @override
  String get noMuhurtaBody => 'शुभ समय सीमित हुन्छ। भोलिको हेर्नुहोस्।';

  @override
  String get sankalpTitle => 'संकल्प विवरण';

  @override
  String get sankalpNote => 'पूजाको समयमा पुजारीले यी नाम उच्चारण गर्नुहुन्छ।';

  @override
  String get devoteeName => 'यजमानको नाम';

  @override
  String get gotra => 'गोत्र';

  @override
  String get gotraOptional => 'थाहा नभए खाली छोड्नुहोस्';

  @override
  String get rashiNakshatra => 'राशि वा नक्षत्र';

  @override
  String get addressTitle => 'पुजारी कहाँ आउने?';

  @override
  String get addressHint => 'पूरा ठेगाना र नजिकको चिनारी';

  @override
  String get samagriTitle => 'पूजा सामग्री';

  @override
  String get samagriNote => 'पूजाका लागि चाहिने सबै सामग्री मिलाइदिन्छौँ।';

  @override
  String get includeSamagri => 'सामग्री समावेश गर्नुहोस्';

  @override
  String get iHaveSamagri => 'म आफैँ मिलाउँछु';

  @override
  String get paymentTitle => 'भुक्तानी माध्यम';

  @override
  String get summaryTitle => 'सारांश';

  @override
  String get basePriceLabel => 'पूजा';

  @override
  String get samagriLabel => 'सामग्री';

  @override
  String get travelLabel => 'पुजारी यात्रा';

  @override
  String get totalLabel => 'जम्मा';

  @override
  String get confirmBooking => 'बुकिङ पक्का गर्नुहोस्';

  @override
  String get bookedTitle => 'तपाईंको पूजा बुक भयो';

  @override
  String get bookedBody =>
      'छानिएको मुहूर्तमा पुजारीले सुरु गर्नुहुनेछ। सुरु हुनुअघि सम्झाउनेछौँ।';

  @override
  String get viewBooking => 'बुकिङ हेर्नुहोस्';

  @override
  String get upcomingPujas => 'आउँदै';

  @override
  String get pastPujas => 'सम्पन्न';

  @override
  String get noPujasTitle => 'कुनै पूजा बुक छैन';

  @override
  String get noPujasBody =>
      'बुक गरेका पूजा यहाँ देखिनेछन्, प्रत्यक्ष लिंक र पछि रेकर्डिङ सहित।';

  @override
  String get browsePujas => 'पूजा हेर्नुहोस्';

  @override
  String get joinLive => 'प्रत्यक्ष हेर्नुहोस्';

  @override
  String get streamOpensSoon => 'मुहूर्तभन्दा ३० मिनेट अगाडि लिंक खुल्छ।';

  @override
  String get priest => 'पुजारी';

  @override
  String get temple => 'मन्दिर';

  @override
  String get watchRecording => 'रेकर्डिङ हेर्नुहोस्';

  @override
  String get prasadPhotos => 'तस्बिरहरू';

  @override
  String get cancelBooking => 'बुकिङ रद्द गर्नुहोस्';

  @override
  String get cancelReasonHint => 'किन रद्द गर्दै हुनुहुन्छ?';

  @override
  String get cancelConfirmTitle => 'यो पूजा रद्द गर्ने?';

  @override
  String get cancelConfirmBody => 'पुजारी र मुहूर्त छाडिनेछ। यो फिर्ता हुँदैन।';

  @override
  String get cancelled => 'रद्द भयो';

  @override
  String get cannotCancel => 'मुहूर्त नजिक भएकाले रद्द गर्न मिल्दैन।';

  @override
  String get recordingUnavailable => 'यस संस्करणमा प्ले उपलब्ध छैन।';

  @override
  String get duration => 'अवधि';

  @override
  String get procedureTitle => 'कसरी गरिन्छ';

  @override
  String get bookingsThisMonth => 'यो महिना बुक';

  @override
  String get popular => 'सबैभन्दा धेरै बुक';

  @override
  String purposeName(PujaPurpose purpose) => switch (purpose) {
    PujaPurpose.prosperity => 'धन',
    PujaPurpose.health => 'स्वास्थ्य',
    PujaPurpose.marriage => 'विवाह',
    PujaPurpose.career => 'करियर',
    PujaPurpose.protection => 'रक्षा',
    PujaPurpose.ancestors => 'पितृ',
    PujaPurpose.education => 'शिक्षा',
  };

  @override
  String statusName(PujaBookingStatus status) => switch (status) {
    PujaBookingStatus.pendingPayment => 'भुक्तानी बाँकी',
    PujaBookingStatus.confirmed => 'पक्का भयो',
    PujaBookingStatus.inProgress => 'चलिरहेको',
    PujaBookingStatus.completed => 'सम्पन्न',
    PujaBookingStatus.cancelled => 'रद्द',
  };

  @override
  String railName(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => 'eSewa',
    PaymentRail.khalti => 'Khalti',
    PaymentRail.bankTransfer => 'बैंक ट्रान्सफर',
    PaymentRail.upi => 'UPI',
    PaymentRail.card => 'कार्ड',
    PaymentRail.netBanking => 'नेट बैंकिङ',
    PaymentRail.cashOnDelivery => 'नगद',
  };

  @override
  String minutes(int value) => '${value.toString().toDevanagariDigits()} मिनेट';
}
