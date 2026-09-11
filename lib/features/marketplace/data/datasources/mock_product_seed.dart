import '../../domain/entities/product.dart';
import '../models/product_comment_model.dart';
import '../../../profile/data/datasources/mock_business_data_source.dart';
import '../models/product_model.dart';
import '../models/seller_model.dart';
import 'marketplace_categories.dart';

part 'mock_product_seed_more.dart';

/// Deterministic bilingual seed listings used by [MockProductDataSource].
///
/// Photos: two legacy assets are reused (pearl / red coral); the rest use the
/// `category:` scheme rendered as themed placeholders by `ProductPhoto`.
abstract final class MockProductSeed {
  static const _kathmandu = 'Basantapur (New Road), Kathmandu';
  static const _kathmanduNe = 'बसन्तपुर (न्यू रोड), काठमाडौँ';

  static const _koreanKitchen = SellerModel(
    id: 's1',
    name: 'Korean Kitchen',
    verified: true,
    phone: '+977-9801234567',
    handle: '@korean_kitchen',
  );

  /// The signed-in seller (owner of every `isMine` listing).
  static const SellerModel currentSeller = _uttam;

  static const _uttam = SellerModel(
    id: 's2',
    name: 'Dr. Uttam Upadhyaya',
    verified: true,
    phone: '+977-9851012345',
    handle: '@uttam_guru',
    avatar: 'assets/images/Photo.png',
  );
  static const _ram = SellerModel(
    id: 's3',
    name: 'Ram Bahadur Thapa',
    phone: '+977-9841122334',
    handle: '@ramthapa',
  );
  static const _sita = SellerModel(
    id: 's4',
    name: 'Sita Sharma',
    verified: true,
    phone: '+977-9861234560',
    handle: '@sitasharma',
  );
  static const _gadget = SellerModel(
    id: 's5',
    name: 'Gadget Hub Nepal',
    verified: true,
    phone: '+977-9812345678',
    handle: '@gadgethub',
  );

