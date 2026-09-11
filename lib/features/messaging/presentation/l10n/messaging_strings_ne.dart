part of 'messaging_strings.dart';

class _Ne extends MessagingStrings {
  const _Ne();

  @override
  String get messages => 'सन्देशहरू';
  @override
  String get inbox => 'इनबक्स';
  @override
  String get archived => 'सङ्ग्रहित';
  @override
  String get buying => 'मेरा सोधपुछ';
  @override
  String get selling => 'मेरो व्यवसाय';
  @override
  String get noMessages => 'अहिलेसम्म कुनै सन्देश छैन';
  @override
  String get noMessagesBody =>
      'तपाईंले सम्पर्क गर्नुभएका व्यवसायसँगका कुराकानी यहाँ देखिनेछन्।';
  @override
  String get noArchived => 'केही सङ्ग्रह गरिएको छैन';
  @override
  String get archive => 'सङ्ग्रह गर्नुहोस्';
  @override
  String get unarchive => 'इनबक्समा फर्काउनुहोस्';

  @override
  String get typeMessage => 'सन्देश लेख्नुहोस्…';
  @override
  String get send => 'पठाउनुहोस्';
  @override
  String get sending => 'पठाउँदै…';
  @override
  String get failedToSend => 'सन्देश पठाइएन';
  @override
  String get tapToRetry => 'पुनः प्रयास गर्न थिच्नुहोस्';
  @override
  String get startConversation => 'कुराकानी सुरु गर्नुहोस्';
  @override
  String get startConversationBody =>
      'उत्पादन, मूल्य वा डेलिभरीबारे सोध्नुहोस्। व्यवसायले तपाईंको सन्देश इनबक्समा देख्नेछ।';
  @override
  String get you => 'तपाईं';

  @override
  String get sendMessage => 'सन्देश पठाउनुहोस्';
  @override
  String get messageSent => 'सन्देश पठाइयो';
  @override
  String get messageSentBody =>
      'व्यवसायसँग तपाईंको सन्देश पुग्यो र यहीँबाट जवाफ दिन सक्छ।';
  @override
  String get viewConversation => 'कुराकानी हेर्नुहोस्';
  @override
  String get yourName => 'तपाईंको नाम';
  @override
  String get yourEmail => 'तपाईंको इमेल';
  @override
  String get subject => 'विषय';
  @override
  String get message => 'सन्देश';
  @override
  String get messageRequired => 'पहिले सन्देश लेख्नुहोस्';
  @override
  String get notAcceptingMessages =>
      'यो व्यवसायले अहिले सन्देश स्वीकार गर्दैन।';

  @override
  String unreadCount(int count) => '$count नपढिएका';
}
