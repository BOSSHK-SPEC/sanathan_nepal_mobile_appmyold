import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region_all.dart';
import '../../domain/entities/product_draft.dart';
import '../../domain/entities/product_filter.dart';
import '../models/product_model.dart';
import '../models/seller_model.dart';
import '../../../profile/data/datasources/mock_business_data_source.dart';
import '../../domain/entities/category.dart';
import 'marketplace_categories.dart';
import 'mock_product_seed.dart';
import 'mock_product_seed_india.dart';

/// Contract for listing data (mock today, REST tomorrow).
abstract interface class ProductDataSource {
  Future<List<ProductModel>> fetchProducts(ProductFilter filter);

  /// The signed-in seller's own listings.
  ///
  /// Its own call rather than a filter over the public feed: the feed is one
  /// region-scoped page ordered by recency, so filtering it client-side loses
  /// a seller's products the moment other people post more than a page of
  /// newer ones — and loses them silently, from the seller's own screen.
  Future<List<ProductModel>> myProducts();
  Future<ProductModel> fetchById(String id);
  Future<ProductModel> toggleFavourite(String id);
  Future<ProductModel> create(ProductDraft draft);
  Future<ProductModel> update(String id, ProductDraft draft);
  Future<void> delete(String id);

  /// The category list the seller form and the browse chips are built
  /// from.
  ///
  /// It has to come from here rather than a local constant: the server
  /// identifies a category by ULID, and a hardcoded slug like
  /// `poojaSamagri` is rejected outright when a listing is published.
  Future<List<Category>> fetchCategories();
}

/// In-memory implementation backed by the region seed – [MockProductSeed]
/// (Nepal) or [MockProductSeedIndia] (India), chosen from
/// `resolver.region` **at call time** so a region switch shows the other
/// catalogue on the next fetch.
///
/// Favourite toggles and seller create / update / delete are kept per region
/// for the lifetime of the app so the UI feels real; everything else is
/// deterministic.
class MockProductDataSource implements ProductDataSource {
  MockProductDataSource({
    DateTime Function()? clock,
    RegionResolver resolver = const FixedRegionResolver(Region.nepal),
  }) : _clock = clock ?? DateTime.now,
       _resolver = resolver;

  final DateTime Function() _clock;
  final RegionResolver _resolver;
  final Map<Region, List<ProductModel>> _cache = {};

  /// Image "source" prefix rendered as a themed category placeholder by the
  /// presentation layer (`ProductPhoto`) – used when a seller adds no photo.
  static const String categoryImageScheme = 'category:';

  /// Small artificial latency so loading states are visible.
  static const Duration _latency = Duration(milliseconds: 150);

  /// Seed for the region that is active right now (built lazily once).
  List<ProductModel> get _products {
    final region = _resolver.region;
    return _cache.putIfAbsent(region, () => seedFor(region, _clock()));
  }

  /// Seed listings for [region] relative to [now] – exposed for tests.
  static List<ProductModel> seedFor(Region region, DateTime now) =>
      switch (region) {
        Region.nepal => MockProductSeed.build(now),
        Region.india => MockProductSeedIndia.build(now),
      };

  /// The signed-in seller for [region] (owner of "My Products").
  static SellerModel currentSellerFor(Region region) => switch (region) {
    Region.nepal => MockProductSeed.currentSeller,
    Region.india => MockProductSeedIndia.currentSeller,
  };

  int _nextId = 1;

  @override
  Future<List<ProductModel>> fetchProducts(ProductFilter filter) async {
    await Future<void>.delayed(_latency);
    Iterable<ProductModel> result = _products;
    if (filter.boostedOnly) result = result.where((p) => p.isBoosted);
    if (filter.mineOnly) result = result.where((p) => p.isMine);
    if (filter.favouritesOnly) {
      result = result.where((p) => p.isFavourite);
    }
    final businessId = filter.businessId;
    if (businessId != null) {
      result = result.where((p) => p.businessId == businessId);
    }
    final category = filter.categoryId;
    if (category != null && category.isNotEmpty && category != 'all') {
      result = result.where((p) => p.categoryId == category);
    }
    final query = filter.query?.trim().toLowerCase();
    if (query != null && query.isNotEmpty) {
      result = result.where(
        (p) =>
            p.title.toLowerCase().contains(query) ||
            p.titleNe.contains(query) ||
            p.description.toLowerCase().contains(query) ||
            p.location.toLowerCase().contains(query) ||
            _categoryName(p.categoryId).toLowerCase().contains(query),
      );
    }
    final list = result.toList();
    switch (filter.sort) {
      case ProductSort.latest:
        list.sort((a, b) => b.postedAt.compareTo(a.postedAt));
      case ProductSort.priceLowToHigh:
        list.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHighToLow:
        list.sort((a, b) => b.price.compareTo(a.price));
    }
    final limit = filter.limit;
    return limit == null ? list : list.take(limit).toList();
  }

