import '../../domain/entities/product.dart';
import '../models/product_comment_model.dart';
import '../../../profile/data/datasources/mock_business_data_source.dart';
import '../models/product_model.dart';
import '../models/seller_model.dart';
import 'marketplace_categories.dart';

/// Deterministic seed listings for the **India** region, used by
/// `MockProductDataSource` when `RegionResolver.region == Region.india`.
///
/// Same categories as the Nepal seed; Indian cities, INR prices, Indian
/// sellers with `+91` phones. `titleNe` / `descriptionNe` / `locationNe`
/// carry the Hindi text (the local Devanagari language of the region).
abstract final class MockProductSeedIndia {
  static const _cp = 'Connaught Place, New Delhi';
  static const _cpHi = 'कनॉट प्लेस, नई दिल्ली';
  static const _andheri = 'Andheri, Mumbai';
  static const _andheriHi = 'अंधेरी, मुंबई';
  static const _koramangala = 'Koramangala, Bengaluru';
  static const _koramangalaHi = 'कोरमंगला, बेंगलुरु';

  static const _sharma = SellerModel(
    id: 'is1',
    name: 'Rajesh Sharma',
    verified: true,
    phone: '+91-9810012345',
    handle: '@rajesh_sharma',
  );

  /// The signed-in seller (owner of every `isMine` listing).
  static const SellerModel currentSeller = _pandit;

  static const _pandit = SellerModel(
    id: 'is2',
    name: 'Pt. Vinod Mishra',
    verified: true,
    phone: '+91-9873011223',
    handle: '@pandit_vinod',
    avatar: 'assets/images/Photo.png',
  );
  static const _priya = SellerModel(
    id: 'is3',
    name: 'Priya Iyer',
    verified: true,
    phone: '+91-9845098450',
    handle: '@priya_iyer',
  );
  static const _mumbaiElectronics = SellerModel(
    id: 'is4',
    name: 'Mumbai Gadget Store',
    verified: true,
    phone: '+91-9820045678',
    handle: '@mumbaigadgets',
  );
  static const _amit = SellerModel(
    id: 'is5',
    name: 'Amit Verma',
    phone: '+91-9911223344',
    handle: '@amitverma',
  );

