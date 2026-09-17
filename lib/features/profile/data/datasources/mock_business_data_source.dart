import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/business_profile.dart';
import '../models/business_profile_model.dart';

/// Source of business/seller profiles.
abstract interface class BusinessDataSource {
  Future<BusinessProfileModel> getBusiness(String id);

  /// The signed-in user's own business.
  ///
  /// Asked for by identity rather than by id: the app cannot know the id of a
  /// business it has not loaded yet, and guessing one — as it did with a mock
  /// constant — means a real, saved business is reported as "not found" and
  /// the owner is shown an empty create form.
  ///
  /// Throws [NotFoundException] when the user has no business.
  Future<BusinessProfileModel> myBusiness();

  /// The moderation queue: every listing on the platform, not just the
  /// caller's own. Staff-only server-side, so a seeker calling it is
  /// refused rather than quietly handed their own record.
  Future<List<BusinessProfileModel>> listBusinesses({BusinessStatus? status});
  Future<BusinessProfileModel> upsert(BusinessProfileModel model);

  /// Changes or removes ([url] null) one picture of the caller's business.
  Future<BusinessProfileModel> setImage(BusinessImageSlot slot, String? url);

  /// Records a moderation decision on someone else's business.
  ///
  /// Separate from [upsert] because it is a different act on a different
  /// endpoint: `upsert` is an owner editing their own listing, this is a
  /// reviewer deciding on another user's. Routing the decision through
  /// `upsert` — as this used to — sends it to `/business/mine` and edits the
  /// *reviewer's* business instead.
  Future<BusinessProfileModel> setStatus(
    String id,
    BusinessStatus status, {
    String note = '',
  });
  Future<BusinessProfileModel> addReview(
    String businessId,
    int rating,
    String text,
  );
}

/// Deterministic seed businesses (per region, resolved at call time through
/// [RegionResolver]) + user-created businesses persisted in [KeyValueStore]
/// (so a submitted form survives restarts).
class MockBusinessDataSource implements BusinessDataSource {
  MockBusinessDataSource(this._store, this._resolver);
  final KeyValueStore _store;
  final RegionResolver _resolver;

  static const String _kUserBusinesses = 'profile.businesses';

  /// Business owned by the current user (id used by the form).
  static const String myBusinessId = 'my-business';

  /// Seed businesses for [config]'s region (ids `biz-1`, `biz-2` in both).
  static List<BusinessProfileModel> seedFor(RegionConfig config) =>
      (config.isIndia ? _seedIndia(config) : _seedNepal(config))
          .map(BusinessProfileModel.fromEntity)
          .toList();

  static String _money(RegionConfig config, num amount) =>
      RegionFormat.money(amount, config: config, languageCode: 'en');

  static String _range(RegionConfig config, num from, num to) =>
      '${_money(config, from)} - ${_money(config, to)}';

