import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/user_profile_draft.dart';

/// Feature-local bilingual strings for onboarding / auth.
abstract class OnboardingStrings {
  const OnboardingStrings();

  static OnboardingStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  // Splash
  String get appName;
  String get tagline;

  // Language / theme
  String get welcomeTitle;
  String get selectLanguage;
  String get selectTheme;
  String get lightTheme;
  String get darkTheme;

  // Login
  String get loginWelcome;
  String get loginTitle;
  String get continueWithGoogle;
  String get continueWithApple;
  String get continueWithNumber;

  // Phone sheet
  String get signupWithNumber;
  String get enterMobile;
  String get mobileHint;
  String get next;
  String get phoneHelp;
  String get invalidPhone;

  // OTP
  String get existingUser;
  String get newUser;
  String get enterOtp;
  String otpSentTo(String phone);
  String get login;
  String get verify;
  String get notReceived;
  String get resend;
  String get invalidOtp;

  // Details
  String get detailsTitle;
  String get detailsSubtitle;
  String get fullName;
  String get fullNameHint;
  String get email;
  String get emailHint;
  String get dateOfBirth;

  /// Short toggle label for the region's traditional calendar, keyed by
  /// `TraditionalCalendar.id` (`bs` → "BS", `saka` → "Saka").
  String traditionalEra(String calendarId);

  /// Short toggle label for the Gregorian calendar shown next to
  /// [traditionalEra] (`bs` → "AD", `saka` → "A.D.").
  String gregorianEra(String calendarId);

  /// Picker dialog title, e.g. "Date of Birth (BS)".
  String dateOfBirthIn(String era) => '$dateOfBirth ($era)';
  String get pickDate;
  String get birthTime;
  String get pickTime;
  String get birthPlace;

  /// "e.g. Kathmandu" – [city] is the region's default city.
  String birthPlaceHint(String city);
  String get gender;
  String get male;
  String get female;
  String get other;
  String get horoscopeSign;
  String get selectSign;
  String get requiredField;
  String get invalidEmail;
  String zodiac(ZodiacSign sign);

  // Notification settings
  String get notificationTitle;
  String get notificationSubtitle;
  String get horoscopeSection;
  String get daily;
  String get monthly;
  String get yearly;
  String get notificationTime;
  String get festivalSection;
  String get importantFestivals;
  String get commonFestivals;
  String get publicHolidays;
  String get remindBefore;
  String get daysAt;
  String get birthdaySection;
  String get birthdayReminders;
  String get finish;
}

class _En extends OnboardingStrings {
  const _En();

  @override
  String get appName => 'Sanatan Nepal';
  @override
  String get tagline => 'Patro · Horoscope · Panchanga · Events';

  @override
  String get welcomeTitle => 'Welcome To\nSanatan Nepal';
  @override
  String get selectLanguage => 'Select Language';
  @override
  String get selectTheme => 'Select Theme';
  @override
  String get lightTheme => 'Light';
  @override
  String get darkTheme => 'Dark';

  @override
  String get loginWelcome => 'Welcome to Sanatan Nepal Family!';
  @override
  String get loginTitle => 'Log In';
  @override
  String get continueWithGoogle => 'Continue with Google';
  @override
  String get continueWithApple => 'Continue with Apple';
  @override
  String get continueWithNumber => 'Continue with Number';

  @override
  String get signupWithNumber => 'SIGNUP WITH NUMBER';
  @override
  String get enterMobile => 'Enter your Mobile Number';
  @override
  String get mobileHint => 'Mobile number';
  @override
  String get next => 'NEXT';
  @override
  String get phoneHelp =>
      'You can login easily later using your personal mobile number and OTP. '
      'No need to remember a password.';
  @override
  String get invalidPhone => 'Enter a valid 10-digit mobile number';

  @override
  String get existingUser => 'Existing User';
  @override
  String get newUser => 'New User';
  @override
  String get enterOtp => 'Enter OTP';
  @override
  String otpSentTo(String phone) => 'Code sent to $phone';
  @override
  String get login => 'Log In';
  @override
  String get verify => 'Verify';
  @override
  String get notReceived => 'Not received any code?';
  @override
  String get resend => 'Resend';
  @override
  String get invalidOtp => 'Enter the 6-digit code';

