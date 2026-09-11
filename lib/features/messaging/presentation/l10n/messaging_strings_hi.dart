part of 'messaging_strings.dart';

class _Hi extends MessagingStrings {
  const _Hi();

  @override
  String get messages => 'संदेश';
  @override
  String get inbox => 'इनबॉक्स';
  @override
  String get archived => 'संग्रहीत';
  @override
  String get buying => 'मेरी पूछताछ';
  @override
  String get selling => 'मेरा व्यवसाय';
  @override
  String get noMessages => 'अभी कोई संदेश नहीं';
  @override
  String get noMessagesBody =>
      'आपके द्वारा संपर्क किए गए व्यवसायों से बातचीत यहाँ दिखाई देगी।';
  @override
  String get noArchived => 'कुछ भी संग्रहीत नहीं';
  @override
  String get archive => 'संग्रह करें';
  @override
  String get unarchive => 'इनबॉक्स में लौटाएँ';

  @override
  String get typeMessage => 'संदेश लिखें…';
  @override
  String get send => 'भेजें';
  @override
  String get sending => 'भेजा जा रहा है…';
  @override
  String get failedToSend => 'संदेश नहीं भेजा गया';
  @override
  String get tapToRetry => 'पुनः प्रयास के लिए टैप करें';
  @override
  String get startConversation => 'बातचीत शुरू करें';
  @override
  String get startConversationBody =>
      'उत्पाद, कीमत या डिलीवरी के बारे में पूछें। व्यवसाय आपका संदेश अपने इनबॉक्स में देखेगा।';
  @override
  String get you => 'आप';

  @override
  String get sendMessage => 'संदेश भेजें';
  @override
  String get messageSent => 'संदेश भेजा गया';
  @override
  String get messageSentBody =>
      'व्यवसाय को आपका संदेश मिल गया है और वह यहीं उत्तर दे सकता है।';
  @override
  String get viewConversation => 'बातचीत देखें';
  @override
  String get yourName => 'आपका नाम';
  @override
  String get yourEmail => 'आपका ईमेल';
  @override
  String get subject => 'विषय';
  @override
  String get message => 'संदेश';
  @override
  String get messageRequired => 'पहले संदेश लिखें';
  @override
  String get notAcceptingMessages =>
      'यह व्यवसाय अभी संदेश स्वीकार नहीं कर रहा है।';

  @override
  String unreadCount(int count) => '$count अपठित';
}
