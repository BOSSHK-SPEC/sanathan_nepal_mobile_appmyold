part of 'puja_strings.dart';

class _Hi extends PujaStrings {
  const _Hi();

  @override
  String get pujas => 'ऑनलाइन पूजा';

  @override
  String get pujasSubtitle =>
      'मंदिर के पुजारी आपके नाम से पूजा करते हैं, लाइव प्रसारण सहित।';

  @override
  String get myPujas => 'मेरी पूजाएँ';

  @override
  String get bookPuja => 'यह पूजा बुक करें';

  @override
  String get chooseMode => 'कैसे कराएँ?';

  @override
  String get modeOnline => 'मंदिर में, लाइव प्रसारण';

  @override
  String get modeOnlineNote =>
      'पुजारी आपके नाम से करते हैं। लाइव देखें, प्रसाद कूरियर से आएगा।';

  @override
  String get modeAtHome => 'आपके घर पर';

  @override
  String get modeAtHomeNote => 'पुजारी सारी सामग्री लेकर आपके यहाँ आते हैं।';

  @override
  String get chooseDate => 'तिथि चुनें';

  @override
  String get chooseMuhurta => 'मुहूर्त चुनें';

  @override
  String get noMuhurtaTitle => 'इस दिन मुहूर्त शेष नहीं';

  @override
  String get noMuhurtaBody => 'शुभ समय सीमित होते हैं। अगला दिन देखें।';

  @override
  String get sankalpTitle => 'संकल्प विवरण';

  @override
  String get sankalpNote => 'पूजा के समय पुजारी ये नाम बोलते हैं।';

  @override
  String get devoteeName => 'यजमान का नाम';

  @override
  String get gotra => 'गोत्र';

  @override
  String get gotraOptional => 'पता न हो तो खाली छोड़ें';

  @override
  String get rashiNakshatra => 'राशि या नक्षत्र';

  @override
  String get addressTitle => 'पुजारी कहाँ आएँ?';

  @override
  String get addressHint => 'पूरा पता और नज़दीकी पहचान';

  @override
  String get samagriTitle => 'पूजा सामग्री';

  @override
  String get samagriNote => 'पूजा के लिए ज़रूरी सारी सामग्री हम जुटा देते हैं।';

  @override
  String get includeSamagri => 'सामग्री शामिल करें';

  @override
  String get iHaveSamagri => 'मैं स्वयं जुटाऊँगा';

  @override
  String get paymentTitle => 'भुगतान माध्यम';

  @override
  String get summaryTitle => 'सारांश';

  @override
  String get basePriceLabel => 'पूजा';

  @override
  String get samagriLabel => 'सामग्री';

  @override
  String get travelLabel => 'पुजारी यात्रा';

  @override
  String get totalLabel => 'कुल';

  @override
  String get confirmBooking => 'बुकिंग पक्की करें';

  @override
  String get bookedTitle => 'आपकी पूजा बुक हो गई';

  @override
  String get bookedBody =>
      'चुने गए मुहूर्त पर पुजारी आरंभ करेंगे। शुरू होने से पहले याद दिला देंगे।';

  @override
  String get viewBooking => 'बुकिंग देखें';

  @override
  String get upcomingPujas => 'आगामी';

  @override
  String get pastPujas => 'संपन्न';

  @override
  String get noPujasTitle => 'कोई पूजा बुक नहीं';

  @override
  String get noPujasBody =>
      'बुक की गई पूजाएँ यहाँ दिखेंगी, लाइव लिंक और बाद में रिकॉर्डिंग सहित।';

  @override
  String get browsePujas => 'पूजाएँ देखें';

  @override
  String get joinLive => 'लाइव देखें';

  @override
  String get streamOpensSoon => 'मुहूर्त से 30 मिनट पहले लिंक खुलता है।';

  @override
  String get priest => 'पुजारी';

  @override
  String get temple => 'मंदिर';

  @override
  String get watchRecording => 'रिकॉर्डिंग देखें';

  @override
  String get prasadPhotos => 'तस्वीरें';

  @override
  String get cancelBooking => 'बुकिंग रद्द करें';

  @override
  String get cancelReasonHint => 'क्यों रद्द कर रहे हैं?';

  @override
  String get cancelConfirmTitle => 'यह पूजा रद्द करें?';

  @override
  String get cancelConfirmBody =>
      'पुजारी और मुहूर्त छोड़ दिए जाएँगे। यह वापस नहीं होगा।';

  @override
  String get cancelled => 'रद्द';

  @override
  String get cannotCancel => 'मुहूर्त निकट होने से रद्द नहीं हो सकती।';

  @override
  String get recordingUnavailable => 'इस संस्करण में प्ले उपलब्ध नहीं है।';

  @override
  String get duration => 'अवधि';

  @override
  String get procedureTitle => 'कैसे की जाती है';

  @override
  String get bookingsThisMonth => 'इस माह बुक';

  @override
  String get popular => 'सबसे ज़्यादा बुक';

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
    PujaBookingStatus.pendingPayment => 'भुगतान शेष',
    PujaBookingStatus.confirmed => 'पक्की',
    PujaBookingStatus.inProgress => 'चल रही',
    PujaBookingStatus.completed => 'संपन्न',
    PujaBookingStatus.cancelled => 'रद्द',
  };

  @override
  String railName(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => 'eSewa',
    PaymentRail.khalti => 'Khalti',
    PaymentRail.bankTransfer => 'बैंक ट्रांसफ़र',
    PaymentRail.upi => 'UPI',
    PaymentRail.card => 'कार्ड',
    PaymentRail.netBanking => 'नेट बैंकिंग',
    PaymentRail.cashOnDelivery => 'नक़द',
  };

  @override
  String minutes(int value) => '${value.toString().toDevanagariDigits()} मिनट';
}
