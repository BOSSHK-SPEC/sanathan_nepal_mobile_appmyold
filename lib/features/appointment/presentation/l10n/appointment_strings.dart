import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';

/// Feature-local strings for the appointment feature.
abstract class AppointmentStrings {
  const AppointmentStrings();

  static AppointmentStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get appointment;
  String get appointmentDetails;
  String get bookNow;
  String get tabMyAppointments;
  String get book;
  String get reviews;
  String get upcoming;
  String get past;
  String get bookAppointment;
  String get myAppointments;
  String get noUpcomingTitle;
  String get noUpcomingBody;
  String get noPastTitle;
  String get noPastBody;
  String get chooseAstrologer;
  String get chooseAstrologerBody;
  String get viewProfile;
  String get noAstrologers;
  String get noAppointments;
  String get youHave;
  String get withAstrologer;
  String get stepBasicInfo;
  String get stepDetails;
  String get stepPayment;
  String get service;
  String get numberOf;
  String get selectDate;

  /// Gregorian-side label of the calendar toggle ("A.D"); the traditional
  /// side comes from `TraditionalCalendar.eraLabel`.
  String get ad;
  String get timeZone;
  String get selectTime;
  String get noSlots;
  String get next;
  String get back;
  String get fullName;
  String get email;
  String get phoneNumber;
  String get country;
  String get cheenaNote;
  String get uploadCheena;
  String get selectFile;
  String get noCheenaNote;
  String get birthPlace;
  String get birthDate;
  String get birthTime;
  String get notes;
  String get time;
  String get total;
  String get paymentMethod;
  String get esewa;
  String get khalti;
  String get bankTransfer;
  String get upi;
  String get card;
  String get netBanking;
  String get cash;
  String get bankDetails;
  String get bankName;
  String get accountHolder;
  String get accountNumber;
  String get bankCode;
  String get uploadReceipt;
  String get receiptNote;

  /// "Online now" / "Book later" — an offline astrologer is still bookable.
  String get onlineNow;
  String get bookLater;

  /// "30 min", with the number already in the reader's digits.
  String minutesLabel(String minutes);

  /// "₹1,000/min × 30 min" — where the sitting's total came from.
  String rateBreakdown(String rate, String minutes);

  String get confirmBooking;
  String get bookingSuccess;
  String get status;
  String get statusBooked;
  String get statusCompleted;
  String get statusCancelled;
  String get astrologer;
  String get call;
  String get chat;
  String get reschedule;
  String get cancelAppointment;
  String get cancelConfirm;
  String get keep;
  String get yesCancel;
  String get cancelled;
  String get rescheduled;
  String get date;
  String get quantity;
  String get personDetails;

  /// Shown once a file is attached: these are private documents stored by
  /// id, so there is no preview to draw.
  String get fileAttached;

  /// Labels for the same files once they are only being read back.
  String get cheenaAttachment;
  String get receiptAttachment;
  String uploadHint(String maxSize);
  String get requiredField;
  String get invalidEmail;

  /// Shown instead of the wizard when a astrologer lists nothing to book.
  String get noServicesTitle;
  String get noServicesBody;
  String get selectSlotFirst;
  String get order;
  String get allCategories;
  String get orderNote;
  String get close;
  String get priceRange;
  String get noProducts;

  /// Localised label for a region payment rail (config-driven).
  String rail(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => esewa,
    PaymentRail.khalti => khalti,
    PaymentRail.bankTransfer => bankTransfer,
    PaymentRail.upi => upi,
    PaymentRail.card => card,
    PaymentRail.netBanking => netBanking,
    PaymentRail.cashOnDelivery => cash,
  };
}

class _En extends AppointmentStrings {
  @override
  String minutesLabel(String minutes) => '$minutes min';

  @override
  String rateBreakdown(String rate, String minutes) =>
      '$rate/min × $minutes min';

  @override
  String get onlineNow => 'Online now';

  @override
  String get bookLater => 'Book later';

  const _En();
  @override
  String get appointment => 'Appointment';
  @override
  String get appointmentDetails => 'Appointment Details';
  @override
  String get bookNow => 'Book Your Appointment Now!';
  @override
  String get tabMyAppointments => 'My Appointments';
  @override
  String get book => 'Book';
  @override
  String get reviews => 'Reviews';
  @override
  String get upcoming => 'Upcoming';
  @override
  String get past => 'Past';
  @override
  String get bookAppointment => 'Book appointment';