  /// Builds the seed relative to [now] so "4 minutes ago" style labels stay
  /// meaningful while remaining fully deterministic for a given [now].
  static List<ProductModel> build(DateTime now) {
    DateTime ago({int minutes = 0, int hours = 0, int days = 0}) =>
        now.subtract(Duration(minutes: minutes, hours: hours, days: days));
    return [
      ProductModel(
        id: 'p1',
        title: 'Toyota Rav4 2012',
        titleNe: 'टोयोटा राभ४ २०१२',
        description:
            'Well maintained Toyota Rav4 2012, single owner, 68,000 km, '
            'new tyres and full service history. Serious buyers only.',
        descriptionNe:
            'राम्रोसँग मर्मत गरिएको टोयोटा राभ४ २०१२, एकल मालिक, ६८,००० किमी, '
            'नयाँ टायर र पूर्ण सर्भिस इतिहास। गम्भीर खरिदकर्ता मात्र।',
        price: 4000000,
        categoryId: MarketplaceCategories.automobiles,
        images: const ['category:automobiles', 'category:automobiles'],
        seller: _ram,
        location: _kathmandu,
        locationNe: _kathmanduNe,
        postedAt: ago(minutes: 4),
        views: 1408,
        likes: 400,
        rating: 4,
        isBoosted: true,
        negotiable: true,
        specs: const {
          'Model Year': '2012',
          'Mileage': '68,000 km',
          'Fuel': 'Petrol',
          'Transmission': 'Automatic',
        },
      ),
      ProductModel(
        id: 'p2',
        title: 'Cook Chef Needed | Thakali, Continental, Korean',
        titleNe: 'कुक शेफ आवश्यक | थकाली, कन्टिनेन्टल, कोरियन',
        description:
            'Cook needed who are skilled in preparing Korean & Thakali cuisine.',
        descriptionNe: 'कोरियन र थकाली परिकार बनाउन सिपालु कुक आवश्यक छ।',
        price: 50000,
        categoryId: MarketplaceCategories.jobs,
        images: const ['category:jobs'],
        seller: _koreanKitchen,
        location: _kathmandu,
        locationNe: _kathmanduNe,
        postedAt: ago(minutes: 4),
        views: 1408,
        likes: 400,
        rating: 4,
        isBoosted: true,
        specs: const {
          'Type': 'Full time',
          'Experience': '2+ years',
          'Salary': 'Rs. 50,000 / month',
        },
      ),
      ProductModel(
        id: 'p3',
        title: 'iPhone 14 Pro Max 256GB, 5G',
        businessId: 'biz-1',
        titleNe: 'आइफोन १४ प्रो म्याक्स २५६ जीबी, ५जी',
        description:
            'Deep purple, 92% battery health, box and charger included. '
            'No scratches, always used with a case.',
        descriptionNe:
            'गाढा बैजनी, ९२% ब्याट्री हेल्थ, बक्स र चार्जर सहित। '
            'कुनै खरोंच छैन, सधैँ केस लगाएर प्रयोग गरिएको।',
        price: 145000,
        categoryId: MarketplaceCategories.electronics,
        images: const ['category:electronics', 'category:electronics'],
        seller: _gadget,
        location: 'Newroad, Kathmandu',
        locationNe: 'न्यूरोड, काठमाडौँ',
        postedAt: ago(hours: 1),
        views: 1408,
        likes: 400,
        rating: 4.5,
        isBoosted: true,
        negotiable: true,
        websiteLink: 'www.gadgethub.com.np',
        expiresAt: ago(days: -30),
        specs: const {
          'Storage': '256 GB',
          'Colour': 'Deep Purple',
          'Battery Health': '92%',
          'Warranty': 'None',
        },
        comments: [
          ProductCommentModel(
            id: 'c1',
            author: 'Ram Bahadur',
            message: 'I want to purchase this product.',
            postedAt: ago(days: 10),
          ),
          ProductCommentModel(
            id: 'c2',
            author: 'Shyam Thapa',
            message: 'Please contact us. Thank You.',
            postedAt: ago(days: 10),
          ),
          ProductCommentModel(
            id: 'c3',
            author: 'Hari Bahadur',
            message: 'Is this the original box?',
            postedAt: ago(days: 9),
          ),
        ],
      ),
      ProductModel(
        id: 'p4',
        title: 'Pearl (मोती)',
        titleNe: 'मोती (Pearl)',
        description:
            'Pearl is a natural, white to somewhat blue dark shaded, valuable '
            'gemstone delivered inside the body of a living creature '
            '‘Mollusc’. Recommended for those with a weak Moon in their '
            'birth chart.\n\n'
            'Who should wear a Pearl?\n\n'
            'If the Moon in the birth chart is with the Sun, or in the first '
            'of the next five signs from the Sun, it is weak – such a person '
            'should wear a pearl. A Moon in a kendra is light; the wearer '
            'should wear a pearl. If the Moon owns the 2nd house (Gemini '
            'ascendant) and sits in the 6th house, wearing a pearl is very '
            'good. If the Moon is the 5th lord in the 12th house, the 7th lord '
            'in the 2nd, the 9th lord in the 4th, the 10th lord in the 5th or '
            'the 11th lord in the 4th house, that person should wear a pearl '
            'as soon as possible.',
        descriptionNe:
            'जसको जन्मकुण्डलीमा चन्द्रमा क्षीण, दुर्बल या दूषित छ भने मोती '
            'लगाउनु पर्दछ । मोतीलाई चन्द्रमाको निम्न स्थितिमा ग्रहण गर्न '
            'सकिन्छ ।\n\n'
            'मोती कसले धारण गर्ने ?\n\n'
            'यदि जन्म कुण्डलीमा चन्द्रमा सूर्यका साथ या सूर्यबाट अर्को पाँच '
            'राशिको पहिलो स्थितिमा छन् भने त्यो क्षीण हुन्छ । त्यसबेला '
            'व्यक्तिले मोती धारण गर्नुपर्दछ । केन्द्रमा रहेको चन्द्रमा हल्का '
            'हुन्छ । यस्तो स्थितिमा धारकले मोती धारण गर्नुपर्दछ । यदि चन्द्रमा '
            'द्वितीय या धन भावको स्वामी (मिथुन लग्नमा) भएर कुण्डलीको छैठौँ '
            'स्थानमा स्थित छ भने मोती धारण गर्नु धेरै राम्रो हुन्छ । यदि जन्म '
            'कुण्डलीमा चन्द्रमा पञ्चमेष भएर १२ औँ भावमा, सप्तमेव भएर दोस्रो '
            'भावमा नवमेश भएर चतुर्थ भावमा, दशमेव पञ्चम भावमा तथा एकादशेश भएर '
            'चतुर्थ भावमा स्थित छन् भने त्यस्तो व्यक्तिले यथाशिघ्र मोती धारण '
            'गर्नुपर्दछ ।',
        price: 15000,
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.gemstones,
        images: const [
          'assets/images/image 4.png',
          'assets/images/image 4.png',
          'category:gemstones',
        ],
        seller: _uttam,
        location: 'Chabahil, Kathmandu',
        locationNe: 'चाबहिल, काठमाडौँ',
        postedAt: ago(hours: 3),
        views: 980,
        likes: 210,
        rating: 5,
        isMine: true,
        businessId: MockBusinessDataSource.myBusinessId,
        websiteLink: 'www.websitedomain.com',
        expiresAt: ago(days: -60),
        specs: const {'Caret': '7', 'Origin': 'South Sea', 'Certified': 'Yes'},
        videos: const ['https://youtu.be/pearl-mollusc-demo'],
        options: const {
          'Caret': ['5', '6', '7', '11'],
          'Select Metal': ['Silver', 'Gold', 'Panchdhatu'],
          'Choose Design': ['Silver Design 1', 'Silver Design 2'],
        },
      ),
      ProductModel(
        id: 'p5',
        title: 'Blue Sapphire (नीलम)',
        titleNe: 'नीलम (Blue Sapphire)',
        description:
            'Certified natural Ceylon blue sapphire, 5.25 ratti. Suitable for '
            'Saturn (Shani) remedies after consultation.',
        descriptionNe:
            'प्रमाणित प्राकृतिक सिलोन नीलम, ५.२५ रत्ती। परामर्श पछि शनि '
            'उपायका लागि उपयुक्त।',
        price: 45000,
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.gemstones,
        images: const ['category:gemstones'],
        seller: _uttam,
        location: 'Chabahil, Kathmandu',
        locationNe: 'चाबहिल, काठमाडौँ',
        postedAt: ago(hours: 5),
        views: 640,
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
        id: 'p6',
        title: 'Red Coral (मुङ्गा)',
        titleNe: 'मुङ्गा (Red Coral)',
        description:
            'Italian red coral, 6 ratti, ideal for Mars (Mangal) remedies.',
        descriptionNe:
            'इटालियन रातो मुङ्गा, ६ रत्ती, मंगल उपायका लागि उपयुक्त।',
        price: 12000,
        condition: ProductCondition.brandNew,
        categoryId: MarketplaceCategories.gemstones,
        images: const ['assets/images/RedCoral.png', 'category:gemstones'],
        seller: _uttam,
        location: 'Chabahil, Kathmandu',
        locationNe: 'चाबहिल, काठमाडौँ',
        postedAt: ago(hours: 8),
        views: 420,
        likes: 88,
        rating: 4,
        isMine: true,
        businessId: MockBusinessDataSource.myBusinessId,
        specs: const {'Ratti': '6', 'Origin': 'Italy'},
      ),
      ProductModel(
        id: 'p7',
        title: '2 BHK Flat for Rent, Baneshwor',
        businessId: 'biz-2',
        titleNe: 'भाडामा २ बीएचके फ्ल्याट, बानेश्वर',
        description:
            'Sunny 2 bedroom flat with parking, 24h water and internet ready. '
            'Rs. 25,000 per month, family preferred.',
        descriptionNe:
            'पार्किङ, २४ घण्टा पानी र इन्टरनेट सहितको घामलाग्ने २ कोठे फ्ल्याट। '
            'मासिक रु. २५,०००, परिवारलाई प्राथमिकता।',
        price: 25000,
        categoryId: MarketplaceCategories.realEstate,
        images: const ['category:realEstate'],
        seller: _sita,
        location: 'New Baneshwor, Kathmandu',
        locationNe: 'नयाँ बानेश्वर, काठमाडौँ',
        postedAt: ago(hours: 12),
        views: 2210,
        likes: 310,
        rating: 4,
        isBoosted: true,
        specs: const {'Bedrooms': '2', 'Floor': '2nd', 'Parking': 'Yes'},
      ),
      ProductModel(
        id: 'p8',
        title: 'Honda Shine 125cc 2019',
        businessId: 'biz-2',
        titleNe: 'होन्डा साइन १२५ सीसी २०१९',
        description:
            'Lot 78, 21,000 km, tax paid till Ashadh, fresh servicing done.',
        descriptionNe:
            'लट ७८, २१,००० किमी, असार सम्म कर तिरिएको, भर्खरै सर्भिसिङ गरिएको।',
        price: 185000,
        categoryId: MarketplaceCategories.automobiles,
        images: const ['category:automobiles'],
        seller: _ram,
        location: 'Pulchowk, Lalitpur',
        locationNe: 'पुल्चोक, ललितपुर',
        postedAt: ago(days: 1),
        views: 860,
        likes: 150,
        rating: 4,
        isBoosted: true,
        negotiable: true,
      ),
      ..._buildMore(now),
    ];
  }
}
