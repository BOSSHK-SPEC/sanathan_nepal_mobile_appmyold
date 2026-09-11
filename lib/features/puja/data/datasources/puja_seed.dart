import '../../../../core/region/region.dart';
import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/puja_service.dart';

/// The puja catalogue.
///
/// Region-selected rather than translated: the temples differ, and a devotee
/// in Delhi booking a Kathmandu temple would be a bug, not a feature.
abstract final class PujaSeed {
  static List<PujaService> forRegion(Region region) =>
      region == Region.india ? _india : _nepal;

  static final List<PujaService> _nepal = [
    const PujaService(
      id: 'puja-rudrabhishek',
      name: LocalizedText(
        ne: 'रुद्राभिषेक',
        en: 'Rudrabhishek',
        hi: 'रुद्राभिषेक',
      ),
      summary: LocalizedText(
        ne: 'भगवान शिवको जलाभिषेक — रोग, ऋण र ग्रह पीडाबाट मुक्तिका लागि।',
        en:
            'The abhishek of Lord Shiva, performed for relief from illness, '
            'debt and difficult planetary periods.',
        hi: 'भगवान शिव का जलाभिषेक — रोग, ऋण और ग्रह पीड़ा से मुक्ति के लिए।',
      ),
      purpose: PujaPurpose.health,
      basePrice: 5100,
      duration: Duration(minutes: 90),
      modes: [PujaMode.templeOnline, PujaMode.atHome],
      templeName: LocalizedText(
        ne: 'पशुपतिनाथ मन्दिर, काठमाडौं',
        en: 'Pashupatinath Temple, Kathmandu',
        hi: 'पशुपतिनाथ मंदिर, काठमांडू',
      ),
      samagriPrice: 1200,
      atHomeSurcharge: 2500,
      priestCount: 2,
      bookingsThisMonth: 184,
      isPopular: true,
      procedure: [
        LocalizedText(
          ne: 'संकल्प र गणेश पूजन',
          en: 'Sankalp in your name and Ganesh puja',
          hi: 'संकल्प और गणेश पूजन',
        ),
        LocalizedText(
          ne: 'रुद्री पाठ सहित जलाभिषेक',
          en: 'Abhishek with Rudri recitation',
          hi: 'रुद्री पाठ सहित जलाभिषेक',
        ),
        LocalizedText(
          ne: 'आरती र प्रसाद वितरण',
          en: 'Aarti and prasad, couriered to you',
          hi: 'आरती और प्रसाद, आपके पते पर',
        ),
      ],
    ),
    const PujaService(
      id: 'puja-lakshmi',
      name: LocalizedText(
        ne: 'श्री लक्ष्मी पूजा',
        en: 'Shri Lakshmi puja',
        hi: 'श्री लक्ष्मी पूजा',
      ),
      summary: LocalizedText(
        ne: 'धन, व्यापार वृद्धि र स्थायित्वका लागि।',
        en: 'For wealth, steady business and stability at home.',
        hi: 'धन, व्यापार वृद्धि और स्थायित्व के लिए।',
      ),
      purpose: PujaPurpose.prosperity,
      basePrice: 3100,
      duration: Duration(minutes: 60),
      modes: [PujaMode.templeOnline, PujaMode.atHome],
      samagriPrice: 900,
      atHomeSurcharge: 2000,
      bookingsThisMonth: 121,
      procedure: [
        LocalizedText(
          ne: 'कलश स्थापना र संकल्प',
          en: 'Kalash sthapana and sankalp',
          hi: 'कलश स्थापना और संकल्प',
        ),
        LocalizedText(
          ne: 'श्री सूक्त पाठ',
          en: 'Shri Sukta recitation',
          hi: 'श्री सूक्त पाठ',
        ),
      ],
    ),
    const PujaService(
      id: 'puja-graha-shanti',
      name: LocalizedText(
        ne: 'नवग्रह शान्ति',
        en: 'Navagraha shanti',
        hi: 'नवग्रह शांति',
      ),
      summary: LocalizedText(
        ne: 'कुण्डलीका अशुभ ग्रहहरूको शान्तिका लागि हवन सहित।',
        en:
            'A homa for the afflicted planets in your chart, with the '
            'remedies your kundli calls for.',
        hi: 'कुंडली के अशुभ ग्रहों की शांति हेतु हवन सहित।',
      ),
      purpose: PujaPurpose.protection,
      basePrice: 7500,
      duration: Duration(minutes: 150),
      modes: [PujaMode.atHome],
      samagriPrice: 2200,
      atHomeSurcharge: 0,
      priestCount: 3,
      bookingsThisMonth: 47,
      procedure: [
        LocalizedText(
          ne: 'ग्रह अनुसार जप संख्या निर्धारण',
          en: 'Japa counts fixed from your chart',
          hi: 'ग्रह अनुसार जप संख्या निर्धारण',
        ),
        LocalizedText(ne: 'नवग्रह हवन', en: 'Navagraha homa', hi: 'नवग्रह हवन'),
      ],
    ),
    const PujaService(
      id: 'puja-satyanarayan',
      name: LocalizedText(
        ne: 'सत्यनारायण कथा',
        en: 'Satyanarayan katha',
        hi: 'सत्यनारायण कथा',
      ),
      summary: LocalizedText(
        ne: 'नयाँ सुरुवात, गृहप्रवेश र मनोकामना पूर्तिका लागि।',
        en: 'For new beginnings, a new home, and vows fulfilled.',
        hi: 'नई शुरुआत, गृहप्रवेश और मनोकामना पूर्ति के लिए।',
      ),
      purpose: PujaPurpose.prosperity,
      basePrice: 2500,
      duration: Duration(minutes: 75),
      modes: [PujaMode.templeOnline, PujaMode.atHome],
      samagriPrice: 800,
      atHomeSurcharge: 1800,
      bookingsThisMonth: 96,
    ),
    const PujaService(
      id: 'puja-pitru',
      name: LocalizedText(
        ne: 'पितृ तर्पण',
        en: 'Pitru tarpan',
        hi: 'पितृ तर्पण',
      ),
      summary: LocalizedText(
        ne: 'पितृहरूको शान्ति र पितृदोष निवारणका लागि।',
        en: 'Offered for the peace of ancestors and relief from pitru dosha.',
        hi: 'पितरों की शांति और पितृदोष निवारण हेतु।',
      ),
      purpose: PujaPurpose.ancestors,
      basePrice: 4100,
      duration: Duration(minutes: 90),
      modes: [PujaMode.templeOnline],
      templeName: LocalizedText(
        ne: 'आर्यघाट, पशुपति',
        en: 'Aryaghat, Pashupati',
        hi: 'आर्यघाट, पशुपति',
      ),
      samagriPrice: 1100,
      bookingsThisMonth: 64,
    ),
  ];

  static final List<PujaService> _india = [
    for (final p in _nepal)
      if (p.id == 'puja-rudrabhishek')
        p.copyWith(
          templeName: const LocalizedText(
            ne: 'काशी विश्वनाथ मन्दिर, वाराणसी',
            en: 'Kashi Vishwanath Temple, Varanasi',
            hi: 'काशी विश्वनाथ मंदिर, वाराणसी',
          ),
          basePrice: 4100,
          samagriPrice: 950,
          atHomeSurcharge: 2100,
        )
      else if (p.id == 'puja-pitru')
        p.copyWith(
          templeName: const LocalizedText(
            ne: 'विष्णुपद मन्दिर, गया',
            en: 'Vishnupad Temple, Gaya',
            hi: 'विष्णुपद मंदिर, गया',
          ),
          basePrice: 3300,
          samagriPrice: 900,
        )
      else
        p.copyWith(
          basePrice: p.basePrice * 0.8,
          samagriPrice: p.samagriPrice * 0.8,
          atHomeSurcharge: p.atHomeSurcharge * 0.8,
        ),
  ];
}