  @override
  String get myAppointments => 'My appointments';

  @override
  String get noUpcomingTitle => 'No upcoming appointments';

  @override
  String get noUpcomingBody =>
      'Book a sitting with an astrologer or a pandit and it will show up here.';

  @override
  String get noPastTitle => 'Nothing here yet';

  @override
  String get noPastBody =>
      'Appointments you have completed will be listed here.';

  @override
  String get chooseAstrologer => 'Choose who to book with';

  @override
  String get chooseAstrologerBody =>
      'Pick a astrologer to see their services, reviews and available times.';

  @override
  String get viewProfile => 'View profile';

  @override
  String get noAstrologers => 'No astrologers available in your region yet.';

  @override
  String get noAppointments => 'You don’t have any appointments booked.';
  @override
  String get youHave => 'You have';
  @override
  String get withAstrologer => 'with';
  @override
  String get stepBasicInfo => 'Basic Info';
  @override
  String get stepDetails => 'Details';
  @override
  String get stepPayment => 'Payment';
  @override
  String get service => 'Service';
  @override
  String get numberOf => 'Number of Cheena';
  @override
  String get selectDate => 'Select Date';
  @override
  String get ad => 'A.D';
  @override
  String get timeZone => 'Time zone';
  @override
  String get selectTime => 'Select time';
  @override
  String get noSlots => 'No slots available on this day.';
  @override
  String get next => 'Next';
  @override
  String get back => 'Back';
  @override
  String get fullName => 'Full Name';
  @override
  String get email => 'Email';
  @override
  String get phoneNumber => 'Phone Number';
  @override
  String get country => 'Country';
  @override
  String get cheenaNote =>
      'Please provide your Cheena/Tippan photo OR accurate birth details.';
  @override
  String get uploadCheena => 'Upload Photos of Cheena / Tippan';
  @override
  String get selectFile => 'Select file';
  @override
  String get noCheenaNote =>
      'If you don’t have Cheena, please provide the following information:';
  @override
  String get birthPlace => 'Birth Place';
  @override
  String get birthDate => 'Birth Date';
  @override
  String get birthTime => 'Birth Time';
  @override
  String get notes => 'Notes (optional)';
  @override
  String get time => 'Time';
  @override
  String get total => 'Total';
  @override
  String get paymentMethod => 'Payment method';
  @override
  String get esewa => 'eSewa ID';
  @override
  String get khalti => 'Khalti ID';
  @override
  String get bankTransfer => 'Bank transfer';
  @override
  String get upi => 'UPI';
  @override
  String get card => 'Debit / Credit card';
  @override
  String get netBanking => 'Net banking';
  @override
  String get cash => 'Cash payment';
  @override
  String get bankDetails => 'BANK DETAILS';
  @override
  String get bankName => 'Bank Name';
  @override
  String get accountHolder => 'A/C Holder Name';
  @override
  String get accountNumber => 'Account Number';
  @override
  String get bankCode => 'IFSC Code';
  @override
  String get uploadReceipt => 'Upload Screenshot of Payment Receipt';
  @override
  String get receiptNote =>
      'Please attach payment screenshot for Payment Confirmation.';
  @override
  String get confirmBooking => 'Confirm Booking';
  @override
  String get bookingSuccess => 'Your appointment has been booked!';
  @override
  String get status => 'Status';
  @override
  String get statusBooked => 'Booked';
  @override
  String get statusCompleted => 'Completed';
  @override
  String get statusCancelled => 'Cancelled';
  @override
  String get astrologer => 'Astrologer';
  @override
  String get call => 'Call';
  @override
  String get chat => 'Chat';
  @override
  String get reschedule => 'Reschedule';
  @override
  String get cancelAppointment => 'Cancel Appointment';
  @override
  String get cancelConfirm =>
      'Are you sure you want to cancel this appointment?';
  @override
  String get keep => 'Keep';
  @override
  String get yesCancel => 'Yes, cancel';
  @override
  String get cancelled => 'Appointment cancelled.';
  @override
  String get rescheduled => 'Appointment rescheduled.';
  @override
  String get date => 'Date';
  @override
  String get quantity => 'Quantity';
  @override
  String get personDetails => 'Person Details';
  @override
  String get fileAttached => 'File attached';
  @override
  String get cheenaAttachment => 'Cheena / Tippan';
  @override
  String get receiptAttachment => 'Payment receipt';
  @override
  String uploadHint(String maxSize) => 'JPG, PNG or PDF, up to $maxSize';
  @override
  String get requiredField => 'This field is required';
  @override
  String get invalidEmail => 'Enter a valid email address';
  @override
  String get noServicesTitle => 'Nothing to book yet';
  @override
  String get noServicesBody =>
      'This astrologer has not listed any services. Try contacting them '
      'directly, or pick another astrologer.';
  @override
  String get selectSlotFirst => 'Please select a date and time slot.';
  @override
  String get order => 'Order';
  @override
  String get allCategories => 'All';
  @override
  String get orderNote =>
      'To order this product, send the astrologer a message or call them – they will confirm price and delivery.';
  @override
  String get close => 'Close';
  @override
  String get priceRange => 'Price range';
  @override
  String get noProducts => 'No products in this category.';
}

