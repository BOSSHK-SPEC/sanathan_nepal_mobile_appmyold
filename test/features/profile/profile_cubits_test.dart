import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_refresher.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_my_business.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/repositories/business_repository.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/order_summary.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/delete_account.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_appointments.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_businesses.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_favourite_products.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_orders.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/logout.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/set_business_status.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/update_order.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/update_user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/upsert_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/activity_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/admin_businesses_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/business_form_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/business_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/profile_cubit.dart';

class MockGetUserProfile extends Mock implements GetUserProfile {}

class MockUpdateUserProfile extends Mock implements UpdateUserProfile {}

class MockGetFavourites extends Mock implements GetFavouriteProducts {}

class MockLogout extends Mock implements Logout {}

class MockDeleteAccount extends Mock implements DeleteAccount {}

class MockGetBusiness extends Mock implements GetBusinessProfile {}

class MockSetStatus extends Mock implements SetBusinessStatus {}

class MockGetMyBusiness extends Mock implements GetMyBusiness {}

class MockUpsertBusiness extends Mock implements UpsertBusinessProfile {}

class MockGetBusinesses extends Mock implements GetBusinesses {}

class MockBusinessRepository extends Mock implements BusinessRepository {}

class MockGetAppointments extends Mock implements GetAppointments {}

class MockGetOrders extends Mock implements GetOrders {}

class MockUpdateOrderStatus extends Mock implements UpdateOrderStatus {}

class MockRateOrder extends Mock implements RateOrder {}

const profile = UserProfile(id: 'u1', name: 'Kritika', email: 'k@x.com');
const business = BusinessProfile(id: 'b1', name: 'Biz', category: 'Cat');
final order = OrderSummary(
  id: 'o1',
  productName: 'Phone',
  price: 100,
  counterpartyName: 'Ram',
  counterpartyId: 'u2',
  role: OrderRole.seller,
  status: OrderStatus.placed,
  updatedAt: DateTime(2024),
);

