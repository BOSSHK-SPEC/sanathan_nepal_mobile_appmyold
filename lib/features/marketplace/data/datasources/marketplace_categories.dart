import '../../domain/entities/category.dart';

/// Category ids + trilingual labels shared by the mock data sources and UI.
abstract final class MarketplaceCategories {
  static const String jobs = 'jobs';
  static const String automobiles = 'automobiles';
  static const String realEstate = 'realEstate';
  static const String mensFashion = 'mensFashion';
  static const String gemstones = 'gemstones';
  static const String electronics = 'electronics';
  static const String services = 'services';
  static const String poojaSamagri = 'poojaSamagri';
  static const String homeKitchen = 'homeKitchen';

  static const List<Category> all = [
    Category(
      id: jobs,
      nameEn: 'Jobs',
      nameNe: 'जागिर',
      nameHi: 'नौकरियाँ',
      iconName: 'work',
    ),
    Category(
      id: automobiles,
      nameEn: 'Automobiles',
      nameNe: 'सवारी साधन',
      nameHi: 'वाहन',
      iconName: 'car',
    ),
    Category(
      id: realEstate,
      nameEn: 'Real Estate',
      nameNe: 'घरजग्गा',
      nameHi: 'रियल एस्टेट',
      iconName: 'home',
    ),
    Category(
      id: mensFashion,
      nameEn: "Men's Fashion",
      nameNe: 'पुरुष फेसन',
      nameHi: 'पुरुष फ़ैशन',
      iconName: 'shirt',
    ),
    Category(
      id: gemstones,
      nameEn: 'Gem Stones',
      nameNe: 'रत्न',
      nameHi: 'रत्न',
      iconName: 'diamond',
    ),
    Category(
      id: electronics,
      nameEn: 'Electronics',
      nameNe: 'इलेक्ट्रोनिक्स',
      nameHi: 'इलेक्ट्रॉनिक्स',
      iconName: 'phone',
    ),
    Category(
      id: services,
      nameEn: 'Services',
      nameNe: 'सेवाहरू',
      nameHi: 'सेवाएँ',
      iconName: 'service',
    ),
    Category(
      id: poojaSamagri,
      nameEn: 'Pooja Samagri',
      nameNe: 'पूजा सामग्री',
      nameHi: 'पूजा सामग्री',
      iconName: 'pooja',
    ),
    Category(
      id: homeKitchen,
      nameEn: 'Home & Kitchen',
      nameNe: 'घर र भान्सा',
      nameHi: 'घर और रसोई',
      iconName: 'kitchen',
    ),
  ];
}