class _Ne extends AppointmentStrings {
  @override
  String minutesLabel(String minutes) => '$minutes मिनेट';

  @override
  String rateBreakdown(String rate, String minutes) =>
      '$rate/मिनेट × $minutes मिनेट';

  @override
  String get onlineNow => 'अहिले अनलाइन';

  @override
  String get bookLater => 'पछिको समय बुक गर्नुहोस्';

  const _Ne();
  @override
  String get appointment => 'अपोइन्टमेन्ट';
  @override
  String get appointmentDetails => 'अपोइन्टमेन्ट विवरण';
  @override
  String get bookNow => 'अहिले नै अपोइन्टमेन्ट बुक गर्नुहोस्!';
  @override
  String get tabMyAppointments => 'मेरा अपोइन्टमेन्ट';
  @override
  String get book => 'बुक';
  @override
  String get reviews => 'प्रतिक्रियाहरू';
  @override
  String get upcoming => 'आगामी';
  @override
  String get past => 'विगत';
  @override
  String get bookAppointment => 'अपोइन्टमेन्ट बुक';

  @override
  String get myAppointments => 'मेरा अपोइन्टमेन्ट';

  @override
  String get noUpcomingTitle => 'आउँदो अपोइन्टमेन्ट छैन';

  @override
  String get noUpcomingBody =>
      'ज्योतिषी वा पण्डितसँग समय लिनुहोस्, यहाँ देखिनेछ।';

  @override
  String get noPastTitle => 'यहाँ अझै केही छैन';

  @override
  String get noPastBody => 'सम्पन्न भएका अपोइन्टमेन्ट यहाँ देखिनेछन्।';

  @override
  String get chooseAstrologer => 'कोसँग बुक गर्ने छान्नुहोस्';

  @override
  String get chooseAstrologerBody =>
      'सेवा, समीक्षा र उपलब्ध समय हेर्न सेवा प्रदायक छान्नुहोस्।';

  @override
  String get viewProfile => 'प्रोफाइल हेर्नुहोस्';

  @override
  String get noAstrologers => 'तपाईंको क्षेत्रमा अहिले सेवा प्रदायक छैनन्।';