  @override
  String get detailsTitle => 'Enter Your Details';
  @override
  String get detailsSubtitle =>
      'We use these to personalise your horoscope and reminders.';
  @override
  String get fullName => 'Full Name';
  @override
  String get fullNameHint => 'e.g. Kritika Paudel';
  @override
  String get email => 'Email';
  @override
  String get emailHint => 'name@example.com';
  @override
  String get dateOfBirth => 'Date of Birth';
  @override
  String traditionalEra(String calendarId) =>
      calendarId == 'saka' ? 'Saka' : 'BS';
  @override
  String gregorianEra(String calendarId) =>
      calendarId == 'saka' ? 'A.D.' : 'AD';
  @override
  String get pickDate => 'Select date';
  @override
  String get birthTime => 'Birth Time';
  @override
  String get pickTime => 'Select time';
  @override
  String get birthPlace => 'Birth Place';
  @override
  String birthPlaceHint(String city) => 'e.g. $city';
  @override
  String get gender => 'Gender';
  @override
  String get male => 'Male';
  @override
  String get female => 'Female';
  @override
  String get other => 'Other';
  @override
  String get horoscopeSign => 'Horoscope Sign';
  @override
  String get selectSign => 'Select sign';
  @override
  String get requiredField => 'This field is required';
  @override
  String get invalidEmail => 'Enter a valid email';
  @override
  String zodiac(ZodiacSign sign) => switch (sign) {
    ZodiacSign.aries => 'Aries (Mesh)',
    ZodiacSign.taurus => 'Taurus (Brish)',
    ZodiacSign.gemini => 'Gemini (Mithun)',
    ZodiacSign.cancer => 'Cancer (Karkat)',
    ZodiacSign.leo => 'Leo (Singha)',
    ZodiacSign.virgo => 'Virgo (Kanya)',
    ZodiacSign.libra => 'Libra (Tula)',
    ZodiacSign.scorpio => 'Scorpio (Brischik)',
    ZodiacSign.sagittarius => 'Sagittarius (Dhanu)',
    ZodiacSign.capricorn => 'Capricorn (Makar)',
    ZodiacSign.aquarius => 'Aquarius (Kumbha)',
    ZodiacSign.pisces => 'Pisces (Meen)',
  };

  @override
  String get notificationTitle => 'Notification Settings';
  @override
  String get notificationSubtitle =>
      'Choose what you want to be reminded about. You can change this later.';
  @override
  String get horoscopeSection => 'Horoscope Notification Setting';
  @override
  String get daily => 'Daily';
  @override
  String get monthly => 'Monthly';
  @override
  String get yearly => 'Yearly';
  @override
  String get notificationTime => 'Notification Time';
  @override
  String get festivalSection => 'Festivals Notification Setting';
  @override
  String get importantFestivals => 'Important Hindu Festivals';
  @override
  String get commonFestivals => 'Common Festivals';
  @override
  String get publicHolidays => 'Public Holidays';
  @override
  String get remindBefore => 'Remind me before';
  @override
  String get daysAt => 'days at';
  @override
  String get birthdaySection => 'Birthday Notification Setting';
  @override
  String get birthdayReminders => 'Birthday reminders';
  @override
  String get finish => 'Finish';
}

class _Ne extends OnboardingStrings {
  const _Ne();

  @override
  String get appName => 'सनातन नेपाल';
  @override
  String get tagline => 'पात्रो · राशिफल · पञ्चाङ्ग · चाडपर्व';

  @override
  String get welcomeTitle => 'सनातन नेपालमा\nहजुरलाई स्वागत छ';
  @override
  String get selectLanguage => 'भाषा चयन गर्नुहोस';
  @override
  String get selectTheme => 'थिम रोज्नुहोस्';
  @override
  String get lightTheme => 'उज्यालो थिम';
  @override
  String get darkTheme => 'अँध्यारो थिम';

  @override
  String get loginWelcome => 'सनातन नेपाल परिवारमा स्वागत छ !';
  @override
  String get loginTitle => 'लग-इन गर्नुहोस्';
  @override
  String get continueWithGoogle => 'Continue with Google';
  @override
  String get continueWithApple => 'Continue with Apple';
  @override
  String get continueWithNumber => 'Continue with Number';

  @override
  String get signupWithNumber => 'नम्बरबाट साइन-अप गर्नुहोस्';
  @override
  String get enterMobile => 'आफ्नो मोबाइल नम्बर प्रविष्ट गर्नुहोस्';
  @override
  String get mobileHint => 'मोबाइल नम्बर';
  @override
  String get next => 'अर्को';
  @override
  String get phoneHelp =>
      'पछि आफ्नो मोबाइल नम्बर र OTP प्रयोग गरेर सजिलै लग-इन गर्न सक्नुहुन्छ। '
      'पासवर्ड सम्झनु पर्दैन।';
  @override
  String get invalidPhone => 'मान्य १० अङ्कको मोबाइल नम्बर लेख्नुहोस्';

