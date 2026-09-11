import '../../../../core/region/region_all.dart';
import '../../domain/entities/boost_request.dart';

/// Boost API contract.
abstract interface class BoostDataSource {
  Future<List<BoostPlan>> fetchPlans();
  Future<BoostReceipt> submit(BoostRequest request);
}

/// Mock boost service – fixed plans priced in the active region's local
/// currency (read from [RegionResolver] at call time), deterministic
/// receipts.
class MockBoostDataSource implements BoostDataSource {
  MockBoostDataSource({
    DateTime Function()? clock,
    RegionResolver resolver = const FixedRegionResolver(Region.nepal),
  }) : _clock = clock ?? DateTime.now,
       _resolver = resolver;

  final DateTime Function() _clock;
  final RegionResolver _resolver;
  int _sequence = 1001;

  /// Nepal plans (NPR).
  static const List<BoostPlan> plans = [
    BoostPlan(hours: 12, pricePerProduct: 1000),
    BoostPlan(hours: 24, pricePerProduct: 1800),
    BoostPlan(hours: 48, pricePerProduct: 3200),
    BoostPlan(hours: 72, pricePerProduct: 4500),
  ];

  /// India plans (INR).
  static const List<BoostPlan> plansIndia = [
    BoostPlan(hours: 12, pricePerProduct: 499),
    BoostPlan(hours: 24, pricePerProduct: 999),
    BoostPlan(hours: 48, pricePerProduct: 1799),
    BoostPlan(hours: 72, pricePerProduct: 2499),
  ];

  /// Plans for [region], priced in its local currency.
  static List<BoostPlan> plansFor(Region region) => switch (region) {
    Region.nepal => plans,
    Region.india => plansIndia,
  };

  @override
  Future<List<BoostPlan>> fetchPlans() async => plansFor(_resolver.region);

  @override
  Future<BoostReceipt> submit(BoostRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return BoostReceipt(
      referenceId: 'BST${_sequence++}',
      total: request.total,
      submittedAt: _clock(),
    );
  }
}
