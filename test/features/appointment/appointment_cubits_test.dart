import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/appointment_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/astrologer_seed.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/booking_request.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/time_slot.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/repositories/booking_contact_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/book_appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/cancel_appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/get_appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/get_appointments.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/get_bookable_astrologer.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/get_bookable_astrologers.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/get_time_slots.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/reschedule_appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/cubit/appointment_details_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/cubit/appointment_list_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/cubit/book_appointment_cubit.dart';

class _MockGetProviders extends Mock implements GetBookableAstrologers {}

class _MockGetProvider extends Mock implements GetBookableAstrologer {}

class _MockGetAppointments extends Mock implements GetAppointments {}

class _MockGetAppointment extends Mock implements GetAppointment {}

class _MockGetTimeSlots extends Mock implements GetTimeSlots {}

class _MockBook extends Mock implements BookAppointment {}

class _MockCancel extends Mock implements CancelAppointment {}

class _MockReschedule extends Mock implements RescheduleAppointment {}

class _StubContacts implements BookingContactSource {
  const _StubContacts(this.contact);
  final BookingContact? contact;

  @override
  Future<BookingContact?> current() async => contact;
}

void main() {
  // Anchored to the current clock: `Appointment.isUpcoming` compares against
  // DateTime.now(), so a hard-coded date silently flips to "past" once it
  // elapses and the upcoming/past split assertion starts failing.
  final now = DateTime.now();
  final slots = [
    MockAppointmentDataSource.slotAt(9, 0),
    MockAppointmentDataSource.slotAt(10, 0, available: false),
  ];
  final upcoming = Appointment(
    id: 'a1',
    astrologerId: featuredAstrologerId,
    astrologerName: featuredAstrologer.name,
    service: chatSitting,
    quantity: 1,
    date: now.add(const Duration(days: 2)),
    slot: slots.first,
    status: AppointmentStatus.booked,
    customerName: 'Sita',
    phone: '9841000000',
    email: '',
    country: 'Nepal',
    paymentMethod: PaymentMethod.esewa,
    createdAt: now,
  );
  final past = upcoming.copyWith(
    date: now.subtract(const Duration(days: 30)),
    status: AppointmentStatus.completed,
  );

  setUpAll(() {
    registerFallbackValue(
      SlotQuery(astrologerId: featuredAstrologerId, date: DateTime(0)),
    );
    registerFallbackValue(
      RescheduleRequest(appointmentId: '', date: DateTime(0), slotId: ''),
    );
    registerFallbackValue(
      BookingRequest(
        astrologerId: '',
        serviceId: '',
        quantity: 1,
        date: DateTime(0),
        slotId: '',
        customerName: '',
        phone: '',
        email: '',
        country: '',
        paymentMethod: PaymentMethod.esewa,
      ),
    );
  });

  group('AppointmentListCubit', () {
    late _MockGetProviders getAstrologers;
    late _MockGetAppointments getAppointments;
    setUp(() {
      getAstrologers = _MockGetProviders();
      getAppointments = _MockGetAppointments();
    });

    blocTest<AppointmentListCubit, AppointmentListState>(
      'loads astrologer + splits upcoming / past',
      build: () {
        when(
          getAstrologers.call,
        ).thenAnswer((_) async => Result.success([featuredAstrologer]));
        when(
          getAppointments.call,
        ).thenAnswer((_) async => Result.success([past, upcoming]));
        return AppointmentListCubit(
          getAstrologers: getAstrologers,
          getAppointments: getAppointments,
        );
      },
      act: (c) => c.load(),
      verify: (c) {
        expect(c.state.astrologers, LoadState.loaded([featuredAstrologer]));
        expect(c.state.astrologer, featuredAstrologer);
        expect(c.state.appointments.isLoaded, isTrue);
        expect(c.state.upcoming, [upcoming]);
        expect(c.state.past, [past]);
      },
    );

    blocTest<AppointmentListCubit, AppointmentListState>(
      'emits failure when astrologers fail',
      build: () {
        when(
          getAstrologers.call,
        ).thenAnswer((_) async => const Result.failure(NetworkFailure()));
        when(
          getAppointments.call,
        ).thenAnswer((_) async => const Result.success([]));
        return AppointmentListCubit(
          getAstrologers: getAstrologers,
          getAppointments: getAppointments,
        );
      },
      act: (c) => c.load(),
      expect: () => const [
        AppointmentListState(
          astrologers: LoadState.loading(),
          appointments: LoadState.loading(),
        ),
        AppointmentListState(
          astrologers: LoadState.failed(NetworkFailure()),
          appointments: LoadState.loaded([]),
        ),
      ],
    );

    blocTest<AppointmentListCubit, AppointmentListState>(
      'refreshAppointments keeps the previous list while loading',
      build: () {
        when(
          getAstrologers.call,
        ).thenAnswer((_) async => Result.success([featuredAstrologer]));
        when(
          getAppointments.call,
        ).thenAnswer((_) async => Result.success([upcoming]));
        return AppointmentListCubit(
          getAstrologers: getAstrologers,
          getAppointments: getAppointments,
        );
      },
      act: (c) async {
        await c.load();
        when(
          getAppointments.call,
        ).thenAnswer((_) async => Result.success([upcoming, past]));
        await c.refreshAppointments();
      },
      skip: 2,
      expect: () => [
        AppointmentListState(
          astrologers: LoadState.loaded([featuredAstrologer]),
          appointments: LoadState.loading(previous: [upcoming]),
        ),
        AppointmentListState(
          astrologers: LoadState.loaded([featuredAstrologer]),
          appointments: LoadState.loaded([upcoming, past]),
        ),
      ],
    );
  });

  group('AppointmentDetailsCubit', () {
    late _MockGetAppointment getAppointment;
    late _MockGetProvider getAstrologer;
    late _MockGetTimeSlots getTimeSlots;
    late _MockCancel cancel;
    late _MockReschedule reschedule;

    setUp(() {
      getAppointment = _MockGetAppointment();
      getAstrologer = _MockGetProvider();
      getTimeSlots = _MockGetTimeSlots();
      cancel = _MockCancel();
      reschedule = _MockReschedule();
    });

    AppointmentDetailsCubit build() => AppointmentDetailsCubit(
      getAppointment: getAppointment,
      getAstrologer: getAstrologer,
      getTimeSlots: getTimeSlots,
      cancelAppointment: cancel,
      rescheduleAppointment: reschedule,
    );

    blocTest<AppointmentDetailsCubit, AppointmentDetailsState>(
      'loads, then cancels (action slice tracks the call)',
      build: () {
        when(
          () => getAppointment('a1'),
        ).thenAnswer((_) async => Result.success(upcoming));
        when(
          () => getAstrologer(featuredAstrologerId),
        ).thenAnswer((_) async => Result.success(featuredAstrologer));
        when(() => cancel('a1')).thenAnswer(
          (_) async => Result.success(
            upcoming.copyWith(status: AppointmentStatus.cancelled),
          ),
        );
        return build();
      },
      act: (c) async {
        await c.load('a1');
        expect(await c.cancel(), isNull);
      },
      expect: () => [
        const AppointmentDetailsState(
          appointment: LoadState.loading(),
          astrologer: LoadState.loading(),
        ),
        AppointmentDetailsState(
          appointment: LoadState.loaded(upcoming),
          astrologer: LoadState.loaded(featuredAstrologer),
        ),
        AppointmentDetailsState(
          appointment: LoadState.loaded(upcoming),
          astrologer: LoadState.loaded(featuredAstrologer),
          action: const LoadState.loading(),
        ),
        AppointmentDetailsState(
          appointment: LoadState.loaded(
            upcoming.copyWith(status: AppointmentStatus.cancelled),
          ),
          astrologer: LoadState.loaded(featuredAstrologer),
          action: LoadState.loaded(
            upcoming.copyWith(status: AppointmentStatus.cancelled),
          ),
        ),
      ],
    );

    blocTest<AppointmentDetailsCubit, AppointmentDetailsState>(
      'load failure marks appointment + astrologer failed',
      build: () {
        when(
          () => getAppointment('nope'),
        ).thenAnswer((_) async => const Result.failure(NotFoundFailure()));
        return build();
      },
      act: (c) => c.load('nope'),
      expect: () => const [
        AppointmentDetailsState(
          appointment: LoadState.loading(),
          astrologer: LoadState.loading(),
        ),
        AppointmentDetailsState(
          appointment: LoadState.failed(NotFoundFailure()),
          astrologer: LoadState.failed(NotFoundFailure()),
        ),
      ],
    );

    blocTest<AppointmentDetailsCubit, AppointmentDetailsState>(
      'loads slots and reschedules',
      build: () {
        when(
          () => getAppointment('a1'),
        ).thenAnswer((_) async => Result.success(upcoming));
        when(
          () => getAstrologer(any()),
        ).thenAnswer((_) async => Result.success(featuredAstrologer));
        when(
          () => getTimeSlots(any()),
        ).thenAnswer((_) async => Result.success(slots));
        when(() => reschedule(any())).thenAnswer(
          (_) async => Result.success(upcoming.copyWith(slot: slots.first)),
        );
        return build();
      },
      act: (c) async {
        await c.load('a1');
        await c.loadSlots(now);
        expect(await c.reschedule(now, slots.first.id), isNull);
      },
      verify: (c) {
        expect(c.state.slots, LoadState.loaded(slots));
        expect(
          c.state.action,
          LoadState.loaded(upcoming.copyWith(slot: slots.first)),
        );
        expect(c.state.appointment.dataOrNull?.slot, slots.first);
        verify(() => reschedule(any())).called(1);
      },
    );

    blocTest<AppointmentDetailsCubit, AppointmentDetailsState>(
      'cancel failure is returned and keeps the appointment',
      build: () {
        when(
          () => getAppointment('a1'),
        ).thenAnswer((_) async => Result.success(upcoming));
        when(
          () => getAstrologer(any()),
        ).thenAnswer((_) async => Result.success(featuredAstrologer));
        when(() => cancel('a1')).thenAnswer(
          (_) async => const Result.failure(ServerFailure('too late')),
        );
        return build();
      },
      act: (c) async {
        await c.load('a1');
        expect(await c.cancel(), const ServerFailure('too late'));
      },
      verify: (c) {
        expect(c.state.action.errorMessage, 'too late');
        expect(c.state.appointment, LoadState.loaded(upcoming));
      },
    );
  });

  group('BookAppointmentCubit', () {
    late _MockGetTimeSlots getTimeSlots;
    late _MockBook book;
    setUp(() {
      getTimeSlots = _MockGetTimeSlots();
      book = _MockBook();
    });

    blocTest<BookAppointmentCubit, BookAppointmentState>(
      'walks through the wizard and submits',
      build: () {
        when(
          () => getTimeSlots(any()),
        ).thenAnswer((_) async => Result.success(slots));
        when(
          () => book(any()),
        ).thenAnswer((_) async => Result.success(upcoming));
        return BookAppointmentCubit(
          getTimeSlots: getTimeSlots,
          bookAppointment: book,
          astrologer: featuredAstrologer,
          initialDate: now.add(const Duration(days: 1)),
        );
      },
      act: (c) async {
        await c.loadSlots();
        c
          ..selectService('video')
          ..setDateMode(DateMode.gregorian)
          ..selectSlot('slot-9-0');
        expect(c.state.canProceedFromBasic, isTrue);
        c
          ..nextStep()
          ..updateDetails(customerName: 'Ram', phone: '9800000000')
          ..nextStep()
          ..setPaymentMethod(PaymentMethod.bank);
        await c.submit();
      },
      verify: (c) {
        expect(c.state.step, BookingStep.payment);
        // One sitting: ₹50/min video × 30 min.
        expect(c.state.total, 1500);
        expect(c.state.slots, LoadState.loaded(slots));
        expect(c.state.submission, LoadState.loaded(upcoming));
        final req =
            verify(() => book(captureAny())).captured.single as BookingRequest;
        expect(req.quantity, 1);
        expect(req.serviceId, 'video');
        expect(req.paymentMethod, PaymentMethod.bank);
      },
    );

    test('region defaults: Nepal → eSewa/Nepal, India → UPI/India', () {
      final nepal = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: featuredAstrologer,
      );
      expect(nepal.state.paymentMethod, PaymentMethod.esewa);
      expect(nepal.state.country, 'Nepal');
      expect(nepal.state.dateMode, DateMode.traditional);
      expect(nepal.paymentMethods, [
        PaymentMethod.esewa,
        PaymentMethod.khalti,
        PaymentMethod.bank,
        PaymentMethod.cash,
      ]);

      final india = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: indiaFeaturedAstrologer,
        regionResolver: const FixedRegionResolver(Region.india),
      );
      expect(india.state.paymentMethod, PaymentMethod.upi);
      expect(india.state.country, 'India');
      // Cheapest sitting first: chat is what the wizard opens on.
      expect(india.state.serviceId, 'chat');
      expect(india.paymentMethods, [
        PaymentMethod.upi,
        PaymentMethod.card,
        PaymentMethod.netBanking,
        PaymentMethod.cash,
      ]);
    });

    blocTest<BookAppointmentCubit, BookAppointmentState>(
      'submit failure surfaces message',
      build: () {
        when(
          () => getTimeSlots(any()),
        ).thenAnswer((_) async => Result.success(slots));
        when(() => book(any())).thenAnswer(
          (_) async => const Result.failure(ServerFailure('slot gone')),
        );
        return BookAppointmentCubit(
          getTimeSlots: getTimeSlots,
          bookAppointment: book,
          astrologer: featuredAstrologer,
        );
      },
      act: (c) async {
        await c.loadSlots();
        c.selectSlot('slot-9-0');
        await c.submit();
      },
      verify: (c) {
        expect(
          c.state.submission,
          const LoadState<Appointment>.failed(ServerFailure('slot gone')),
        );
        expect(c.state.submission.errorMessage, 'slot gone');
      },
    );

    blocTest<BookAppointmentCubit, BookAppointmentState>(
      'switching service reloads that service\'s slots and drops the time',
      build: () {
        when(
          () => getTimeSlots(any()),
        ).thenAnswer((_) async => Result.success(slots));
        return BookAppointmentCubit(
          getTimeSlots: getTimeSlots,
          bookAppointment: book,
          astrologer: featuredAstrologer,
        );
      },
      act: (c) async {
        await c.loadSlots();
        c.selectSlot('slot-9-0');
        await c.selectService('video');
      },
      verify: (c) {
        // The slot belonged to the previous service's grid; keeping it would
        // submit a booking the server refuses as a service mismatch.
        expect(c.state.slotId, isNull);
        expect(c.state.canProceedFromBasic, isFalse);
        final queries = verify(
          () => getTimeSlots(captureAny()),
        ).captured.cast<SlotQuery>();
        expect(queries.first.serviceId, featuredAstrologer.services.first.id);
        expect(queries.last.serviceId, 'video');
      },
    );

    test('the form starts from the signed-in profile', () async {
      final cubit = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: featuredAstrologer,
        contacts: _StubContacts(
          BookingContact(
            name: 'Yashwanth H K',
            phone: '9686912639',
            email: 'yash@example.com',
            birthPlace: 'Hassan',
            birthDate: DateTime(1995, 1, 1),
            birthTime: '12:00',
          ),
        ),
      );
      addTearDown(cubit.close);

      await cubit.prefillFromProfile();

      expect(cubit.state.customerName, 'Yashwanth H K');
      expect(cubit.state.phone, '9686912639');
      expect(cubit.state.email, 'yash@example.com');
      expect(cubit.state.birthPlace, 'Hassan');
      expect(cubit.state.birthTime, '12:00');
      expect(cubit.state.canProceedFromDetails, isTrue);
    });

    test(
      'a stored E.164 number loses the dial code the field prints',
      () async {
        final india = BookAppointmentCubit(
          getTimeSlots: getTimeSlots,
          bookAppointment: book,
          astrologer: indiaFeaturedAstrologer,
          regionResolver: const FixedRegionResolver(Region.india),
          contacts: const _StubContacts(
            BookingContact(phone: '+91 96869-12639'),
          ),
        );
        addTearDown(india.close);

        await india.prefillFromProfile();

        // The field already shows "+91"; the stored value used to arrive whole
        // and read as "+91 +919686912639".
        expect(india.state.phone, '9686912639');

        // A number from another country is left as it is rather than mangled.
        final nepal = BookAppointmentCubit(
          getTimeSlots: getTimeSlots,
          bookAppointment: book,
          astrologer: featuredAstrologer,
          contacts: const _StubContacts(BookingContact(phone: '+919686912639')),
        );
        addTearDown(nepal.close);

        await nepal.prefillFromProfile();
        expect(nepal.state.phone, '+919686912639');
      },
    );

    test('a prefill never overwrites what the user typed', () async {
      final cubit = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: featuredAstrologer,
        contacts: const _StubContacts(
          BookingContact(name: 'Yashwanth H K', phone: '9686912639'),
        ),
      );
      addTearDown(cubit.close);

      // Booking for somebody else is a normal thing to do.
      cubit.updateDetails(customerName: 'Aama', phone: '9800000000');
      await cubit.prefillFromProfile();

      expect(cubit.state.customerName, 'Aama');
      expect(cubit.state.phone, '9800000000');
    });

    test('a profile that cannot be read leaves the form empty', () async {
      final cubit = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: featuredAstrologer,
        contacts: const _StubContacts(null),
      );
      addTearDown(cubit.close);

      await cubit.prefillFromProfile();

      expect(cubit.state.customerName, isEmpty);
      expect(cubit.state.canProceedFromDetails, isFalse);
    });

    test('an email the API would reject blocks the details step', () {
      final cubit = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: featuredAstrologer,
      );
      addTearDown(cubit.close);

      cubit.updateDetails(customerName: 'Ram', phone: '9800000000');
      expect(
        cubit.state.canProceedFromDetails,
        isTrue,
        reason: 'email is optional',
      );

      cubit.updateDetails(email: 'ram@');
      expect(cubit.state.canProceedFromDetails, isFalse);

      cubit.updateDetails(email: 'ram@example.com');
      expect(cubit.state.canProceedFromDetails, isTrue);
    });

    test('a deep link naming a withdrawn service opens on a real one', () {
      final cubit = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: featuredAstrologer,
        initialServiceId: 'service-that-no-longer-exists',
      );
      addTearDown(cubit.close);

      // Reading `state.service` used to throw while the page was building.
      expect(cubit.state.serviceId, featuredAstrologer.services.first.id);
      expect(cubit.state.service, featuredAstrologer.services.first);
    });

    blocTest<BookAppointmentCubit, BookAppointmentState>(
      'attached files travel with the booking',
      build: () {
        when(
          () => getTimeSlots(any()),
        ).thenAnswer((_) async => Result.success(slots));
        when(
          () => book(any()),
        ).thenAnswer((_) async => Result.success(upcoming));
        return BookAppointmentCubit(
          getTimeSlots: getTimeSlots,
          bookAppointment: book,
          astrologer: featuredAstrologer,
        );
      },
      act: (c) async {
        await c.loadSlots();
        c
          ..selectSlot('slot-9-0')
          ..setCheena('01JMEDIA000000000000000001')
          ..setReceipt('01JMEDIA000000000000000002');
        await c.submit();
      },
      verify: (c) {
        final req =
            verify(() => book(captureAny())).captured.single as BookingRequest;
        expect(req.cheenaMediaId, '01JMEDIA000000000000000001');
        expect(req.receiptMediaId, '01JMEDIA000000000000000002');
      },
    );

    test('removing an attachment clears it', () {
      final cubit = BookAppointmentCubit(
        getTimeSlots: getTimeSlots,
        bookAppointment: book,
        astrologer: featuredAstrologer,
      );
      addTearDown(cubit.close);

      cubit.setCheena('01JMEDIA000000000000000001');
      expect(cubit.state.cheenaMediaId, isNotNull);
      cubit.setCheena(null);
      expect(cubit.state.cheenaMediaId, isNull);
    });

    blocTest<BookAppointmentCubit, BookAppointmentState>(
      'slot failure keeps the wizard usable and steps stay clamped',
      build: () {
        when(
          () => getTimeSlots(any()),
        ).thenAnswer((_) async => const Result.failure(NetworkFailure()));
        return BookAppointmentCubit(
          getTimeSlots: getTimeSlots,
          bookAppointment: book,
          astrologer: featuredAstrologer,
        );
      },
      act: (c) async {
        await c.loadSlots();
        c
          ..previousStep()
          ..nextStep()
          ..nextStep()
          ..nextStep();
      },
      verify: (c) {
        expect(
          c.state.slots,
          const LoadState<List<TimeSlot>>.failed(NetworkFailure()),
        );
        expect(c.state.slot, isNull);
        expect(c.state.canProceedFromBasic, isFalse);
        expect(c.state.step, BookingStep.payment);
      },
    );
  });
}