  static List<BusinessProfile> _seedNepal(RegionConfig c) => [
    BusinessProfile(
      id: 'biz-1',
      name: 'Uttam Astro & Gems',
      category: 'Astrology & Gemstones',
      tagline: 'Authentic gemstones and Vedic astrology consultations',
      description:
          'Uttam Astro & Gems has served devotees since 2065 B.S. with '
          'certified gemstones, Rudraksha, Cheena reading and Vastu advice. '
          'All stones are lab tested and energised before delivery.',
      email: 'uttam.astro@gmail.com',
      phone: '${c.phonePrefix}-9841234567',
      whatsapp: '${c.phonePrefix}-9841234567',
      website: 'www.uttamastro.com',
      address: 'Basantapur (New Road), Kathmandu',
      mapLink: 'https://maps.google.com/?q=Basantapur+Kathmandu',
      workingHours: 'Sun – Fri, 10:00 AM – 6:00 PM',
      taxId: 'PAN 601234567',
      verified: true,
      rating: 4.3,
      reviewCount: 42,
      recommendedPercent: 88,
      followers: 1240,
      status: BusinessStatus.approved,
      items: [
        BusinessItem(
          id: 'p-1',
          title: 'Blue Sapphire (Neelam)',
          description: 'Certified 5.25 ratti Ceylon Neelam with lab report.',
          priceLabel: _range(c, 10000, 20000),
          category: 'Gemstones',
        ),
        BusinessItem(
          id: 'p-2',
          title: 'Red Coral (Moonga)',
          description: 'Italian red coral, natural, energised for Mangal.',
          priceLabel: _money(c, 6000),
          category: 'Gemstones',
        ),
        BusinessItem(
          id: 'p-3',
          title: '5 Mukhi Rudraksha Mala',
          description: '108 beads Nepali Rudraksha mala.',
          priceLabel: _money(c, 2500),
          category: 'Rudraksha',
        ),
        BusinessItem(
          id: 's-1',
          title: 'Cheena Reading',
          description: 'Detailed birth chart (चिना) reading, 45 minutes.',
          priceLabel: _money(c, 1500),
          category: 'Consultation',
          isService: true,
        ),
        BusinessItem(
          id: 's-2',
          title: 'Vastu Consultation',
          description: 'Home & office Vastu visit within Kathmandu valley.',
          priceLabel: _range(c, 5000, 15000),
          category: 'Consultation',
          isService: true,
        ),
      ],
      reviews: [
        BusinessReview(
          id: 'r-1',
          author: 'Sita Sharma',
          rating: 5,
          date: DateTime(2023, 3, 12),
          text: 'Very genuine gemstones and detailed reading. Recommended!',
          helpfulCount: 12,
        ),
        BusinessReview(
          id: 'r-2',
          author: 'Bikash Thapa',
          rating: 4,
          date: DateTime(2023, 2, 28),
          text: 'Good service, delivery took a couple of days more.',
          helpfulCount: 4,
        ),
        BusinessReview(
          id: 'r-3',
          author: 'Anita Rai',
          rating: 4,
          date: DateTime(2023, 1, 15),
          text: 'Cheena reading was accurate and explained well.',
          helpfulCount: 7,
        ),
      ],
      documents: const ['PAN Certificate.pdf', 'Company Registration.pdf'],
    ),
    BusinessProfile(
      id: 'biz-2',
      name: 'Shree Gems & Jewels',
      category: 'Jewellery',
      tagline: 'Handcrafted silver & Rudraksha jewellery',
      description: 'Family-run jewellery workshop in Boudha since 2050 B.S.',
      email: 'shreegems@gmail.com',
      phone: '${c.phonePrefix}-9803334444',
      website: 'www.shreegems.com.np',
      address: 'Boudha, Kathmandu',
      workingHours: 'Everyday, 9:00 AM – 7:00 PM',
      rating: 4.6,
      reviewCount: 18,
      recommendedPercent: 94,
      followers: 530,
      status: BusinessStatus.pending,
      items: [
        BusinessItem(
          id: 'p-4',
          title: 'Silver Rudraksha Bracelet',
          description: 'Sterling silver with 7 mukhi beads.',
          priceLabel: _money(c, 3200),
          category: 'Bracelets',
        ),
      ],
    ),
  ];

  static List<BusinessProfile> _seedIndia(RegionConfig c) => [
    BusinessProfile(
      id: 'biz-1',
      name: 'Sharma Jyotish & Ratna Kendra',
      category: 'Astrology & Gemstones',
      tagline: 'Certified gemstones and Vedic astrology consultations',
      description:
          'Sharma Jyotish & Ratna Kendra has served devotees in Delhi '
          'since 2008 with certified gemstones, Rudraksha, Kundali reading '
          'and Vastu advice. All stones are lab tested and energised '
          'before delivery.',
      email: 'sharma.jyotish@gmail.com',
      phone: '${c.phonePrefix}-9810123456',
      whatsapp: '${c.phonePrefix}-9810123456',
      website: 'www.sharmajyotish.in',
      address: 'Chandni Chowk, Old Delhi, New Delhi 110006',
      mapLink: 'https://maps.google.com/?q=Chandni+Chowk+Delhi',
      workingHours: 'Mon – Sat, 10:00 AM – 7:00 PM',
      taxId: 'GSTIN 07AAACS1234A1Z5',
      verified: true,
      rating: 4.4,
      reviewCount: 57,
      recommendedPercent: 90,
      followers: 2130,
      status: BusinessStatus.approved,
      items: [
        BusinessItem(
          id: 'p-1',
          title: 'Blue Sapphire (Neelam)',
          description: 'Certified 5.25 ratti Ceylon Neelam with lab report.',
          priceLabel: _range(c, 8000, 16000),
          category: 'Gemstones',
        ),
        BusinessItem(
          id: 'p-2',
          title: 'Red Coral (Moonga)',
          description: 'Italian red coral, natural, energised for Mangal.',
          priceLabel: _money(c, 4500),
          category: 'Gemstones',
        ),
        BusinessItem(
          id: 'p-3',
          title: '5 Mukhi Rudraksha Mala',
          description: '108 beads Nepali Rudraksha mala.',
          priceLabel: _money(c, 1800),
          category: 'Rudraksha',
        ),
        BusinessItem(
          id: 's-1',
          title: 'Kundali Reading',
          description: 'Detailed birth chart (कुंडली) reading, 45 minutes.',
          priceLabel: _money(c, 1100),
          category: 'Consultation',
          isService: true,
        ),
        BusinessItem(
          id: 's-2',
          title: 'Vastu Consultation',
          description: 'Home & office Vastu visit within Delhi NCR.',
          priceLabel: _range(c, 3500, 11000),
          category: 'Consultation',
          isService: true,
        ),
      ],
      reviews: [
        BusinessReview(
          id: 'r-1',
          author: 'Neha Gupta',
          rating: 5,
          date: DateTime(2023, 3, 12),
          text: 'Very genuine gemstones and detailed reading. Recommended!',
          helpfulCount: 15,
        ),
        BusinessReview(
          id: 'r-2',
          author: 'Rahul Verma',
          rating: 4,
          date: DateTime(2023, 2, 28),
          text: 'Good service, delivery took a couple of days more.',
          helpfulCount: 5,
        ),
        BusinessReview(
          id: 'r-3',
          author: 'Anjali Singh',
          rating: 4,
          date: DateTime(2023, 1, 15),
          text: 'Kundali reading was accurate and explained well.',
          helpfulCount: 9,
        ),
      ],
      documents: const ['GST Certificate.pdf', 'Udyam Registration.pdf'],
    ),
    BusinessProfile(
      id: 'biz-2',
      name: 'Shree Gems & Jewels',
      category: 'Jewellery',
      tagline: 'Handcrafted silver & Rudraksha jewellery',
      description:
          'Family-run jewellery workshop at Zaveri Bazaar, Mumbai since '
          '1994.',
      email: 'shreegems@gmail.com',
      phone: '${c.phonePrefix}-9820334455',
      website: 'www.shreegems.co.in',
      address: 'Zaveri Bazaar, Kalbadevi, Mumbai 400002',
      workingHours: 'Everyday, 10:00 AM – 8:00 PM',
      taxId: 'GSTIN 27AABCS5678B1Z9',
      rating: 4.6,
      reviewCount: 24,
      recommendedPercent: 95,
      followers: 860,
      status: BusinessStatus.pending,
      items: [
        BusinessItem(
          id: 'p-4',
          title: 'Silver Rudraksha Bracelet',
          description: 'Sterling silver with 7 mukhi beads.',
          priceLabel: _money(c, 2400),
          category: 'Bracelets',
        ),
      ],
    ),
  ];

