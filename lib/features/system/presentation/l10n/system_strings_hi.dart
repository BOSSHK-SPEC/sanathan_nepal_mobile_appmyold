part of 'system_strings.dart';

class _Hi extends SystemStrings {
  const _Hi();
  @override
  String get offlineTitle => 'इंटरनेट नहीं है';
  @override
  String get offlineBody =>
      'कनेक्शन जाँचकर फिर कोशिश करें। पहले से डाउनलोड सामग्री काम करती है।';
  @override
  String get offlineStillWorks =>
      'पात्रो, पंचांग और सहेजी कुंडली ऑफ़लाइन चलते हैं।';
  @override
  String get retry => 'फिर कोशिश करें';
  @override
  String get youAreOffline => 'आप ऑफ़लाइन हैं';
  @override
  String get backOnline => 'फिर ऑनलाइन';
  @override
  String get updateRequiredTitle => 'जारी रखने के लिए अपडेट करें';
  @override
  String get updateRequiredBody =>
      'यह संस्करण अब समर्थित नहीं है। ऐप चलाते रहने के लिए अपडेट करें।';
  @override
  String get updateAvailableTitle => 'नया संस्करण उपलब्ध';
  @override
  String get updateAvailableBody => 'समय मिलने पर अपडेट करें।';
  @override
  String get updateNow => 'अभी अपडेट करें';
  @override
  String get notNow => 'अभी नहीं';
  @override
  String get maintenanceTitle => 'जल्द वापस आएँगे';
  @override
  String get maintenanceBody =>
      'नियोजित रखरखाव चल रहा है। आपका कोई काम नहीं खोएगा।';
  @override
  String get expectedBack => 'वापसी का अपेक्षित समय';
  @override
  String get signInRequiredTitle => 'जारी रखने के लिए साइन इन करें';
  @override
  String get signInRequiredBody =>
      'परामर्श, वॉलेट और ऑर्डर के लिए खाता आवश्यक है।';
  @override
  String get signIn => 'साइन इन';
  @override
  String get maybeLater => 'देखते रहें';
  @override
  String get freeToBrowse => 'पात्रो, पंचांग, राशिफल और त्योहार निःशुल्क हैं।';
  @override
  String versionLine(String current, String latest) =>
      'संस्करण $current → $latest';
}