  @override
  Future<ProductModel> fetchById(String id) async {
    await Future<void>.delayed(_latency);
    return _products.firstWhere(
      (p) => p.id == id,
      orElse: () => throw NotFoundException('Product $id not found'),
    );
  }

  @override
  Future<ProductModel> toggleFavourite(String id) async {
    final products = _products;
    final index = products.indexWhere((p) => p.id == id);
    if (index < 0) throw NotFoundException('Product $id not found');
    final current = products[index];
    final next = current.copyWith(
      isFavourite: !current.isFavourite,
      likes: current.isFavourite ? current.likes - 1 : current.likes + 1,
    );
    products[index] = next;
    return next;
  }

  @override
  Future<List<Category>> fetchCategories() async => MarketplaceCategories.all;

  @override
  Future<List<ProductModel>> myProducts() async {
    await Future<void>.delayed(_latency);
    return [
      for (final p in _products)
        if (p.isMine) p,
    ];
  }

  @override
  Future<ProductModel> create(ProductDraft draft) async {
    await Future<void>.delayed(_latency);
    final region = _resolver.region;
    final now = _clock();
    final id = 'my-${region.code}-${_nextId++}';
    final model = _apply(
      ProductModel(
        id: id,
        title: draft.title,
        titleNe: draft.effectiveTitleLocal,
        description: draft.description,
        descriptionNe: draft.effectiveDescriptionLocal,
        price: draft.price,
        categoryId: draft.categoryId,
        images: const [],
        seller: currentSellerFor(region),
        location: draft.location,
        locationNe: draft.effectiveLocationLocal,
        postedAt: now,
        currency: _resolver.config.currencyCode,
        isMine: true,
        // A seller's listing belongs to their shop, so the business profile
        // and the marketplace show one catalogue rather than two.
        businessId: MockBusinessDataSource.myBusinessId,
      ),
      draft,
      now,
    );
    _products.insert(0, model);
    return model;
  }

  @override
  Future<ProductModel> update(String id, ProductDraft draft) async {
    await Future<void>.delayed(_latency);
    final products = _products;
    final index = products.indexWhere((p) => p.id == id);
    if (index < 0) throw NotFoundException('Product $id not found');
    if (!products[index].isMine) {
      throw PermissionException('Only the seller can edit product $id');
    }
    final next = _apply(products[index], draft, _clock());
    products[index] = next;
    return next;
  }

  @override
  Future<void> delete(String id) async {
    await Future<void>.delayed(_latency);
    final products = _products;
    final index = products.indexWhere((p) => p.id == id);
    if (index < 0) throw NotFoundException('Product $id not found');
    if (!products[index].isMine) {
      throw PermissionException('Only the seller can delete product $id');
    }
    products.removeAt(index);
  }

  /// Copies the editable [draft] fields onto [base].
  static ProductModel _apply(
    ProductModel base,
    ProductDraft draft,
    DateTime now,
  ) => base.copyWith(
    title: draft.title,
    titleNe: draft.effectiveTitleLocal,
    description: draft.description,
    descriptionNe: draft.effectiveDescriptionLocal,
    price: draft.price,
    categoryId: draft.categoryId,
    condition: draft.condition,
    isService: draft.isService,
    negotiable: draft.negotiable,
    images: draft.images.isEmpty
        ? ['$categoryImageScheme${draft.categoryId}']
        : draft.images,
    location: draft.location,
    locationNe: draft.effectiveLocationLocal,
    seller: base.seller.copyWith(
      phone: draft.phone.isEmpty ? base.seller.phone : draft.phone,
    ),
    websiteLink: (draft.websiteLink?.isEmpty ?? true)
        ? null
        : draft.websiteLink,
    expiresAt: now.add(Duration(days: draft.expiryDays)),
    isMine: true,
  );

  static String _categoryName(String id) => MarketplaceCategories.all
      .firstWhere(
        (c) => c.id == id,
        orElse: () => MarketplaceCategories.all.first,
      )
      .nameEn;
}
