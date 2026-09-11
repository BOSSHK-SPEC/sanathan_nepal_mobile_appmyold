import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/create_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/delete_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_my_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_product_by_id.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/update_product.dart';

import '../helpers/test_helpers.dart';

/// Seller create / update / delete through the real repository + in-memory
/// mock data source (session persistence, ownership, region seller).
void main() {
  const draft = ProductDraft(
    title: 'Rudraksha Mala',
    titleLocal: 'रुद्राक्ष माला',
    categoryId: 'poojaSamagri',
    description: '108 beads, 5 mukhi.',
    price: 2500,
    condition: ProductCondition.brandNew,
    negotiable: true,
    phone: '+977-9800000000',
    websiteLink: 'www.example.com',
    expiryDays: 15,
  );

  ProductRepositoryImpl repoFor(Region region) => ProductRepositoryImpl(
    MockProductDataSource(
      clock: () => kTestNow,
      resolver: FixedRegionResolver(region),
    ),
  );

  test(
    'CreateProduct persists for the session, marks isMine and seller',
    () async {
      final repo = repoFor(Region.nepal);
      final created = (await CreateProduct(repo)(draft)).valueOrNull!;
      expect(created.isMine, isTrue);
      expect(
        created.seller.id,
        MockProductDataSource.currentSellerFor(Region.nepal).id,
      );
      expect(created.seller.phone, '+977-9800000000');
      expect(created.titleNe, 'रुद्राक्ष माला');
      expect(created.descriptionNe, draft.description); // falls back to English
      expect(created.expiresAt, kTestNow.add(const Duration(days: 15)));
      expect(created.images, ['category:poojaSamagri']);
      expect(created.currency, 'NPR');

      final mine = (await GetMyProducts(repo)()).valueOrNull!;
      expect(mine.map((p) => p.id), contains(created.id));
      final byId = (await GetProductById(repo)(created.id)).valueOrNull;
      expect(byId?.title, 'Rudraksha Mala');
    },
  );

  test('India region creates in INR for the Indian seller', () async {
    final repo = repoFor(Region.india);
    final created = (await CreateProduct(repo)(draft)).valueOrNull!;
    expect(created.currency, 'INR');
    expect(
      created.seller.id,
      MockProductDataSource.currentSellerFor(Region.india).id,
    );
  });

  test('UpdateProduct rewrites editable fields of an own listing', () async {
    final repo = repoFor(Region.nepal);
    final result = await UpdateProduct(repo)(
      UpdateProductParams(
        id: 'p4',
        draft: draft.copyWith(title: 'Pearl updated', price: 16000),
      ),
    );
    final updated = result.valueOrNull!;
    expect(updated.id, 'p4');
    expect(updated.title, 'Pearl updated');
    expect(updated.price, 16000);
    expect(updated.isMine, isTrue);
    expect(
      (await GetProductById(repo)('p4')).valueOrNull?.title,
      'Pearl updated',
    );
  });

  test(
    'update / delete of somebody else\'s listing is a PermissionFailure',
    () async {
      final repo = repoFor(Region.nepal);
      final u = await UpdateProduct(repo)(
        const UpdateProductParams(id: 'p1', draft: draft),
      );
      expect(u.failureOrNull, isA<PermissionFailure>());
      final d = await DeleteProduct(repo)('p1');
      expect(d.failureOrNull, isA<PermissionFailure>());
      final missing = await DeleteProduct(repo)('nope');
      expect(missing.failureOrNull, isA<NotFoundFailure>());
    },
  );

  test('DeleteProduct removes the listing', () async {
    final repo = repoFor(Region.nepal);
    expect((await DeleteProduct(repo)('p4')).isSuccess, isTrue);
    expect(
      (await GetProductById(repo)('p4')).failureOrNull,
      isA<NotFoundFailure>(),
    );
    final mine = (await GetMyProducts(repo)()).valueOrNull!;
    expect(mine.any((p) => p.id == 'p4'), isFalse);
  });

  test('ProductDraft.fromProduct pre-fills the edit form', () async {
    final repo = repoFor(Region.nepal);
    final p4 = (await GetProductById(repo)('p4')).valueOrNull!;
    final d = ProductDraft.fromProduct(p4, now: kTestNow);
    expect(d.title, p4.title);
    expect(d.categoryId, 'gemstones');
    expect(d.phone, p4.seller.phone);
    expect(d.expiryDays, 60);
    expect(d.images, p4.images);
  });
}