  Map<String, BusinessProfileModel> _userBusinesses() {
    final raw = _store.getString(_kUserBusinesses);
    if (raw == null || raw.isEmpty) return {};
    final list = jsonDecode(raw) as List<dynamic>;
    return {
      for (final j in list)
        (j as Map<String, dynamic>)['id'] as String:
            BusinessProfileModel.fromJson(j),
    };
  }

  Future<void> _saveUserBusinesses(Map<String, BusinessProfileModel> map) =>
      _store.setString(
        _kUserBusinesses,
        jsonEncode(map.values.map((b) => b.toJson()).toList()),
      );

  @override
  Future<BusinessProfileModel> getBusiness(String id) async {
    final stored = _userBusinesses()[id];
    if (stored != null) return stored;
    for (final b in seedFor(_resolver.config)) {
      if (b.id == id) return b;
    }
    throw const NotFoundException('Business not found');
  }

  @override
  Future<BusinessProfileModel> myBusiness() => getBusiness(myBusinessId);

  @override
  Future<List<BusinessProfileModel>> listBusinesses({
    BusinessStatus? status,
  }) async {
    final stored = _userBusinesses();
    final seeds = seedFor(_resolver.config);
    final all = [
      for (final b in seeds) stored[b.id] ?? b,
      for (final b in stored.values)
        if (!seeds.any((s) => s.id == b.id)) b,
    ];
    // Filtered here so the mock and the API agree on what the argument
    // means, rather than one of them ignoring it.
    if (status == null) return all;
    return [
      for (final b in all)
        if (b.status == status) b,
    ];
  }

  @override
  Future<BusinessProfileModel> setStatus(
    String id,
    BusinessStatus status, {
    String note = '',
  }) async {
    final current = await getBusiness(id);
    final saved = current.copyWith(status: status, moderationNote: note);
    await _saveUserBusinesses(_userBusinesses()..[id] = saved);
    return saved;
  }

  @override
  Future<BusinessProfileModel> setImage(
    BusinessImageSlot slot,
    String? url,
  ) async {
    final current = await myBusiness();
    return upsert(
      slot == BusinessImageSlot.logo
          ? current.copyWith(logoUrl: url)
          : current.copyWith(coverUrl: url),
    );
  }

  @override
  Future<BusinessProfileModel> upsert(BusinessProfileModel model) async {
    // The store assigns the id for a new record, exactly as the server does —
    // the form cannot know it before the business exists, so it submits with
    // an empty one.
    final saved = model.id.isEmpty ? model.copyWith(id: myBusinessId) : model;
    final map = _userBusinesses()..[saved.id] = saved;
    await _saveUserBusinesses(map);
    return saved;
  }

  @override
  Future<BusinessProfileModel> addReview(
    String businessId,
    int rating,
    String text,
  ) async {
    final current = await getBusiness(businessId);
    final newReview = BusinessReviewModel(
      id: 'review-${DateTime.now().millisecondsSinceEpoch}',
      author: 'You',
      rating: rating,
      date: DateTime.now(),
      text: text,
    );
    final updated = current.copyWith(reviews: [newReview, ...current.reviews]);
    return upsert(updated);
  }
}