  /// Builds the seed relative to [now] so "4 minutes ago" style labels stay
  /// meaningful while remaining fully deterministic for a given [now].
  static List<ProductModel> build(DateTime now) {
    DateTime ago({int minutes = 0, int hours = 0, int days = 0}) =>
        now.subtract(Duration(minutes: minutes, hours: hours, days: days));
    return [
      ProductModel(
        id: 'ip1',
        title: 'Maruti Suzuki Swift VXi 2019',
        titleNe: 'मारुति सुज़ुकी स्विफ्ट VXi २०१९',
        description:
            'Single owner, 42,000 km, full service history at authorised '
            'workshop, new tyres. Delhi registration.',
        descriptionNe:
            'सिंगल ओनर, ४२,००० किमी, अधिकृत वर्कशॉप में पूरी सर्विस हिस्ट्री, '
            'नए टायर। दिल्ली रजिस्ट्रेशन।',
        price: 525000,
        currency: 'INR',
        categoryId: MarketplaceCategories.automobiles,
        images: const ['category:automobiles', 'category:automobiles'],
        seller: _amit,
        location: _cp,
        locationNe: _cpHi,
        postedAt: ago(minutes: 4),
        views: 1320,
        likes: 380,
        rating: 4,
        isBoosted: true,
        negotiable: true,
        specs: const {
          'Model Year': '2019',
          'Mileage': '42,000 km',
          'Fuel': 'Petrol',
          'Transmission': 'Manual',
        },
      ),
      ProductModel(
        id: 'ip2',
        title: 'Cook Needed | North Indian, South Indian, Chinese',
        titleNe: 'कुक चाहिए | उत्तर भारतीय, दक्षिण भारतीय, चाइनीज़',
        description:
            'Experienced cook needed for a family restaurant in Koramangala. '
            'Accommodation provided.',
        descriptionNe:
            'कोरमंगला के एक फैमिली रेस्टोरेंट के लिए अनुभवी कुक चाहिए। रहने की '
            'व्यवस्था उपलब्ध।',
        price: 25000,
        currency: 'INR',
        categoryId: MarketplaceCategories.jobs,
        images: const ['category:jobs'],
        seller: _priya,
        location: _koramangala,
        locationNe: _koramangalaHi,
        postedAt: ago(minutes: 4),
        views: 980,
        likes: 210,
        rating: 4,
        isBoosted: true,
        specs: const {
          'Type': 'Full time',
          'Experience': '2+ years',
          'Salary': '₹25,000 / month',
        },
      ),
      ProductModel(
        id: 'ip3',
        title: 'iPhone 14 Pro Max 256GB, 5G',
        businessId: 'biz-1',
        titleNe: 'आईफ़ोन १४ प्रो मैक्स २५६ जीबी, ५जी',
        description:
            'Deep purple, 92% battery health, box and charger included. '
            'No scratches, always used with a case.',
        descriptionNe:
            'डीप पर्पल, ९२% बैटरी हेल्थ, बॉक्स और चार्जर सहित। '
            'कोई खरोंच नहीं, हमेशा कवर के साथ इस्तेमाल किया।',
        price: 89000,
        currency: 'INR',
        categoryId: MarketplaceCategories.electronics,
        images: const ['category:electronics', 'category:electronics'],
        seller: _mumbaiElectronics,
        location: _andheri,
        locationNe: _andheriHi,
        postedAt: ago(hours: 1),
        views: 1408,
        likes: 400,
        rating: 4.5,
        isBoosted: true,
        negotiable: true,
        websiteLink: 'www.mumbaigadgets.in',
        expiresAt: ago(days: -30),
        specs: const {
          'Storage': '256 GB',
          'Colour': 'Deep Purple',
          'Battery Health': '92%',
          'Warranty': 'None',
        },
        comments: [
          ProductCommentModel(
            id: 'ic1',
            author: 'Rohit Kumar',
            message: 'Is the price negotiable?',
            postedAt: ago(days: 10),
          ),
          ProductCommentModel(
            id: 'ic2',
            author: 'Sneha Patil',
            message: 'Please share the bill copy.',
            postedAt: ago(days: 9),
          ),
        ],
      ),
      ProductModel(
        id: 'ip4',
        title: 'Pearl (मोती)',
        titleNe: 'मोती (Pearl)',
        description:
            'Natural South Sea pearl, lab certified. Recommended for those '
            'with a weak Moon in their birth chart.',
        descriptionNe:
            'प्राकृतिक साउथ सी मोती, लैब प्रमाणित। जिनकी कुंडली में चंद्रमा '
            'कमज़ोर हो उनके लिए अनुशंसित।',
        price: 9500,
        currency: 'INR',
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.gemstones,
        images: const [
          'assets/images/image 4.png',
          'assets/images/image 4.png',
          'category:gemstones',
        ],
        seller: _pandit,
        location: 'Varanasi, Uttar Pradesh',
        locationNe: 'वाराणसी, उत्तर प्रदेश',
        postedAt: ago(hours: 3),
        views: 860,
        likes: 190,
        rating: 5,
        isMine: true,
        businessId: MockBusinessDataSource.myBusinessId,
        websiteLink: 'www.jyotishratna.in',
        expiresAt: ago(days: -60),
        specs: const {'Carat': '7', 'Origin': 'South Sea', 'Certified': 'Yes'},
        options: const {
          'Carat': ['5', '6', '7', '11'],
          'Select Metal': ['Silver', 'Gold', 'Panchdhatu'],
          'Choose Design': ['Silver Design 1', 'Silver Design 2'],
        },
      ),
      ProductModel(
        id: 'ip5',
        title: 'Blue Sapphire (नीलम)',
        titleNe: 'नीलम (Blue Sapphire)',
        description:
            'Certified natural Ceylon blue sapphire, 5.25 ratti. Suitable for '
            'Saturn (Shani) remedies after consultation.',
        descriptionNe:
            'प्रमाणित प्राकृतिक सीलोन नीलम, ५.२५ रत्ती। परामर्श के बाद शनि '
            'उपाय के लिए उपयुक्त।',
        price: 32000,
        currency: 'INR',
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.gemstones,
        images: const ['category:gemstones'],
        seller: _pandit,
        location: 'Varanasi, Uttar Pradesh',
        locationNe: 'वाराणसी, उत्तर प्रदेश',
        postedAt: ago(hours: 5),
        views: 610,
        likes: 120,
        rating: 4.5,
        isMine: true,
        businessId: MockBusinessDataSource.myBusinessId,
        specs: const {'Ratti': '5.25', 'Origin': 'Ceylon'},
        options: const {
          'Select Metal': ['Silver', 'Gold'],
        },
      ),
      ProductModel(
        id: 'ip6',
        title: '2 BHK Flat for Rent, Andheri West',
        businessId: 'biz-2',
        titleNe: 'किराए पर २ बीएचके फ़्लैट, अंधेरी वेस्ट',
        description:
            'Semi-furnished 2 BHK with parking, 24h water and society '
            'security. ₹45,000 per month, family preferred.',
        descriptionNe:
            'पार्किंग, २४ घंटे पानी और सोसाइटी सुरक्षा सहित सेमी-फर्निश्ड २ '
            'बीएचके। मासिक ₹४५,०००, परिवार को प्राथमिकता।',
        price: 45000,
        currency: 'INR',
        categoryId: MarketplaceCategories.realEstate,
        images: const ['category:realEstate'],
        seller: _sharma,
        location: _andheri,
        locationNe: _andheriHi,
        postedAt: ago(hours: 12),
        views: 2010,
        likes: 290,
        rating: 4,
        isBoosted: true,
        specs: const {'Bedrooms': '2', 'Floor': '5th', 'Parking': 'Yes'},
      ),
      ProductModel(
        id: 'ip7',
        title: 'Honda Activa 6G 2021',
        businessId: 'biz-2',
        titleNe: 'होंडा एक्टिवा 6G २०२१',
        description:
            '18,000 km, insurance valid till March, recently serviced.',
        descriptionNe:
            '१८,००० किमी, मार्च तक बीमा वैध, हाल ही में सर्विस कराई गई।',
        price: 62000,
        currency: 'INR',
        categoryId: MarketplaceCategories.automobiles,
        images: const ['category:automobiles'],
        seller: _amit,
        location: 'Lajpat Nagar, New Delhi',
        locationNe: 'लाजपत नगर, नई दिल्ली',
        postedAt: ago(days: 1),
        views: 720,
        likes: 130,
        rating: 4,
        isBoosted: true,
        negotiable: true,
      ),
      ProductModel(
        id: 'ip8',
        title: 'Handloom Kurta Pyjama Set (Khadi)',
        titleNe: 'हैंडलूम कुर्ता पायजामा सेट (खादी)',
        description:
            'Pure khadi cotton kurta pyjama, all sizes available, custom '
            'stitching within 3 days.',
        descriptionNe:
            'शुद्ध खादी सूती कुर्ता पायजामा, सभी साइज़ उपलब्ध, ३ दिन में कस्टम '
            'सिलाई।',
        price: 2400,
        currency: 'INR',
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.mensFashion,
        images: const ['category:mensFashion'],
        seller: _priya,
        location: 'Chandni Chowk, New Delhi',
        locationNe: 'चांदनी चौक, नई दिल्ली',
        postedAt: ago(days: 1, hours: 4),
        views: 480,
        likes: 88,
        rating: 4.5,
        options: const {
          'Size': ['S', 'M', 'L', 'XL'],
        },
      ),
      ProductModel(
        id: 'ip9',
        title: 'Samsung 43" Crystal 4K Smart TV',
        titleNe: 'सैमसंग ४३" क्रिस्टल ४के स्मार्ट टीवी',
        description: 'Sealed box, 2 years official warranty, free delivery.',
        descriptionNe:
            'सील बंद बॉक्स, २ साल की आधिकारिक वारंटी, मुफ़्त डिलीवरी।',
        price: 32990,
        currency: 'INR',
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.electronics,
        images: const ['category:electronics'],
        seller: _mumbaiElectronics,
        location: _andheri,
        locationNe: _andheriHi,
        postedAt: ago(days: 2, hours: 6),
        views: 690,
        likes: 120,
        rating: 4.5,
      ),
      ProductModel(
        id: 'ip10',
        title: 'Vedic Astrology Consultation (Kundali)',
        titleNe: 'वैदिक ज्योतिष परामर्श (कुंडली)',
        description:
            '45 minute one-to-one consultation on birth chart, career and '
            'remedies. Online or in person.',
        descriptionNe:
            'जन्म कुंडली, करियर और उपायों पर ४५ मिनट का व्यक्तिगत परामर्श। '
            'ऑनलाइन या प्रत्यक्ष।',
        price: 1100,
        currency: 'INR',
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.services,
        images: const ['category:services'],
        seller: _pandit,
        location: 'Varanasi, Uttar Pradesh',
        locationNe: 'वाराणसी, उत्तर प्रदेश',
        postedAt: ago(days: 3, hours: 5),
        views: 1150,
        likes: 330,
        rating: 5,
        isMine: true,
        businessId: MockBusinessDataSource.myBusinessId,
      ),
      ProductModel(
        id: 'ip11',
        title: 'Rudraksha Mala – 5 Mukhi (108 beads)',
        titleNe: 'रुद्राक्ष माला – ५ मुखी (१०८ दाने)',
        description:
            'Original Nepali rudraksha, lab tested, with silver capping.',
        descriptionNe:
            'असली नेपाली रुद्राक्ष, लैब परीक्षित, चाँदी की कैपिंग सहित।',
        price: 1500,
        currency: 'INR',
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.poojaSamagri,
        images: const ['category:poojaSamagri'],
        seller: _sharma,
        location: 'Haridwar, Uttarakhand',
        locationNe: 'हरिद्वार, उत्तराखंड',
        postedAt: ago(days: 4),
        views: 830,
        likes: 240,
        rating: 4.5,
      ),
      ProductModel(
        id: 'ip12',
        title: 'Handmade Copper Kalash Set',
        titleNe: 'हस्तनिर्मित तांबे का कलश सेट',
        description: 'Pure copper kalash with plate and coconut stand, 1.2 kg.',
        descriptionNe:
            'थाली और नारियल स्टैंड सहित शुद्ध तांबे का कलश, १.२ किलो।',
        price: 1899,
        currency: 'INR',
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.homeKitchen,
        images: const ['category:homeKitchen'],
        seller: _priya,
        location: _koramangala,
        locationNe: _koramangalaHi,
        postedAt: ago(days: 5),
        views: 390,
        likes: 65,
        rating: 4,
      ),
    ];
  }
}