  @override
  String get existingUser => 'दर्ता भएको प्रयोगकर्ता';
  @override
  String get newUser => 'नयाँ प्रयोगकर्ता';
  @override
  String get enterOtp => 'OTP प्रविष्ट गर्नुहोस्';
  @override
  String otpSentTo(String phone) => '$phone मा कोड पठाइयो';
  @override
  String get login => 'लग-इन';
  @override
  String get verify => 'प्रमाणित गर्नुहोस्';
  @override
  String get notReceived => 'कोड प्राप्त भएन ?';
  @override
  String get resend => 'पुनः पठाउनुहोस्';
  @override
  String get invalidOtp => '६ अङ्कको कोड लेख्नुहोस्';

  @override
  String get detailsTitle => 'आफ्नो विवरण भर्नुहोस्';
  @override
  String get detailsSubtitle =>
      'राशिफल र सम्झौटो व्यक्तिगत बनाउन यी विवरण प्रयोग गरिन्छ।';
  @override
  String get fullName => 'पूरा नाम';
  @override
  String get fullNameHint => 'जस्तै: कृतिका पौडेल';
  @override
  String get email => 'इमेल';
  @override
  String get emailHint => 'name@example.com';
  @override
  String get dateOfBirth => 'जन्म मिति';
  @override
  String traditionalEra(String calendarId) =>
      calendarId == 'saka' ? 'शक' : 'वि.सं.';
  @override
  String gregorianEra(String calendarId) => 'ई.सं.';
  @override
  String get pickDate => 'मिति छान्नुहोस्';
  @override
  String get birthTime => 'जन्म समय';
  @override
  String get pickTime => 'समय छान्नुहोस्';
  @override
  String get birthPlace => 'जन्म स्थान';
  @override
  String birthPlaceHint(String city) => 'जस्तै: $city';
  @override
  String get gender => 'लिङ्ग';
  @override
  String get male => 'पुरुष';
  @override
  String get female => 'महिला';
  @override
  String get other => 'अन्य';
  @override
  String get horoscopeSign => 'राशि';
  @override
  String get selectSign => 'राशि छान्नुहोस्';
  @override
  String get requiredField => 'यो फिल्ड आवश्यक छ';
  @override
  String get invalidEmail => 'मान्य इमेल लेख्नुहोस्';
  @override
  String zodiac(ZodiacSign sign) => switch (sign) {
    ZodiacSign.aries => 'मेष',
    ZodiacSign.taurus => 'वृष',
    ZodiacSign.gemini => 'मिथुन',
    ZodiacSign.cancer => 'कर्कट',
    ZodiacSign.leo => 'सिंह',
    ZodiacSign.virgo => 'कन्या',
    ZodiacSign.libra => 'तुला',
    ZodiacSign.scorpio => 'वृश्चिक',
    ZodiacSign.sagittarius => 'धनु',
    ZodiacSign.capricorn => 'मकर',
    ZodiacSign.aquarius => 'कुम्भ',
    ZodiacSign.pisces => 'मीन',
  };

  @override
  String get notificationTitle => 'सूचना सेटिङ';
  @override
  String get notificationSubtitle =>
      'कुन कुराको सम्झना चाहनुहुन्छ छान्नुहोस्। पछि परिवर्तन गर्न सकिन्छ।';
  @override
  String get horoscopeSection => 'राशिफल सूचना सेटिङ';
  @override
  String get daily => 'दैनिक';
  @override
  String get monthly => 'मासिक';
  @override
  String get yearly => 'वार्षिक';
  @override
  String get notificationTime => 'सूचना समय';
  @override
  String get festivalSection => 'चाडपर्व सूचना सेटिङ';
  @override
  String get importantFestivals => 'प्रमुख हिन्दू चाडपर्व';
  @override
  String get commonFestivals => 'सामान्य चाडपर्व';
  @override
  String get publicHolidays => 'सार्वजनिक बिदा';
  @override
  String get remindBefore => 'सम्झाउने';
  @override
  String get daysAt => 'दिन अघि, समय';
  @override
  String get birthdaySection => 'जन्मदिन सूचना सेटिङ';
  @override
  String get birthdayReminders => 'जन्मदिन सम्झौटो';
  @override
  String get finish => 'सम्पन्न';
}

class _Hi extends OnboardingStrings {
  const _Hi();

  @override
  String get appName => 'सनातन नेपाल';
  @override
  String get tagline => 'पंचांग · राशिफल · पर्व · आयोजन';

  @override
  String get welcomeTitle => 'सनातन नेपाल में\nआपका स्वागत है';
  @override
  String get selectLanguage => 'भाषा चुनें';
  @override
  String get selectTheme => 'थीम चुनें';
  @override
  String get lightTheme => 'लाइट थीम';
  @override
  String get darkTheme => 'डार्क थीम';

  @override
  String get loginWelcome => 'सनातन नेपाल परिवार में आपका स्वागत है!';
  @override
  String get loginTitle => 'लॉग इन करें';
  @override
  String get continueWithGoogle => 'Google से जारी रखें';
  @override
  String get continueWithApple => 'Apple से जारी रखें';
  @override
  String get continueWithNumber => 'मोबाइल नंबर से जारी रखें';

