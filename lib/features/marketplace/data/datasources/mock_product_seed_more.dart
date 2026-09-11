part of 'mock_product_seed.dart';

/// Second half of the seed (kept in a separate file for readability).
List<ProductModel> _buildMore(DateTime now) {
  DateTime ago({int minutes = 0, int hours = 0, int days = 0}) =>
      now.subtract(Duration(minutes: minutes, hours: hours, days: days));
  return [
    ProductModel(
      id: 'p9',
      title: 'Daura Suruwal Set (Handloom)',
      titleNe: 'दौरा सुरुवाल सेट (हातेतान)',
      description:
          'Traditional handloom cotton daura suruwal, all sizes available, '
          'custom stitching within 3 days.',
      descriptionNe:
          'परम्परागत हातेतान सुती दौरा सुरुवाल, सबै साइज उपलब्ध, ३ दिन भित्र '
          'सिलाइ।',
      price: 6500,
      condition: ProductCondition.brandNew,
      categoryId: MarketplaceCategories.mensFashion,
      images: const ['category:mensFashion'],
      seller: MockProductSeed._sita,
      location: 'Asan, Kathmandu',
      locationNe: 'असन, काठमाडौँ',
      postedAt: ago(days: 1, hours: 4),
      views: 530,
      likes: 95,
      rating: 4.5,
      options: const {
        'Size': ['S', 'M', 'L', 'XL'],
      },
    ),
    ProductModel(
      id: 'p10',
      title: 'Delivery Rider Wanted (Bike Provided)',
      titleNe: 'डेलिभरी राइडर आवश्यक (बाइक उपलब्ध)',
      description:
          'Full time delivery rider for Kathmandu valley. Salary plus fuel '
          'allowance and incentives.',
      descriptionNe:
          'काठमाडौँ उपत्यकाका लागि पूर्णकालीन डेलिभरी राइडर। तलब, इन्धन भत्ता र '
          'प्रोत्साहन सहित।',
      price: 25000,
      categoryId: MarketplaceCategories.jobs,
      images: const ['category:jobs'],
      seller: MockProductSeed._gadget,
      location: 'Koteshwor, Kathmandu',
      locationNe: 'कोटेश्वर, काठमाडौँ',
      postedAt: ago(days: 2),
      views: 300,
      likes: 40,
      rating: 3.5,
    ),
    ProductModel(
      id: 'p11',
      title: 'Samsung 43" Crystal 4K Smart TV',
      titleNe: 'सामसुङ ४३" क्रिस्टल ४के स्मार्ट टिभी',
      description: 'Sealed box, 2 years official warranty, free delivery.',
      descriptionNe:
          'सिल बन्द बक्स, २ वर्ष आधिकारिक वारेन्टी, निःशुल्क डेलिभरी।',
      price: 62000,
      condition: ProductCondition.brandNew,
      categoryId: MarketplaceCategories.electronics,
      images: const ['category:electronics'],
      seller: MockProductSeed._gadget,
      location: 'Newroad, Kathmandu',
      locationNe: 'न्यूरोड, काठमाडौँ',
      postedAt: ago(days: 2, hours: 6),
      views: 710,
      likes: 130,
      rating: 4.5,
    ),
    ProductModel(
      id: 'p12',
      title: '4 Aana Land at Suryabinayak',
      titleNe: 'सूर्यविनायकमा ४ आना जग्गा',
      description:
          'Residential plot with 13 ft road access, clear ownership, near '
          'Araniko highway.',
      descriptionNe:
          '१३ फिट बाटो सुविधा सहितको आवासीय घडेरी, स्पष्ट स्वामित्व, अरनिको '
          'राजमार्ग नजिक।',
      price: 12000000,
      categoryId: MarketplaceCategories.realEstate,
      images: const ['category:realEstate'],
      seller: MockProductSeed._ram,
      location: 'Suryabinayak, Bhaktapur',
      locationNe: 'सूर्यविनायक, भक्तपुर',
      postedAt: ago(days: 3),
      views: 1500,
      likes: 220,
      rating: 4,
      negotiable: true,
    ),
    ProductModel(
      id: 'p13',
      title: 'Vedic Astrology Consultation (Kundali)',
      titleNe: 'वैदिक ज्योतिष परामर्श (कुण्डली)',
      description:
          '45 minute one-to-one consultation on birth chart, career and '
          'remedies. Online or in person.',
      descriptionNe:
          'जन्मकुण्डली, करियर र उपायबारे ४५ मिनेटको व्यक्तिगत परामर्श। अनलाइन '
          'वा प्रत्यक्ष।',
      price: 1500,
      condition: ProductCondition.brandNew,
      categoryId: MarketplaceCategories.services,
      images: const ['category:services'],
      seller: MockProductSeed._uttam,
      location: 'Chabahil, Kathmandu',
      locationNe: 'चाबहिल, काठमाडौँ',
      postedAt: ago(days: 3, hours: 5),
      views: 1200,
      likes: 350,
      rating: 5,
      isMine: true,
      businessId: MockBusinessDataSource.myBusinessId,
    ),
    ProductModel(
      id: 'p14',
      title: 'Rudraksha Mala – 5 Mukhi (108 beads)',
      titleNe: 'रुद्राक्ष माला – ५ मुखी (१०८ दाना)',
      description:
          'Original Nepali rudraksha, lab tested, with silver capping.',
      descriptionNe:
          'असली नेपाली रुद्राक्ष, प्रयोगशाला परीक्षण गरिएको, चाँदीको क्यापिङ सहित।',
      price: 2500,
      condition: ProductCondition.brandNew,
      categoryId: MarketplaceCategories.poojaSamagri,
      images: const ['category:poojaSamagri'],
      seller: MockProductSeed._sita,
      location: 'Pashupati, Kathmandu',
      locationNe: 'पशुपति, काठमाडौँ',
      postedAt: ago(days: 4),
      views: 890,
      likes: 260,
      rating: 4.5,
    ),
    ProductModel(
      id: 'p15',
      title: 'Handmade Copper Kalash Set',
      titleNe: 'हाते तामाको कलश सेट',
      description: 'Pure copper kalash with plate and coconut stand, 1.2 kg.',
      descriptionNe: 'थाल र नरिवल स्ट्यान्ड सहित शुद्ध तामाको कलश, १.२ किलो।',
      price: 3200,
      condition: ProductCondition.brandNew,
      categoryId: MarketplaceCategories.homeKitchen,
      images: const ['category:homeKitchen'],
      seller: MockProductSeed._sita,
      location: 'Patan, Lalitpur',
      locationNe: 'पाटन, ललितपुर',
      postedAt: ago(days: 5),
      views: 410,
      likes: 70,
      rating: 4,
    ),
    ProductModel(
      id: 'p16',
      title: 'Leather Jacket (Genuine), Size L',
      titleNe: 'छालाको ज्याकेट (असली), साइज एल',
      description: 'Lightly used genuine leather jacket, bought in Pokhara.',
      descriptionNe: 'थोरै प्रयोग गरिएको असली छालाको ज्याकेट, पोखरामा किनिएको।',
      price: 4500,
      categoryId: MarketplaceCategories.mensFashion,
      images: const ['category:mensFashion'],
      seller: MockProductSeed._ram,
      location: 'Lakeside, Pokhara',
      locationNe: 'लेकसाइड, पोखरा',
      postedAt: ago(days: 6),
      views: 260,
      likes: 30,
      rating: 3.5,
    ),
  ];
}
