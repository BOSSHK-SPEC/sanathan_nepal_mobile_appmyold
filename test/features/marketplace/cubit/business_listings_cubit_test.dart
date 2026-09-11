import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/seller.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/delete_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/business_listings_cubit.dart';

class MockGetProducts extends Mock implements GetProducts {}

class MockDeleteProduct extends Mock implements DeleteProduct {}

const seller = Seller(id: 's1', name: 'Uttam');

Product listing(String id, {bool isService = false}) => Product(
  id: id,
  title: id,
  titleNe: id,
  description: '',
  descriptionNe: '',
  price: 450,
  categoryId: 'c1',
  images: const [],
  seller: seller,
  location: 'Kathmandu',
  locationNe: 'काठमाडौं',
  postedAt: DateTime(2026, 9),
  isService: isService,
  businessId: 'biz-1',
);

void main() {
  late MockGetProducts getProducts;
  late MockDeleteProduct deleteProduct;

  setUpAll(() => registerFallbackValue(const ProductFilter()));

  setUp(() {
    getProducts = MockGetProducts();
    deleteProduct = MockDeleteProduct();
  });

  BusinessListingsCubit build({String businessId = 'biz-1'}) =>
      BusinessListingsCubit(
        getProducts: getProducts,
        deleteProduct: deleteProduct,
        businessId: businessId,
      );

  blocTest<BusinessListingsCubit, BusinessListingsState>(
    'asks for exactly this shop\'s listings',
    build: () {
      when(
        () => getProducts(any()),
      ).thenAnswer((_) async => Result.success([listing('p1')]));
      return build();
    },
    act: (cubit) => cubit.load(),
    verify: (_) {
      final filter =
          verify(() => getProducts(captureAny())).captured.single
              as ProductFilter;
      expect(filter.businessId, 'biz-1');
    },
  );

  blocTest<BusinessListingsCubit, BusinessListingsState>(
    'splits the catalogue into the Products and Services tabs',
    build: () {
      when(() => getProducts(any())).thenAnswer(
        (_) async => Result.success([
          listing('p1'),
          listing('s1', isService: true),
          listing('p2'),
        ]),
      );
      return build();
    },
    act: (cubit) => cubit.load(),
    verify: (cubit) {
      expect(cubit.state.products.map((p) => p.id), ['p1', 'p2']);
      expect(cubit.state.services.map((p) => p.id), ['s1']);
    },
  );

  blocTest<BusinessListingsCubit, BusinessListingsState>(
    'a shop with no id asks for nothing at all',
    build: () => build(businessId: ''),
    act: (cubit) => cubit.load(),
    // A blank id would otherwise fetch the whole marketplace and show it as
    // one shop's catalogue.
    verify: (cubit) {
      verifyNever(() => getProducts(any()));
      expect(cubit.state.all, isEmpty);
    },
  );

  blocTest<BusinessListingsCubit, BusinessListingsState>(
    'a failed load is reported, not shown as an empty shop',
    build: () {
      when(() => getProducts(any())).thenAnswer(
        (_) async => const Result.failure(Failure.network('No connection')),
      );
      return build();
    },
    act: (cubit) => cubit.load(),
    verify: (cubit) =>
        expect(cubit.state.listings.errorMessage, 'No connection'),
  );

  blocTest<BusinessListingsCubit, BusinessListingsState>(
    'removing a listing drops it from the grid',
    build: () {
      when(
        () => getProducts(any()),
      ).thenAnswer((_) async => Result.success([listing('p1'), listing('p2')]));
      when(
        () => deleteProduct(any()),
      ).thenAnswer((_) async => const Result.success(null));
      return build();
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.remove('p1');
    },
    verify: (cubit) => expect(cubit.state.all.map((p) => p.id), ['p2']),
  );

  blocTest<BusinessListingsCubit, BusinessListingsState>(
    'a failed delete leaves the grid alone',
    build: () {
      when(
        () => getProducts(any()),
      ).thenAnswer((_) async => Result.success([listing('p1'), listing('p2')]));
      when(() => deleteProduct(any())).thenAnswer(
        (_) async => const Result.failure(Failure.permission('Not yours')),
      );
      return build();
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.remove('p1');
    },
    verify: (cubit) {
      expect(cubit.state.all.map((p) => p.id), ['p1', 'p2']);
      expect(cubit.state.deletion.errorMessage, 'Not yours');
    },
  );
}