  @override
  String get signupWithNumber => 'नंबर से साइन-अप करें';
  @override
  String get enterMobile => 'अपना मोबाइल नंबर दर्ज करें';
  @override
  String get mobileHint => 'मोबाइल नंबर';
  @override
  String get next => 'आगे';
  @override
  String get phoneHelp =>
      'बाद में आप अपने मोबाइल नंबर और OTP से आसानी से लॉग इन कर सकते हैं। '
      'पासवर्ड याद रखने की ज़रूरत नहीं।';
  @override
  String get invalidPhone => 'मान्य १० अंकों का मोबाइल नंबर दर्ज करें';

  @override
  String get existingUser => 'पंजीकृत उपयोगकर्ता';
  @override
  String get newUser => 'नया उपयोगकर्ता';
  @override
  String get enterOtp => 'OTP दर्ज करें';
  @override
  String otpSentTo(String phone) => '$phone पर कोड भेजा गया';
  @override
  String get login => 'लॉग इन';
  @override
  String get verify => 'सत्यापित करें';
  @override
  String get notReceived => 'कोड नहीं मिला?';
  @override
  String get resend => 'फिर से भेजें';
  @override
  String get invalidOtp => '६ अंकों का कोड दर्ज करें';

  @override
  String get detailsTitle => 'अपना विवरण भरें';
  @override
  String get detailsSubtitle =>
      'इनका उपयोग आपके राशिफल और रिमाइंडर को व्यक्तिगत बनाने के लिए होता है।';
  @override
  String get fullName => 'पूरा नाम';
  @override
  String get fullNameHint => 'जैसे: कृतिका वर्मा';
  @override
  String get email => 'ईमेल';
  @override
  String get emailHint => 'name@example.com';
  @override
  String get dateOfBirth => 'जन्म तिथि';
  @override
  String traditionalEra(String calendarId) =>
      calendarId == 'saka' ? 'शक' : 'वि.सं.';
  @override
  String gregorianEra(String calendarId) => 'ईस्वी';
  @override
  String get pickDate => 'तिथि चुनें';
  @override
  String get birthTime => 'जन्म समय';
  @override
  String get pickTime => 'समय चुनें';
  @override
  String get birthPlace => 'जन्म स्थान';
  @override
  String birthPlaceHint(String city) => 'जैसे: $city';
  @override
  String get gender => 'लिंग';
  @override
  String get male => 'पुरुष';
  @override
  String get female => 'महिला';
  @override
  String get other => 'अन्य';
  @override
  String get horoscopeSign => 'राशि';
  @override
  String get selectSign => 'राशि चुनें';
  @override
  String get requiredField => 'यह फ़ील्ड आवश्यक है';
  @override
  String get invalidEmail => 'मान्य ईमेल दर्ज करें';
  @override
  String zodiac(ZodiacSign sign) => switch (sign) {
    ZodiacSign.aries => 'मेष',
    ZodiacSign.taurus => 'वृषभ',
    ZodiacSign.gemini => 'मिथुन',
    ZodiacSign.cancer => 'कर्क',
    ZodiacSign.leo => 'सिंह',
    ZodiacSign.virgo => 'कन्या',
    ZodiacSign.libra => 'तुला',
    ZodiacSign.scorpio => 'वृश्चिक',
    ZodiacSign.sagittarius => 'धनु',
    ZodiacSign.capricorn => 'मकर',
    ZodiacSign.aquarius => 'कुंभ',
    ZodiacSign.pisces => 'मीन',
  };

  @override
  String get notificationTitle => 'सूचना सेटिंग';
  @override
  String get notificationSubtitle =>
      'चुनें कि आप किस बारे में याद दिलाना चाहते हैं। इसे बाद में बदला जा सकता है।';
  @override
  String get horoscopeSection => 'राशिफल सूचना सेटिंग';
  @override
  String get daily => 'दैनिक';
  @override
  String get monthly => 'मासिक';
  @override
  String get yearly => 'वार्षिक';
  @override
  String get notificationTime => 'सूचना समय';
  @override
  String get festivalSection => 'त्योहार सूचना सेटिंग';
  @override
  String get importantFestivals => 'प्रमुख हिंदू त्योहार';
  @override
  String get commonFestivals => 'सामान्य त्योहार';
  @override
  String get publicHolidays => 'सार्वजनिक अवकाश';
  @override
  String get remindBefore => 'याद दिलाएँ';
  @override
  String get daysAt => 'दिन पहले, समय';
  @override
  String get birthdaySection => 'जन्मदिन सूचना सेटिंग';
  @override
  String get birthdayReminders => 'जन्मदिन रिमाइंडर';
  @override
  String get finish => 'पूर्ण करें';
}
