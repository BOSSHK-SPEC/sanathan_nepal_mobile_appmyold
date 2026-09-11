import '../../../../core/region/region.dart';
import '../../domain/entities/legal_document.dart';
import 'legal_region_party.dart';

/// Terms & Conditions copy (Figma node `1332:2744`) – Nepal variant, kept
/// for tests and previews. Use [termsConditionsFor] for the active region.
final LegalDocument termsConditionsSeed = termsConditionsFor(
  RegionConfig.nepal,
);

/// Terms & Conditions for [config]'s region: shared body plus governing law,
/// jurisdiction and the region's company/contact block.
LegalDocument termsConditionsFor(RegionConfig config) {
  final party = LegalParty.of(config);
  return LegalDocument(
    type: LegalDocumentType.termsConditions,
    title: const LegalText(
      ne: 'नियम तथा सर्तहरू',
      en: 'Terms And Conditions',
      hi: 'नियम और शर्तें',
    ),
    lastUpdated: DateTime(2023, 4, 11),
    intro: LegalText.withHindiSummary(
      hiSummary:
          'सारांश: सनातन नेपाल में आपका स्वागत है! ये नियम और शर्तें ऐप '
          'के उपयोग के नियम निर्धारित करती हैं । ऐप का उपयोग करके आप इन शर्तों '
          'को स्वीकार करते हैं; सहमत न हों तो कृपया ऐप का उपयोग न करें । '
          '(आधिकारिक पाठ अंग्रेज़ी में नीचे दिया गया है ।)',
      en:
          'Welcome to Sanatan Nepal! These terms & conditions outline the rules '
          '& regulations for the use of Sanatan Nepal. By using this app we '
          'assume you accept these terms and conditions. Do not continue to use '
          'Sanatan Nepal if you do not agree to take all of the terms and '
          'conditions stated on this page.',
      ne:
          'सनातन नेपालमा स्वागत छ! यी नियम तथा सर्तहरूले सनातन नेपालको प्रयोग '
          'सम्बन्धी नियमहरू निर्धारण गर्छन् । यो एप प्रयोग गरेर तपाईंले यी सर्तहरू '
          'स्वीकार गर्नुभएको मानिनेछ । यस पृष्ठमा उल्लेखित सबै सर्तहरूमा सहमत '
          'हुनुहुन्न भने कृपया एप प्रयोग नगर्नुहोस् ।',
    ),
    sections: [
      LegalSection(
        heading: const LegalText(
          en: '1. Definitions',
          ne: '१. परिभाषाहरू',
          hi: '१. परिभाषाएँ',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: इस अनुबंध में "एप्लिकेशन", "एप स्टोर", "देश", "कंपनी", "डिवाइस", "सेवा" और "आप" जैसे शब्दों के अर्थ स्पष्ट किए गए हैं।',
          en:
              'For the purposes of these Terms and Conditions: Application means '
              'the Sanatan Nepal App downloaded by You on any electronic device. '
              'Application Store means the digital distribution service operated '
              'and developed by Apple Inc. (Apple App Store) or Google Inc. '
              '(Google Play Store) in which the Application has been downloaded. '
              'Country refers to: ${party.countryEn}. Company (referred to as either "We", '
              '"Us" or "Our" in this Agreement) refers to Sanatan Nepal. Device '
              'means any device that can access the Service such as a cellphone '
              'or a digital tablet. Service refers to the Application. Terms and '
              'Conditions (also referred as "Terms") mean these Terms and '
              'Conditions that form the entire agreement between You and the '
              'Company regarding the use of the Service. You means the '
              'individual accessing or using our App.',
          ne:
              'यी सर्तहरूको प्रयोजनका लागि: "एप्लिकेसन" भन्नाले तपाईंले कुनै पनि '
              'विद्युतीय यन्त्रमा डाउनलोड गर्नुभएको सनातन नेपाल एप बुझिन्छ । '
              '"एप स्टोर" भन्नाले Apple App Store वा Google Play Store बुझिन्छ । '
              '"देश" भन्नाले ${party.countryNe} बुझिन्छ । "कम्पनी" ("हामी", "हाम्रो") भन्नाले '
              'सनातन नेपाल बुझिन्छ । "यन्त्र" भन्नाले मोबाइल वा ट्याब्लेट जस्ता '
              'सेवा पहुँच गर्न सक्ने कुनै पनि यन्त्र बुझिन्छ । "सेवा" भन्नाले '
              'एप्लिकेसन बुझिन्छ । "तपाईं" भन्नाले एप प्रयोग गर्ने व्यक्ति '
              'बुझिन्छ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '2. Users’ Accounts and membership',
          ne: '२. प्रयोगकर्ता खाता र सदस्यता',
          hi: '२. उपयोगकर्ता खाते और सदस्यता',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: आपके द्वारा प्रस्तुत सामग्री पर हमारा स्वामित्व नहीं है; उसकी सटीकता, वैधता और बौद्धिक संपदा अधिकारों की ज़िम्मेदारी आपकी है। हम सामग्री की समीक्षा कर सकते हैं और नियम-विरुद्ध सामग्री हटा सकते हैं।',
          en:
              'We do not own any data, information or material (collectively, '
              '“Content”) that you submit in the Mobile App in the course of '
              'using the Service. You shall have sole responsibility for the '
              'accuracy, quality, integrity, legality, reliability, '
              'appropriateness, & intellectual property ownership or right to '
              'use of all submitted Content. We may monitor and review the '
              'Content in the Mobile App submitted or created using our Services '
              'by you. You grant us permission to access, copy, distribute, '
              'store, transmit, reformat, display and perform the Content of '
              'your user account solely as required for the purpose of providing '
              'the Services to you. We have the right, though not the '
              'obligation, to refuse or remove any Content that, in our '
              'reasonable opinion, violates any of our policies or is in any way '
              'harmful or objectionable.',
          ne:
              'सेवा प्रयोगका क्रममा तपाईंले एपमा पेस गर्नुभएको कुनै पनि डाटा, '
              'जानकारी वा सामग्री ("सामग्री") को स्वामित्व हामीसँग हुँदैन । '
              'सामग्रीको शुद्धता, गुणस्तर, वैधता र बौद्धिक सम्पत्ति अधिकारको '
              'जिम्मेवारी तपाईंको मात्र हुनेछ । हामीले सामग्रीको अनुगमन र समीक्षा '
              'गर्न सक्छौं । सेवा प्रदान गर्ने प्रयोजनका लागि मात्र सामग्री पहुँच, '
              'प्रतिलिपि, भण्डारण र प्रदर्शन गर्ने अनुमति तपाईंले हामीलाई '
              'दिनुहुन्छ । हाम्रा नीति उल्लङ्घन गर्ने वा आपत्तिजनक सामग्री हटाउने '
              'अधिकार हामीसँग सुरक्षित छ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '3. Backups of the Users’ information',
          ne: '३. प्रयोगकर्ताको जानकारीको ब्याकअप',
          hi: '३. उपयोगकर्ता की जानकारी का बैकअप',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: हम सामग्री का नियमित बैकअप लेते हैं और हार्डवेयर विफलता या डेटा हानि की स्थिति में उसे स्वतः पुनर्स्थापित करने का प्रयास करते हैं।',
          en:
              'We perform regular backups of the Content and will do our best to '
              'ensure completeness and accuracy of these backups. In the event '
              'of the hardware failure or data loss we will restore backups '
              'automatically to minimize the impact and downtime.',
          ne:
              'हामी सामग्रीको नियमित ब्याकअप गर्छौं र तिनको पूर्णता र शुद्धता '
              'सुनिश्चित गर्न प्रयास गर्छौं । हार्डवेयर खराबी वा डाटा हानि भएमा '
              'प्रभाव न्यूनीकरण गर्न ब्याकअप स्वचालित रूपमा पुनर्स्थापना गरिनेछ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '4. Links to other resources',
          ne: '४. अन्य स्रोतहरूका लिङ्क',
          hi: '४. अन्य संसाधनों के लिंक',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: ऐप में अन्य वेबसाइटों/ऐप्स के लिंक हो सकते हैं; हम उनका समर्थन नहीं करते और उनकी सामग्री या सेवाओं के लिए उत्तरदायी नहीं हैं।',
          en:
              'Although the Mobile Application and Services may link to other '
              'resources (such as websites, mobile applications, etc.), we are '
              'not, directly or indirectly, implying any approval, association, '
              'sponsorship, or endorsement with any linked resource, unless '
              'specifically stated herein. We are not responsible for examining '
              'or evaluating, and we do not warrant the offerings of, any '
              'businesses or individuals or the content of their resources. You '
              'should carefully review the legal statements and other conditions '
              'of use of any resource which you access through a link in the '
              'Mobile Application. Your linking to any other off-site resources '
              'is at your own risk.',
          ne:
              'एप र सेवाहरूले अन्य स्रोत (वेबसाइट, एप आदि) सँग लिङ्क गर्न सक्छन्, '
              'तर यसले ती स्रोतप्रति हाम्रो स्वीकृति, सम्बन्ध वा समर्थन जनाउँदैन । '
              'ती व्यवसाय, व्यक्ति वा तिनका सामग्रीको मूल्याङ्कन वा ग्यारेन्टी '
              'हामी गर्दैनौं । लिङ्क मार्फत पहुँच गरिने कुनै पनि स्रोतका कानुनी '
              'सर्तहरू ध्यानपूर्वक पढ्नुहोस् । बाह्य स्रोतमा जानु तपाईंको आफ्नै '
              'जोखिममा हुनेछ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '5. Intellectual property rights',
          ne: '५. बौद्धिक सम्पत्ति अधिकार',
          hi: '५. बौद्धिक संपदा अधिकार',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: ऐप और सेवाओं से जुड़े सभी कॉपीराइट, ट्रेडमार्क और अन्य बौद्धिक संपदा अधिकार कंपनी के हैं; यह अनुबंध आपको कोई स्वामित्व या लाइसेंस हस्तांतरित नहीं करता।',
          en:
              '“Intellectual Property Rights” means all present and future rights '
              'conferred by statute, common law or equity in or in relation to '
              'any copyright and related rights, trademarks, designs, patents, '
              'goodwill and the right to sue for passing off, rights to '
              'inventions, rights to use, and all other intellectual property '
              'rights, whether registered or unregistered. This Agreement does '
              'not transfer to you any intellectual property owned by the '
              'Operator, and all rights, titles, and interests in and to such '
              'property will remain solely with the Operator. All trademarks, '
              'service marks, graphics and logos used in connection with the '
              'Mobile App and Services, are registered trademarks of the '
              'Operator or its licensors. Your use of the Mobile Application and '
              'Services grants you no right or license to reproduce or otherwise '
              'use any of the Operator or trademarks.',
          ne:
              '"बौद्धिक सम्पत्ति अधिकार" भन्नाले प्रतिलिपि अधिकार, ट्रेडमार्क, '
              'डिजाइन, पेटेन्ट, ख्याति, आविष्कार र प्रयोगको अधिकार लगायत दर्ता '
              'भएका वा नभएका सबै वर्तमान र भविष्यका अधिकार बुझिन्छ । यस '
              'सम्झौताले सञ्चालकको कुनै पनि बौद्धिक सम्पत्ति तपाईंलाई हस्तान्तरण '
              'गर्दैन । एप र सेवासँग सम्बन्धित सबै ट्रेडमार्क, ग्राफिक्स र लोगो '
              'सञ्चालक वा तिनका अनुमतिप्राप्तकर्ताका दर्ता ट्रेडमार्क हुन् । एपको '
              'प्रयोगले तिनको पुनरुत्पादन वा प्रयोगको कुनै अधिकार दिँदैन ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '6. Termination',
          ne: '६. समाप्ति',
          hi: '६. समाप्ति',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: इन शर्तों के उल्लंघन सहित किसी भी कारण से हम बिना पूर्व सूचना आपकी पहुँच तुरंत समाप्त या निलंबित कर सकते हैं।',
          en:
              'We may terminate or suspend Your access immediately, without prior '
              'notice, for any reason whatsoever, including without limitation '
              'if You breach these Terms & Conditions. Upon termination, Your '
              'right to use the Service will cease immediately.',
          ne:
              'तपाईंले यी सर्तहरू उल्लङ्घन गरेमा लगायत कुनै पनि कारणले हामी '
              'पूर्वसूचना बिना तुरुन्तै तपाईंको पहुँच समाप्त वा निलम्बन गर्न '
              'सक्छौं । समाप्ति पछि सेवा प्रयोग गर्ने तपाईंको अधिकार तुरुन्तै '
              'अन्त्य हुनेछ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '7. Changes and amendments',
          ne: '७. परिवर्तन र संशोधन',
          hi: '७. परिवर्तन और संशोधन',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: हम इन शर्तों को कभी भी संशोधित कर सकते हैं; संशोधित संस्करण ऐप में प्रकाशित होते ही प्रभावी होगा और उसके बाद उपयोग जारी रखना आपकी सहमति माना जाएगा।',
          en:
              'We reserve the right to modify these terms related to the Mobile '
              'App and Services at any time at our discretion. When we do, we '
              'will post a notification in the Mobile Application. We may also '
              'provide notice to you in other ways at our discretion, such as '
              'through the contact information you have provided. An updated '
              'version of this Agreement will be effective immediately upon the '
              'posting of the revised Agreement unless otherwise specified. Your '
              'continued use of the Mobile Application and Services after the '
              'effective date of the revised Agreement will constitute your '
              'consent to those changes.',
          ne:
              'एप र सेवासँग सम्बन्धित यी सर्तहरू कुनै पनि समयमा परिमार्जन गर्ने '
              'अधिकार हामीसँग सुरक्षित छ । परिमार्जन गर्दा एपमा सूचना प्रकाशित '
              'गरिनेछ र तपाईंले दिनुभएको सम्पर्क विवरण मार्फत पनि जानकारी दिन '
              'सकिनेछ । संशोधित सम्झौता प्रकाशित हुनासाथ लागू हुनेछ । त्यसपछि पनि '
              'एप प्रयोग गरिरहनु भनेको ती परिवर्तनमा तपाईंको सहमति हो ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '8. Acceptance of these terms',
          ne: '८. यी सर्तहरूको स्वीकृति',
          hi: '८. इन शर्तों की स्वीकृति',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: ऐप और सेवाओं का उपयोग करके आप इस अनुबंध की सभी शर्तों से बाध्य होना स्वीकार करते हैं; सहमत न होने पर आप ऐप का उपयोग करने के लिए अधिकृत नहीं हैं।',
          en:
              'You acknowledge that you have read this Agreement and agree to '
              'all its terms and conditions. By accessing and using the Mobile '
              'Application and Services you agree to be bound by this Agreement. '
              'If you do not agree to abide by the terms of this Agreement, you '
              'are not authorized to access or use the Mobile Application and '
              'Services.',
          ne:
              'तपाईंले यो सम्झौता पढ्नुभएको र यसका सबै सर्तहरूमा सहमत हुनुभएको '
              'स्वीकार गर्नुहुन्छ । एप र सेवा प्रयोग गरेर तपाईं यस सम्झौताबाट '
              'बाध्य हुन सहमत हुनुहुन्छ । सहमत हुनुहुन्न भने एप र सेवा प्रयोग गर्न '
              'तपाईंलाई अनुमति छैन ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '9. Governing law and jurisdiction',
          ne: '९. लागू हुने कानून र क्षेत्राधिकार',
          hi: '९. शासकीय कानून और क्षेत्राधिकार',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: यह अनुबंध ${party.governingLawHi} द्वारा शासित है '
              'और किसी भी विवाद पर ${party.jurisdictionHi} का अनन्य क्षेत्राधिकार '
              'होगा ।',
          en:
              'This Agreement, and any dispute or claim arising out of or in '
              'connection with it or the use of the Mobile Application and '
              'Services, shall be governed by and construed in accordance with '
              '${party.governingLawEn}. You agree that ${party.jurisdictionEn} '
              'shall have exclusive jurisdiction to settle any such dispute or '
              'claim.',
          ne:
              'यो सम्झौता र यससँग वा एप तथा सेवाको प्रयोगसँग सम्बन्धित कुनै पनि '
              'विवाद ${party.governingLawNe} बमोजिम व्याख्या र नियमन हुनेछ । '
              'त्यस्ता विवादको निरूपण गर्ने विशेष क्षेत्राधिकार '
              '${party.jurisdictionNe} मा रहनेछ भन्नेमा तपाईं सहमत हुनुहुन्छ ।',
        ),
      ),
      LegalSection(
        heading: const LegalText(
          en: '10. Contact Us',
          ne: '१०. हामीलाई सम्पर्क गर्नुहोस्',
          hi: '१०. हमसे संपर्क करें',
        ),
        body: LegalText.withHindiSummary(
          hiSummary:
              'सारांश: इस अनुबंध से जुड़े प्रश्न, चिंता या शिकायत के लिए '
              '${party.companyHi}, ${party.addressHi} से ${party.email} पर '
              'संपर्क करें ।',
          en:
              'If you have any questions, concerns, or complaints regarding this '
              'Agreement, we encourage you to contact us: ${party.companyEn}, '
              '${party.addressEn}, e-mail ${party.email}, phone ${party.phone}.',
          ne:
              'यस सम्झौताबारे कुनै प्रश्न, चासो वा गुनासो भए ${party.companyNe}, '
              '${party.addressNe}, इमेल ${party.email}, फोन ${party.phone} मा '
              'सम्पर्क गर्नुहोस् ।',
        ),
      ),
    ],
  );
}
