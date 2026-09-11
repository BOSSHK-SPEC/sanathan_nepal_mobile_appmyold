import '../../../../core/region/region.dart';
import '../../domain/entities/legal_document.dart';
import 'legal_region_party.dart';

/// Privacy Policy copy (Figma node `1265:2654`) – Nepal variant, kept for
/// tests and previews. Use [privacyPolicyFor] for the active region.
final LegalDocument privacyPolicySeed = privacyPolicyFor(RegionConfig.nepal);

/// Privacy Policy for [config]'s region: shared body plus the region's
/// data-protection framework, grievance contact and company block.
LegalDocument privacyPolicyFor(RegionConfig config) {
  final party = LegalParty.of(config);
  return LegalDocument(
    type: LegalDocumentType.privacyPolicy,
    title: const LegalText(
      ne: 'गोपनीयता नीति',
      en: 'Privacy Policy',
      hi: 'गोपनीयता नीति',
    ),
    lastUpdated: DateTime(2023, 4, 10),
    intro: LegalText.withHindiSummary(
      hiSummary:
          'सारांश: उपयोगकर्ताओं की गोपनीयता हमारी प्राथमिकता है । सेवा '
          'देने और सुधारने के लिए हम आपका व्यक्तिगत डेटा उपयोग कर सकते हैं; '
          'सेवा का उपयोग करके आप इस नीति के अनुसार जानकारी के संग्रह और उपयोग '
          'से सहमत होते हैं । (आधिकारिक पाठ अंग्रेज़ी में नीचे दिया गया है ।)',
      en:
          'One of our main priorities is the privacy of our visitors. Sanatan '
          'Nepal may sometimes use Your Personal data to provide & improve the '
          'Service. By using our Service, You agree to the collection and use of '
          'information in accordance with this Privacy Policy. This Privacy '
          'Policy document contains types of information that is collected and '
          'recorded by Sanatan Nepal and how we use it. If you have additional '
          'questions or require more information about our Privacy Policy, do '
          'not hesitate to contact us.',
      ne:
          'हाम्रा प्रयोगकर्ताहरूको गोपनीयता हाम्रो मुख्य प्राथमिकता हो । सनातन '
          'नेपालले सेवा प्रदान गर्न र सुधार गर्न कहिलेकाहीँ तपाईंको व्यक्तिगत '
          'डाटा प्रयोग गर्न सक्छ । हाम्रो सेवा प्रयोग गरेर तपाईं यस गोपनीयता '
          'नीति अनुसार जानकारी सङ्कलन र प्रयोगमा सहमत हुनुहुन्छ । यस कागजातमा '
          'सनातन नेपालले सङ्कलन गर्ने जानकारीका प्रकार र तिनको प्रयोग उल्लेख छ । '
          'थप प्रश्न भए हामीलाई सम्पर्क गर्न नहिचकिचाउनुहोस् ।',
    ),
    sections: [
      const LegalSection(
        heading: LegalText(
          en: '1. What Information Do We Collect?',
          ne: '१. हामी कस्ता जानकारी सङ्कलन गर्छौं?',
          hi: '१. हम कौन-सी जानकारी एकत्र करते हैं?',
        ),
        body: LegalText(en: '', ne: ''),
      ),
      LegalSection(
        level: 2,
        heading: const LegalText(
          en: '1.1 Personal information you disclose to us',
          ne: '१.१ तपाईंले हामीलाई दिनुहुने व्यक्तिगत जानकारी',
          hi: '१.१ आपके द्वारा दी गई व्यक्तिगत जानकारी',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: ऐप का उपयोग करते समय हम आपसे ईमेल, नाम, फ़ोन नंबर, पता, शहर आदि जैसी पहचान योग्य जानकारी माँग सकते हैं।',
          en:
              'While using Our app, We may ask You to provide Us with certain '
              'personally identifiable information that can be used to contact '
              'or identify You. Personally identifiable information may include, '
              'but is not limited to: Email address, First name and last name, '
              'Phone number, Address, State, Province, ZIP/Postal code, City.',
          ne:
              'हाम्रो एप प्रयोग गर्दा हामी तपाईंलाई सम्पर्क वा पहिचान गर्न '
              'सकिने केही व्यक्तिगत जानकारी माग्न सक्छौं । यसमा इमेल ठेगाना, नाम '
              'र थर, फोन नम्बर, ठेगाना, प्रदेश, हुलाक कोड र सहर समावेश हुन सक्छन् ।',
        ),
      ),
      LegalSection(
        level: 2,
        heading: const LegalText(
          en: '1.2 Information automatically collected',
          ne: '१.२ स्वचालित रूपमा सङ्कलन हुने जानकारी',
          hi: '१.२ स्वतः एकत्र की गई जानकारी',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: ऐप के उपयोग के दौरान IP पता, डिवाइस व ब्राउज़र की विशेषताएँ, ऑपरेटिंग सिस्टम, भाषा और स्थान जैसी तकनीकी जानकारी स्वतः एकत्र होती है; यह आपकी विशिष्ट पहचान प्रकट नहीं करती।',
          en:
              'We automatically collect certain information when you visit, use, '
              'or navigate the App. This information does not reveal your '
              'specific identity (like your name or contact information) but may '
              'include device and usage information, such as your IP address, '
              'Browser and device characteristics, Operating system, Language '
              'preferences, Device name, Location and other technical '
              'information. This information is primarily needed to maintain the '
              'security and operation of our Services, and for our internal '
              'analytics and reporting purposes.',
          ne:
              'तपाईंले एप प्रयोग गर्दा हामी केही जानकारी स्वचालित रूपमा सङ्कलन '
              'गर्छौं । यसले तपाईंको विशिष्ट पहिचान खुलाउँदैन तर IP ठेगाना, '
              'ब्राउजर र यन्त्रको विवरण, अपरेटिङ सिस्टम, भाषा प्राथमिकता, यन्त्रको '
              'नाम, स्थान र अन्य प्राविधिक जानकारी समावेश हुन सक्छ । यो जानकारी '
              'सेवाको सुरक्षा र सञ्चालन तथा आन्तरिक विश्लेषणका लागि आवश्यक छ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '2. Purpose of use of Information',
          ne: '२. जानकारी प्रयोगको उद्देश्य',
          hi: '२. जानकारी के उपयोग का उद्देश्य',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: आपकी जानकारी का उपयोग सेवा प्रदान करने व बनाए रखने, आपके खाते के प्रबंधन, आपसे संपर्क (ईमेल/SMS/पुश सूचना), ऑफ़र भेजने और सेवा सुधार के लिए किया जाता है।',
          en:
              'The Company may use Personal Data for the following purposes: To '
              'provide and maintain our Service, including to monitor the usage '
              'of our Service. To manage Your Account: to manage Your '
              'registration as a user of the Service. To contact You: by email, '
              'telephone calls, SMS, or other equivalent forms of electronic '
              'communication, such as push notifications regarding updates or '
              'informative communications related to the functionalities, '
              'products or contracted services. To provide You with news, special '
              'offers and general information about other services and events '
              'which we offer unless You have opted not to receive such '
              'information. For other purposes: data analysis, identifying usage '
              'trends, and to evaluate and improve our App, products, services, '
              'and your user experience.',
          ne:
              'कम्पनीले व्यक्तिगत डाटा निम्न उद्देश्यका लागि प्रयोग गर्न सक्छ: '
              'सेवा प्रदान गर्न र कायम राख्न; तपाईंको खाता व्यवस्थापन गर्न; इमेल, '
              'फोन, एसएमएस वा पुश सूचना मार्फत तपाईंलाई सम्पर्क गर्न; समाचार, '
              'विशेष अफर र अन्य सेवाहरूको जानकारी दिन; तथा डाटा विश्लेषण, प्रयोग '
              'प्रवृत्ति पहिचान र एप, उत्पादन र सेवा सुधार गर्न ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '3. How Long do we keep your information?',
          ne: '३. हामी तपाईंको जानकारी कति समय राख्छौं?',
          hi: '३. हम आपकी जानकारी कितने समय तक रखते हैं?',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: आपका व्यक्तिगत डेटा केवल इस नीति में बताए उद्देश्यों के लिए आवश्यक अवधि तक और कानूनी दायित्व पूरे करने हेतु रखा जाता है; उपयोग डेटा आंतरिक विश्लेषण के लिए सीमित समय तक रखा जाता है।',
          en:
              'Sanatan Nepal will retain Your Personal Data only for as long as '
              'is necessary for the purposes set out in this Privacy Policy. We '
              'will retain and use Your Personal Data to the extent necessary to '
              'comply with our legal obligations, resolve disputes, & enforce '
              'our legal agreements & policies. Sanatan Nepal will also retain '
              'Usage Data for internal analysis purposes. Usage Data is '
              'generally retained for a shorter period of time, except when this '
              'data is used to strengthen the security or to improve the '
              'functionality of Our Service, or We are legally obligated to '
              'retain this data for longer time periods.',
          ne:
              'सनातन नेपालले यस नीतिमा उल्लेखित उद्देश्य पूरा गर्न आवश्यक '
              'अवधिसम्म मात्र तपाईंको व्यक्तिगत डाटा राख्नेछ । कानुनी दायित्व '
              'पालना, विवाद समाधान र सम्झौता कार्यान्वयनका लागि आवश्यक हदसम्म '
              'डाटा राखिनेछ । प्रयोग डाटा सामान्यतया छोटो अवधिका लागि मात्र '
              'राखिन्छ, सुरक्षा वा कार्यक्षमता सुधार अथवा कानुनी बाध्यता भएको '
              'अवस्थामा बाहेक ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '4. Transfer of the Users’ information',
          ne: '४. प्रयोगकर्ताको जानकारीको स्थानान्तरण',
          hi: '४. उपयोगकर्ता की जानकारी का स्थानांतरण',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: आपकी जानकारी कंपनी के कार्यालयों और प्रसंस्करण में शामिल पक्षों के स्थानों पर संसाधित होती है; इस नीति की स्वीकृति उस स्थानांतरण के लिए आपकी सहमति है।',
          en:
              'Your information, including Personal Data, is processed at the '
              "Company's operating offices and in any other places where the "
              'parties involved in the processing are located. Your consent to '
              'this Privacy Policy followed by Your submission of such '
              'information represents Your agreement to that transfer.',
          ne:
              'तपाईंको व्यक्तिगत डाटा सहितका जानकारी कम्पनीको कार्यालय र '
              'प्रशोधनमा संलग्न पक्षहरू रहेका अन्य स्थानमा प्रशोधन गरिन्छ । यस '
              'नीतिमा सहमति जनाई जानकारी पेस गर्नु भनेको त्यस्तो स्थानान्तरणमा '
              'तपाईंको सहमति हो ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '5. Delete Users’ Personal Data',
          ne: '५. प्रयोगकर्ताको व्यक्तिगत डाटा मेटाउने',
          hi: '५. उपयोगकर्ता का व्यक्तिगत डेटा हटाना',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: आप खाता सेटिंग्स से अपनी जानकारी कभी भी अपडेट या हटा सकते हैं, या हमसे संपर्क कर पहुँच/सुधार/हटाने का अनुरोध कर सकते हैं; कानूनी आवश्यकता होने पर कुछ जानकारी रखी जा सकती है।',
          en:
              'Our App may give You the ability to delete certain information '
              'about You from within the Service. You may update, amend, or '
              'delete Your information at any time by signing in to Your Account '
              'and visiting the account settings section. You may also contact '
              'Us to request access to, correct, or delete any personal '
              'information that You have provided to Us. Please note, however, '
              'that We may need to retain certain information when we have a '
              'legal obligation or lawful basis to do so.',
          ne:
              'हाम्रो एपले तपाईंलाई सेवा भित्रबाटै आफ्नो केही जानकारी मेटाउने '
              'सुविधा दिन सक्छ । खातामा साइन इन गरी सेटिङ खण्डबाट जानकारी '
              'अद्यावधिक, संशोधन वा मेटाउन सक्नुहुन्छ । तपाईंले हामीलाई सम्पर्क '
              'गरेर पनि जानकारी सच्याउन वा मेटाउन अनुरोध गर्न सक्नुहुन्छ । तर '
              'कानुनी दायित्व भएको अवस्थामा केही जानकारी राख्नुपर्ने हुन सक्छ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '6. Disclosure of Users’ Personal Data',
          ne: '६. प्रयोगकर्ताको व्यक्तिगत डाटाको खुलासा',
          hi: '६. उपयोगकर्ता के व्यक्तिगत डेटा का प्रकटीकरण',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: कानूनी दायित्व पूरा करने, कंपनी के अधिकारों की रक्षा, गलत कार्यों की जाँच, उपयोगकर्ताओं की सुरक्षा या कानूनी देयता से बचाव के लिए आपका डेटा सद्भावपूर्वक प्रकट किया जा सकता है।',
          en:
              'Sanatan Nepal may disclose Your Personal Data in the good faith '
              'belief that such action is necessary to: Comply with a legal '
              'obligation; Protect and defend the rights or property of the '
              'Company; Prevent or investigate possible wrongdoing in connection '
              'with the Service; Protect the personal safety of Users of the '
              'Service or the public; Protect against legal liability.',
          ne:
              'सनातन नेपालले निम्न अवस्थामा असल नियतले तपाईंको व्यक्तिगत डाटा '
              'खुलासा गर्न सक्छ: कानुनी दायित्व पालना गर्न; कम्पनीको अधिकार वा '
              'सम्पत्तिको रक्षा गर्न; सेवासँग सम्बन्धित सम्भावित गलत काम रोक्न वा '
              'अनुसन्धान गर्न; प्रयोगकर्ता वा जनताको व्यक्तिगत सुरक्षा गर्न; '
              'कानुनी दायित्वबाट बच्न ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '7. Changes to this Privacy Policy',
          ne: '७. यस गोपनीयता नीतिमा परिवर्तन',
          hi: '७. इस गोपनीयता नीति में परिवर्तन',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: हम समय-समय पर इस नीति को अपडेट कर सकते हैं; परिवर्तन इस पृष्ठ पर प्रकाशित होते ही प्रभावी होंगे और आपको ईमेल/ऐप सूचना द्वारा जानकारी दी जाएगी।',
          en:
              'We may update Our Privacy Policy from time to time. We will '
              'notify You of any changes by posting the new Privacy Policy on '
              'this page. We will let You know via email and/or a prominent '
              'notice on Our App, prior to the change becoming effective and '
              'update the "Last updated" date at the top of this Privacy Policy. '
              'Changes to this Privacy Policy are effective when they are posted '
              'on this page.',
          ne:
              'हामी समय-समयमा यो नीति अद्यावधिक गर्न सक्छौं । नयाँ नीति यसै '
              'पृष्ठमा प्रकाशित गरी तपाईंलाई जानकारी दिइनेछ । परिवर्तन लागू हुनु '
              'अघि इमेल वा एपमा सूचना मार्फत जानकारी दिइनेछ र माथिको "अन्तिम '
              'अद्यावधिक" मिति परिवर्तन गरिनेछ । परिवर्तनहरू यस पृष्ठमा प्रकाशित '
              'भएपछि लागू हुनेछन् ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '8. Security measures for Users’ information',
          ne: '८. प्रयोगकर्ताको जानकारीको सुरक्षा उपाय',
          hi: '८. उपयोगकर्ता की जानकारी के लिए सुरक्षा उपाय',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: हम आपके डेटा की सुरक्षा के लिए व्यावसायिक रूप से स्वीकार्य उपाय अपनाते हैं, परंतु इंटरनेट पर प्रसारण या इलेक्ट्रॉनिक भंडारण की कोई भी विधि 100% सुरक्षित नहीं है।',
          en:
              'The security of Your Personal Data is important to Us, but '
              'remember that no method of transmission over the Internet, or '
              'method of electronic storage is 100% secure. While We strive to '
              'use commercially acceptable means to protect Your Personal Data, '
              'We cannot guarantee its absolute security.',
          ne:
              'तपाईंको व्यक्तिगत डाटाको सुरक्षा हाम्रा लागि महत्त्वपूर्ण छ, तर '
              'इन्टरनेट मार्फत प्रसारण वा विद्युतीय भण्डारणको कुनै पनि विधि '
              'शतप्रतिशत सुरक्षित हुँदैन । हामी व्यावसायिक रूपमा स्वीकार्य उपाय '
              'अपनाउँछौं, तर पूर्ण सुरक्षाको ग्यारेन्टी गर्न सक्दैनौं ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '9. Applicable data-protection law and your rights',
          ne: '९. लागू हुने डाटा संरक्षण कानून र तपाईंका अधिकार',
          hi: '९. लागू डेटा संरक्षण कानून और आपके अधिकार',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: ${party.dataLawHi} के अंतर्गत आपको अपने व्यक्तिगत '
              'डेटा तक पहुँच, सुधार, हटाने और सहमति वापस लेने का अधिकार है । '
              'अनुरोध या शिकायत के लिए हमसे संपर्क करें ।',
          en:
              'We process Your Personal Data in accordance with '
              '${party.dataLawEn}. Subject to that law You have the right to '
              'access, correct and erase the Personal Data We hold about You, to '
              'withdraw consent You have given, and to raise a complaint about '
              'the way Your data is handled. Requests are answered within the '
              'time limits prescribed by the applicable law.',
          ne:
              'हामी तपाईंको व्यक्तिगत डाटा ${party.dataLawNe} अनुसार प्रशोधन '
              'गर्छौं । सो कानून बमोजिम तपाईंलाई आफ्नो डाटा हेर्ने, सच्याउने, '
              'मेटाउने, दिइएको सहमति फिर्ता लिने र गुनासो राख्ने अधिकार छ । '
              'अनुरोधहरू कानूनले तोकेको समयभित्र सम्बोधन गरिनेछ ।',
        ),
      ),
      if (party.hasGrievanceOfficer)
        LegalSection(
          heading: const LegalText(
            en: '10. Grievance Officer',
            ne: '१०. गुनासो अधिकारी',
            hi: '१०. शिकायत अधिकारी',
          ),
          body: LegalText.withHindiSummary(
            hiSummary:
                'सारांश: ${party.dataLawHi} के अनुसार नियुक्त शिकायत '
                'अधिकारी – ${party.grievanceOfficerHi}, ${party.addressHi}, '
                'ईमेल: ${party.grievanceEmail} । शिकायतों का उत्तर कानून द्वारा '
                'निर्धारित समय-सीमा के भीतर दिया जाता है ।',
            en:
                'In accordance with ${party.dataLawEn}, We have appointed a '
                'Grievance Officer to address Your concerns regarding the '
                'processing of Your Personal Data: ${party.grievanceOfficerEn}, '
                '${party.addressEn}, e-mail: ${party.grievanceEmail}. Grievances '
                'are acknowledged and resolved within the period prescribed by '
                'the applicable law.',
            ne:
                '${party.dataLawNe} बमोजिम तपाईंको व्यक्तिगत डाटाको प्रशोधन '
                'सम्बन्धी गुनासो सम्बोधन गर्न गुनासो अधिकारी नियुक्त गरिएको छ: '
                '${party.grievanceOfficerNe}, ${party.addressNe}, इमेल: '
                '${party.grievanceEmail} । गुनासोहरू कानूनले तोकेको अवधिभित्र '
                'समाधान गरिनेछ ।',
          ),
        ),
      LegalSection(
        heading: LegalText(
          en: '${party.hasGrievanceOfficer ? 11 : 10}. Contact Us',
          ne: '${party.hasGrievanceOfficer ? '११' : '१०'}. हामीलाई सम्पर्क गर्नुहोस्',
          hi: '${party.hasGrievanceOfficer ? '११' : '१०'}. हमसे संपर्क करें',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: इस गोपनीयता नीति से जुड़े किसी भी प्रश्न के लिए '
              '${party.companyHi}, ${party.addressHi} से ${party.email} पर '
              'संपर्क करें ।',
          en:
              'If you have any questions about our Privacy Policy, do not '
              'hesitate to contact us: ${party.companyEn}, ${party.addressEn}, '
              'e-mail ${party.email}, phone ${party.phone}.',
          ne:
              'यस गोपनीयता नीतिबारे कुनै प्रश्न भए ${party.companyNe}, '
              '${party.addressNe}, इमेल ${party.email}, फोन ${party.phone} मा '
              'सम्पर्क गर्न नहिचकिचाउनुहोस् ।',
        ),
      ),
    ],
  );
}