  @override
  String get noAppointments => 'तपाईंको कुनै अपोइन्टमेन्ट बुक भएको छैन ।';
  @override
  String get youHave => 'तपाईंको';
  @override
  String get withAstrologer => 'सँग';
  @override
  String get stepBasicInfo => 'आधारभूत जानकारी';
  @override
  String get stepDetails => 'विवरण';
  @override
  String get stepPayment => 'पेमेंट';
  @override
  String get service => 'सेवा';
  @override
  String get numberOf => 'चिना संख्या';
  @override
  String get selectDate => 'मिति चयन गर्नुहोस्';
  @override
  String get ad => 'ई.सं.';
  @override
  String get timeZone => 'समय क्षेत्र';
  @override
  String get selectTime => 'समय छान्नुहोस्';
  @override
  String get noSlots => 'यस दिन कुनै समय उपलब्ध छैन ।';
  @override
  String get next => 'अर्को';
  @override
  String get back => 'पछाडि';
  @override
  String get fullName => 'पुरा नाम';
  @override
  String get email => 'इमेल';
  @override
  String get phoneNumber => 'फोन नं.';
  @override
  String get country => 'देश';
  @override
  String get cheenaNote =>
      'कृपया चिना/टिप्पनको फोटो वा सही जन्म विवरण उपलब्ध गराउनुहोस् ।';
  @override
  String get uploadCheena => 'चिना / टिप्पनको फोटो हाल्नुहोस्';
  @override
  String get selectFile => 'फाइल छान्नुहोस्';
  @override
  String get noCheenaNote =>
      'चिना नभएमा कृपया निम्न जानकारी उपलब्ध गराउनुहोस्:';
  @override
  String get birthPlace => 'जन्म स्थान';
  @override
  String get birthDate => 'जन्म मिति';
  @override
  String get birthTime => 'जन्म समय';
  @override
  String get notes => 'टिप्पणी (ऐच्छिक)';
  @override
  String get time => 'समय';
  @override
  String get total => 'जम्मा';
  @override
  String get paymentMethod => 'भुक्तानी माध्यम';
  @override
  String get esewa => 'eSewa ID';
  @override
  String get khalti => 'Khalti ID';
  @override
  String get bankTransfer => 'बैंक ट्रान्सफर';
  @override
  String get upi => 'UPI';
  @override
  String get card => 'डेबिट / क्रेडिट कार्ड';
  @override
  String get netBanking => 'नेट बैंकिङ';
  @override
  String get cash => 'नगद भुक्तानी';
  @override
  String get bankDetails => 'बैंक विवरण';
  @override
  String get bankName => 'बैंकको नाम';
  @override
  String get accountHolder => 'खातावालाको नाम';
  @override
  String get accountNumber => 'खाता नम्बर';
  @override
  String get bankCode => 'IFSC कोड';
  @override
  String get uploadReceipt => 'भुक्तानी रसिदको स्क्रिनसट हाल्नुहोस्';
  @override
  String get receiptNote =>
      'भुक्तानी पुष्टिका लागि कृपया भुक्तानीको स्क्रिनसट संलग्न गर्नुहोस् ।';
  @override
  String get confirmBooking => 'बुकिङ पुष्टि गर्नुहोस्';
  @override
  String get bookingSuccess => 'तपाईंको अपोइन्टमेन्ट बुक भयो!';
  @override
  String get status => 'स्थिति';
  @override
  String get statusBooked => 'बुक भएको';
  @override
  String get statusCompleted => 'सम्पन्न';
  @override
  String get statusCancelled => 'रद्द';
  @override
  String get astrologer => 'ज्योतिष';
  @override
  String get call => 'कल';
  @override
  String get chat => 'च्याट';
  @override
  String get reschedule => 'समय परिवर्तन';
  @override
  String get cancelAppointment => 'अपोइन्टमेन्ट रद्द गर्नुहोस्';
  @override
  String get cancelConfirm =>
      'के तपाईं यो अपोइन्टमेन्ट रद्द गर्न निश्चित हुनुहुन्छ?';
  @override
  String get keep => 'राख्नुहोस्';
  @override
  String get yesCancel => 'हो, रद्द गर्नुहोस्';
  @override
  String get cancelled => 'अपोइन्टमेन्ट रद्द गरियो ।';
  @override
  String get rescheduled => 'अपोइन्टमेन्टको समय परिवर्तन गरियो ।';
  @override
  String get date => 'मिति';
  @override
  String get quantity => 'संख्या';
  @override
  String get personDetails => 'व्यक्तिगत विवरण';
  @override
  String get fileAttached => 'फाइल संलग्न भयो';
  @override
  String get cheenaAttachment => 'चिना / टिप्पन';
  @override
  String get receiptAttachment => 'भुक्तानी रसिद';
  @override
  String uploadHint(String maxSize) => 'JPG, PNG वा PDF, $maxSize सम्म';
  @override
  String get requiredField => 'यो फिल्ड आवश्यक छ';
  @override
  String get invalidEmail => 'सही इमेल ठेगाना लेख्नुहोस्';
  @override
  String get noServicesTitle => 'बुक गर्न केही छैन';
  @override
  String get noServicesBody =>
      'यी प्रदायकले कुनै सेवा सूचीबद्ध गर्नुभएको छैन । सिधै सम्पर्क '
      'गर्नुहोस् वा अर्को प्रदायक छान्नुहोस् ।';
  @override
  String get selectSlotFirst => 'कृपया मिति र समय छान्नुहोस् ।';
  @override
  String get order => 'अर्डर';
  @override
  String get allCategories => 'सबै';
  @override
  String get orderNote =>
      'यो उत्पादन अर्डर गर्न प्रदायकलाई सन्देश पठाउनुहोस् वा फोन गर्नुहोस् – उहाँले मूल्य र डेलिभरी पुष्टि गर्नुहुनेछ।';
  @override
  String get close => 'बन्द गर्नुहोस्';
  @override
  String get priceRange => 'मूल्य दायरा';
  @override
  String get noProducts => 'यस वर्गमा कुनै उत्पादन छैन।';
}