void main() {
  setUpAll(() {
    registerFallbackValue(profile);
    registerFallbackValue(business);
    registerFallbackValue(
      const SetBusinessStatusParams(id: '', status: BusinessStatus.pending),
    );
    registerFallbackValue(
      const UpdateOrderStatusParams(id: '', status: OrderStatus.placed),
    );
    registerFallbackValue(const RateOrderParams(id: '', rating: 1));
  });

  group('ProfileCubit', () {
    late MockGetUserProfile getProfile;
    late MockGetFavourites getFavourites;
    late MockLogout logout;
    late MockDeleteAccount deleteAccount;

    setUp(() {
      getProfile = MockGetUserProfile();
      getFavourites = MockGetFavourites();
      logout = MockLogout();
      deleteAccount = MockDeleteAccount();
      when(
        getFavourites.call,
      ).thenAnswer((_) async => const Result.success([]));
    });

    ProfileCubit build() => ProfileCubit(
      getProfile: getProfile,
      getFavourites: getFavourites,
      logout: logout,
      deleteAccount: deleteAccount,
    );

    blocTest<ProfileCubit, ProfileState>(
      'load emits loading → loaded with profile',
      build: build,
      setUp: () => when(
        getProfile.call,
      ).thenAnswer((_) async => const Result.success(profile)),
      act: (c) => c.load(),
      expect: () => const [
        ProfileState(
          profile: LoadState.loading(),
          favourites: LoadState.loading(),
        ),
        ProfileState(
          profile: LoadState.loaded(profile),
          favourites: LoadState.loaded([]),
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'load emits failure when the repository fails',
      build: build,
      setUp: () => when(
        getProfile.call,
      ).thenAnswer((_) async => const Result.failure(CacheFailure('nope'))),
      act: (c) => c.load(),
      expect: () => const [
        ProfileState(
          profile: LoadState.loading(),
          favourites: LoadState.loading(),
        ),
        ProfileState(
          profile: LoadState.failed(CacheFailure('nope')),
          favourites: LoadState.loaded([]),
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'logout emits loggedOut',
      build: build,
      setUp: () =>
          when(logout.call).thenAnswer((_) async => const Result.success(null)),
      act: (c) => c.logout(),
      expect: () => const [
        ProfileState(signOut: LoadState.loading()),
        ProfileState(signOut: LoadState.loaded(null)),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'deleteAccount failure keeps the session and exposes the failure',
      build: build,
      setUp: () => when(
        deleteAccount.call,
      ).thenAnswer((_) async => const Result.failure(CacheFailure('locked'))),
      act: (c) => c.deleteAccount(),
      expect: () => const [
        ProfileState(signOut: LoadState.loading()),
        ProfileState(signOut: LoadState.failed(CacheFailure('locked'))),
      ],
    );
  });

  group('EditProfileCubit', () {
    late MockGetUserProfile getProfile;
    late MockUpdateUserProfile update;
    setUp(() {
      getProfile = MockGetUserProfile();
      update = MockUpdateUserProfile();
    });

    blocTest<EditProfileCubit, EditProfileState>(
      'load then save emits ready → saving → saved',
      build: () =>
          EditProfileCubit(getProfile: getProfile, updateProfile: update),
      setUp: () {
        when(
          getProfile.call,
        ).thenAnswer((_) async => const Result.success(profile));
        when(() => update(any())).thenAnswer(
          (i) async =>
              Result.success(i.positionalArguments.first as UserProfile),
        );
      },
      act: (c) async {
        await c.load();
        await c.save(profile.copyWith(name: 'New'));
      },
      expect: () => [
        const EditProfileState(profile: LoadState.loading()),
        const EditProfileState(profile: LoadState.loaded(profile)),
        EditProfileState(
          profile: LoadState.loaded(profile.copyWith(name: 'New')),
          save: const LoadState.loading(),
        ),
        EditProfileState(
          profile: LoadState.loaded(profile.copyWith(name: 'New')),
          save: LoadState.loaded(profile.copyWith(name: 'New')),
        ),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'save emits failure with validation message',
      build: () =>
          EditProfileCubit(getProfile: getProfile, updateProfile: update),
      setUp: () => when(() => update(any())).thenAnswer(
        (_) async =>
            const Result.failure(ValidationFailure('Name is required')),
      ),
      act: (c) => c.save(profile),
      expect: () => const [
        EditProfileState(
          profile: LoadState.loaded(profile),
          save: LoadState.loading(),
        ),
        EditProfileState(
          profile: LoadState.loaded(profile),
          save: LoadState.failed(ValidationFailure('Name is required')),
        ),
      ],
    );
  });

  group('BusinessProfileCubit', () {
    late MockGetBusiness getBusiness;
    late MockSetStatus setStatus;
    late MockGetMyBusiness getMyBusiness;
    late MockUpsertBusiness upsert;
    late _RecordingRoleGranter roles;
    late _RecordingSessionRefresher refresher;
    setUp(() {
      getBusiness = MockGetBusiness();
      setStatus = MockSetStatus();
      upsert = MockUpsertBusiness();
      getMyBusiness = MockGetMyBusiness();
      roles = _RecordingRoleGranter();
      refresher = _RecordingSessionRefresher();
    });
    BusinessProfileCubit build() => BusinessProfileCubit(
      getBusiness: getBusiness,
      getMyBusiness: getMyBusiness,
      setStatus: setStatus,
      upsertBusiness: upsert,
      repository: MockBusinessRepository(),
      roles: roles,
      sessionRefresher: refresher,
    );

    test('claiming seller access grants merchant and refreshes the session', () async {
      // The bug this covers: an approved business left the owner without
      // `manageProducts`, because permissions come from the cached profile and
      // nothing re-derived them after approval. The Products tab then told an
      // approved seller they were "still under review", forever.
      when(
        () => getBusiness('b1'),
      ).thenAnswer(
        (_) async => Result.success(
          business.copyWith(status: BusinessStatus.approved),
        ),
      );

      final cubit = build();
      await cubit.load('b1');

      expect(await cubit.claimSellerAccess(), isTrue);
      expect(roles.granted, [AppRole.merchant]);
      // Granting alone changes nothing on screen — the session is what the UI
      // reads, so it has to be re-derived too.
      expect(refresher.refreshes, 1);
      await cubit.close();
    });

    test('a business still under review claims nothing', () async {
      when(
        () => getBusiness('b1'),
      ).thenAnswer((_) async => const Result.success(business));

      final cubit = build();
      await cubit.load('b1');

      expect(await cubit.claimSellerAccess(), isFalse);
      expect(roles.granted, isEmpty);
      expect(refresher.refreshes, 0);
      await cubit.close();
    });

    test('claims nothing before a business has loaded', () async {
      final cubit = build();

      expect(await cubit.claimSellerAccess(), isFalse);
      expect(roles.granted, isEmpty);
      await cubit.close();
    });

    blocTest<BusinessProfileCubit, BusinessProfileState>(
      'load then approve updates status',
      build: build,
      setUp: () {
        when(
          () => getBusiness('b1'),
        ).thenAnswer((_) async => const Result.success(business));
        when(() => setStatus(any())).thenAnswer(
          (_) async => Result.success(
            business.copyWith(status: BusinessStatus.approved),
          ),
        );
      },
      act: (c) async {
        await c.load('b1');
        await c.approve();
      },
      expect: () => [
        const BusinessProfileState(business: LoadState.loading()),
        const BusinessProfileState(business: LoadState.loaded(business)),
        BusinessProfileState(
          business: LoadState.loaded(
            business.copyWith(status: BusinessStatus.approved),
          ),
        ),
      ],
    );

    blocTest<BusinessProfileCubit, BusinessProfileState>(
      'failed reject keeps the listing as previous data',
      build: build,
      setUp: () {
        when(
          () => getBusiness('b1'),
        ).thenAnswer((_) async => const Result.success(business));
        when(
          () => setStatus(any()),
        ).thenAnswer((_) async => const Result.failure(ServerFailure('down')));
      },
      act: (c) async {
        await c.load('b1');
        await c.reject();
      },
      skip: 2,
      expect: () => const [
        BusinessProfileState(
          business: LoadState.failed(ServerFailure('down'), previous: business),
        ),
      ],
      verify: (c) => expect(c.state.business.dataOrNull, business),
    );
    blocTest<BusinessProfileCubit, BusinessProfileState>(
      'reject passes the reason as note and addItem persists via upsert',
      build: build,
      setUp: () {
        when(
          () => getBusiness('b1'),
        ).thenAnswer((_) async => const Result.success(business));
        when(() => setStatus(any())).thenAnswer(
          (i) async => Result.success(
            business.copyWith(
              status: BusinessStatus.rejected,
              moderationNote:
                  (i.positionalArguments.first as SetBusinessStatusParams).note,
            ),
          ),
        );
        when(() => upsert(any())).thenAnswer(
          (i) async =>
              Result.success(i.positionalArguments.first as BusinessProfile),
        );
      },
      act: (c) async {
        await c.load('b1');
        await c.reject(reason: 'Missing PAN');
        await c.addItem(
          const BusinessItem(
            id: 'i1',
            title: 'T',
            description: 'D',
            priceLabel: 'Rs. 1',
            category: 'C',
          ),
        );
        await c.removeItem('i1');
      },
      verify: (c) {
        final captured = verify(() => setStatus(captureAny())).captured;
        expect(
          captured.single,
          const SetBusinessStatusParams(
            id: 'b1',
            status: BusinessStatus.rejected,
            note: 'Missing PAN',
          ),
        );
        verify(() => upsert(any())).called(2);
        expect(c.state.business.dataOrNull?.items, isEmpty);
        expect(c.state.business.dataOrNull?.moderationNote, 'Missing PAN');
      },
    );
  });

  group('AdminBusinessesCubit', () {
    late MockGetBusinesses getBusinesses;
    late MockSetStatus setStatus;
    setUp(() {
      getBusinesses = MockGetBusinesses();
      setStatus = MockSetStatus();
    });
    final approved = business.copyWith(
      id: 'b2',
      status: BusinessStatus.approved,
    );

    blocTest<AdminBusinessesCubit, AdminBusinessesState>(
      'load, filter and moderate refresh the list',
      build: () => AdminBusinessesCubit(
        getBusinesses: getBusinesses,
        setStatus: setStatus,
      ),
      setUp: () {
        var calls = 0;
        when(() => getBusinesses(null)).thenAnswer((_) async {
          calls++;
          return Result.success(
            calls == 1
                ? [business, approved]
                : [
                    business.copyWith(status: BusinessStatus.approved),
                    approved,
                  ],
          );
        });
        when(
          () => setStatus(any()),
        ).thenAnswer((_) async => Result.success(approved));
      },
      act: (c) async {
        await c.load();
        c.setFilter(BusinessStatus.approved);
        c.setFilter(null);
        await c.moderate('b1', BusinessStatus.approved);
      },
      verify: (c) {
        expect(c.state.filter, isNull);
        expect(c.state.visible, hasLength(2));
        expect(c.state.countFor(BusinessStatus.approved), 2);
        expect(c.state.countFor(BusinessStatus.pending), 0);
        verify(() => getBusinesses(null)).called(2);
      },
    );

    blocTest<AdminBusinessesCubit, AdminBusinessesState>(
      'default filter is pending and failed load surfaces the failure',
      build: () => AdminBusinessesCubit(
        getBusinesses: getBusinesses,
        setStatus: setStatus,
      ),
      setUp: () => when(
        () => getBusinesses(null),
      ).thenAnswer((_) async => const Result.failure(ServerFailure('down'))),
      act: (c) => c.load(),
      expect: () => const [
        AdminBusinessesState(businesses: LoadState.loading()),
        AdminBusinessesState(
          businesses: LoadState.failed(ServerFailure('down')),
        ),
      ],
      verify: (c) {
        expect(c.state.filter, BusinessStatus.pending);
        expect(c.state.visible, isEmpty);
      },
    );
  });

  group('BusinessFormCubit', () {
    late MockGetBusiness getBusiness;
    late MockUpsertBusiness upsert;
    late MockGetMyBusiness getMyBusiness;
    setUp(() {
      getBusiness = MockGetBusiness();
      upsert = MockUpsertBusiness();
      getMyBusiness = MockGetMyBusiness();
    });

    blocTest<BusinessFormCubit, BusinessFormState>(
      'load starts blank when nothing exists, addItem + submit succeed',
      build: () => BusinessFormCubit(
        getBusiness: getBusiness,
        getMyBusiness: getMyBusiness,
        upsertBusiness: upsert,
        businessId: 'my',
      ),
      setUp: () {
        when(
          () => getBusiness('my'),
        ).thenAnswer((_) async => const Result.failure(NotFoundFailure()));
        when(() => upsert(any())).thenAnswer(
          (i) async =>
              Result.success(i.positionalArguments.first as BusinessProfile),
        );
      },
      act: (c) async {
        await c.load();
        c.updateDraft(c.state.draft.copyWith(name: 'Biz', category: 'Cat'));
        c.addItem(
          const BusinessItem(
            id: 'i1',
            title: 'T',
            description: 'D',
            priceLabel: 'Rs. 1',
            category: 'C',
          ),
        );
        await c.submit();
      },
      verify: (c) {
        expect(c.state.existing, isA<Failed<BusinessProfile>>());
        expect(c.state.isReady, isTrue);
        expect(c.state.submission, isA<Loaded<BusinessProfile>>());
        expect(c.state.submission.dataOrNull, c.state.draft);
        expect(c.state.draft.items, hasLength(1));
        expect(c.state.draft.name, 'Biz');
        verify(() => upsert(any())).called(1);
      },
    );
  });

  group('ActivityCubit', () {
    late MockGetAppointments getAppointments;
    late MockGetOrders getOrders;
    late MockUpdateOrderStatus updateStatus;
    late MockRateOrder rateOrder;
    setUp(() {
      getAppointments = MockGetAppointments();
      getOrders = MockGetOrders();
      updateStatus = MockUpdateOrderStatus();
      rateOrder = MockRateOrder();
    });

    blocTest<ActivityCubit, ActivityState>(
      'load then acceptOrder replaces the order',
      build: () => ActivityCubit(
        getAppointments: getAppointments,
        getOrders: getOrders,
        updateOrderStatus: updateStatus,
        rateOrder: rateOrder,
      ),
      setUp: () {
        when(
          getAppointments.call,
        ).thenAnswer((_) async => const Result.success([]));
        when(getOrders.call).thenAnswer((_) async => Result.success([order]));
        when(() => updateStatus(any())).thenAnswer(
          (_) async =>
              Result.success(order.copyWith(status: OrderStatus.processing)),
        );
      },
      act: (c) async {
        await c.load();
        await c.acceptOrder('o1');
      },
      expect: () => [
        const ActivityState(
          appointments: LoadState.loading(),
          orders: LoadState.loading(),
        ),
        ActivityState(
          appointments: const LoadState.loaded([]),
          orders: LoadState.loaded([order]),
        ),
        ActivityState(
          appointments: const LoadState.loaded([]),
          orders: LoadState.loaded([
            order.copyWith(status: OrderStatus.processing),
          ]),
        ),
      ],
      verify: (c) => expect(c.state.sales, hasLength(1)),
    );

    blocTest<ActivityCubit, ActivityState>(
      'failed order action keeps the orders as previous data',
      build: () => ActivityCubit(
        getAppointments: getAppointments,
        getOrders: getOrders,
        updateOrderStatus: updateStatus,
        rateOrder: rateOrder,
      ),
      setUp: () {
        when(
          getAppointments.call,
        ).thenAnswer((_) async => const Result.success([]));
        when(getOrders.call).thenAnswer((_) async => Result.success([order]));
        when(() => rateOrder(any())).thenAnswer(
          (_) async => const Result.failure(NotFoundFailure('gone')),
        );
      },
      act: (c) async {
        await c.load();
        await c.rate('o1', 4);
      },
      skip: 2,
      expect: () => [
        ActivityState(
          appointments: const LoadState.loaded([]),
          orders: LoadState.failed(
            const NotFoundFailure('gone'),
            previous: [order],
          ),
        ),
      ],
      verify: (c) => expect(c.state.sales, hasLength(1)),
    );
  });
}


/// Records what was granted, so the seller claim can be asserted without a
/// real profile store behind it.
class _RecordingRoleGranter implements RoleGranter {
  final List<AppRole> granted = [];

  @override
  Future<void> grant(AppRole role) async => granted.add(role);

  @override
  Future<void> revoke(AppRole role) async {}
}

class _RecordingSessionRefresher implements SessionRefresher {
  int refreshes = 0;

  @override
  Future<void> refresh() async => refreshes++;
}