class _Hi extends AppointmentStrings {
  @override
  String minutesLabel(String minutes) => '$minutes मिनट';

  @override
  String rateBreakdown(String rate, String minutes) =>
      '$rate/मिनट × $minutes मिनट';

  @override
  String get onlineNow => 'अभी ऑनलाइन';

  @override
  String get bookLater => 'बाद का समय बुक करें';

  const _Hi();
  @override
  String get appointment => 'अपॉइंटमेंट';
  @override
  String get appointmentDetails => 'अपॉइंटमेंट विवरण';
  @override
  String get bookNow => 'अभी अपॉइंटमेंट बुक करें!';
  @override
  String get tabMyAppointments => 'मेरे अपॉइंटमेंट';
  @override
  String get book => 'बुक करें';
  @override
  String get reviews => 'समीक्षाएँ';
  @override
  String get upcoming => 'आगामी';
  @override
  String get past => 'पिछले';
  @override
  String get bookAppointment => 'अपॉइंटमेंट बुक';

  @override
  String get myAppointments => 'मेरी अपॉइंटमेंट';

  @override
  String get noUpcomingTitle => 'कोई आगामी अपॉइंटमेंट नहीं';

  @override
  String get noUpcomingBody => 'ज्योतिषी या पंडित से समय लें, वह यहाँ दिखेगा।';

  @override
  String get noPastTitle => 'यहाँ अभी कुछ नहीं';

  @override
  String get noPastBody => 'पूरी हो चुकी अपॉइंटमेंट यहाँ दिखेंगी।';

  @override
  String get chooseAstrologer => 'किससे बुक करें, चुनें';

  @override
  String get chooseAstrologerBody =>
      'सेवाएँ, समीक्षाएँ और उपलब्ध समय देखने के लिए प्रदाता चुनें।';

  @override
  String get viewProfile => 'प्रोफ़ाइल देखें';

  @override
  String get noAstrologers => 'आपके क्षेत्र में अभी कोई प्रदाता नहीं है।';

  @override
  String get noAppointments => 'आपका कोई अपॉइंटमेंट बुक नहीं है।';
  @override
  String get youHave => 'आपका';
  @override
  String get withAstrologer => 'के साथ';
  @override
  String get stepBasicInfo => 'मूल जानकारी';
  @override
  String get stepDetails => 'विवरण';
  @override
  String get stepPayment => 'भुगतान';
  @override
  String get service => 'सेवा';
  @override
  String get numberOf => 'कुंडलियों की संख्या';
  @override
  String get selectDate => 'तारीख चुनें';
  @override
  String get ad => 'ई.';
  @override
  String get timeZone => 'समय क्षेत्र';
  @override
  String get selectTime => 'समय चुनें';
  @override
  String get noSlots => 'इस दिन कोई समय उपलब्ध नहीं है।';
  @override
  String get next => 'आगे';
  @override
  String get back => 'पीछे';
  @override
  String get fullName => 'पूरा नाम';
  @override
  String get email => 'ईमेल';
  @override
  String get phoneNumber => 'फ़ोन नंबर';
  @override
  String get country => 'देश';
  @override
  String get cheenaNote =>
      'कृपया अपनी जन्मपत्री (कुंडली) की फ़ोटो या सही जन्म विवरण दें।';
  @override
  String get uploadCheena => 'जन्मपत्री / कुंडली की फ़ोटो अपलोड करें';
  @override
  String get selectFile => 'फ़ाइल चुनें';
  @override
  String get noCheenaNote =>
      'यदि आपके पास जन्मपत्री नहीं है, तो कृपया निम्न जानकारी दें:';
  @override
  String get birthPlace => 'जन्म स्थान';
  @override
  String get birthDate => 'जन्म तिथि';
  @override
  String get birthTime => 'जन्म समय';
  @override
  String get notes => 'टिप्पणी (वैकल्पिक)';
  @override
  String get time => 'समय';
  @override
  String get total => 'कुल';
  @override
  String get paymentMethod => 'भुगतान का तरीका';
  @override
  String get esewa => 'eSewa ID';
  @override
  String get khalti => 'Khalti ID';
  @override
  String get bankTransfer => 'बैंक ट्रांसफ़र';
  @override
  String get upi => 'UPI';
  @override
  String get card => 'डेबिट / क्रेडिट कार्ड';
  @override
  String get netBanking => 'नेट बैंकिंग';
  @override
  String get cash => 'नकद भुगतान';
  @override
  String get bankDetails => 'बैंक विवरण';
  @override
  String get bankName => 'बैंक का नाम';
  @override
  String get accountHolder => 'खाताधारक का नाम';
  @override
  String get accountNumber => 'खाता संख्या';
  @override
  String get bankCode => 'IFSC कोड';
  @override
  String get uploadReceipt => 'भुगतान रसीद का स्क्रीनशॉट अपलोड करें';
  @override
  String get receiptNote =>
      'भुगतान की पुष्टि के लिए कृपया भुगतान का स्क्रीनशॉट संलग्न करें।';
  @override
  String get confirmBooking => 'बुकिंग की पुष्टि करें';
  @override
  String get bookingSuccess => 'आपका अपॉइंटमेंट बुक हो गया है!';
  @override
  String get status => 'स्थिति';
  @override
  String get statusBooked => 'बुक किया गया';
  @override
  String get statusCompleted => 'पूर्ण';
  @override
  String get statusCancelled => 'रद्द';
  @override
  String get astrologer => 'ज्योतिषी';
  @override
  String get call => 'कॉल';
  @override
  String get chat => 'चैट';
  @override
  String get reschedule => 'समय बदलें';
  @override
  String get cancelAppointment => 'अपॉइंटमेंट रद्द करें';
  @override
  String get cancelConfirm => 'क्या आप वाकई यह अपॉइंटमेंट रद्द करना चाहते हैं?';
  @override
  String get keep => 'रखें';
  @override
  String get yesCancel => 'हाँ, रद्द करें';
  @override
  String get cancelled => 'अपॉइंटमेंट रद्द कर दिया गया।';
  @override
  String get rescheduled => 'अपॉइंटमेंट का समय बदल दिया गया।';
  @override
  String get date => 'तारीख';
  @override
  String get quantity => 'संख्या';
  @override
  String get personDetails => 'व्यक्तिगत विवरण';
  @override
  String get fileAttached => 'फ़ाइल संलग्न';
  @override
  String get cheenaAttachment => 'जन्मपत्री / कुंडली';
  @override
  String get receiptAttachment => 'भुगतान रसीद';
  @override
  String uploadHint(String maxSize) => 'JPG, PNG या PDF, $maxSize तक';
  @override
  String get requiredField => 'यह फ़ील्ड आवश्यक है';
  @override
  String get invalidEmail => 'सही ईमेल पता दर्ज करें';
  @override
  String get noServicesTitle => 'बुक करने के लिए कुछ नहीं';
  @override
  String get noServicesBody =>
      'इस प्रदाता ने कोई सेवा सूचीबद्ध नहीं की है। सीधे संपर्क करें या '
      'दूसरा प्रदाता चुनें।';
  @override
  String get selectSlotFirst => 'कृपया तारीख और समय चुनें।';
  @override
  String get order => 'ऑर्डर';
  @override
  String get allCategories => 'सभी';
  @override
  String get orderNote =>
      'इस उत्पाद को ऑर्डर करने के लिए प्रदाता को संदेश भेजें या कॉल करें – वे मूल्य और डिलीवरी की पुष्टि करेंगे।';
  @override
  String get close => 'बंद करें';
  @override
  String get priceRange => 'मूल्य सीमा';
  @override
  String get noProducts => 'इस श्रेणी में कोई उत्पाद नहीं है।';
}
