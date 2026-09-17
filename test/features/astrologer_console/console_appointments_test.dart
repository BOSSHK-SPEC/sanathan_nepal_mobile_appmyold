import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/primary_button.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/astrologer_console_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/data/datasources/api_console_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/data/datasources/console_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/console_appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/pages/console_appointment_detail_page.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/pages/console_appointments_page.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// Astrologers had no screen for the sittings booked with them. These pin the
/// wire contract and the two screens that replaced that gap.
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.body);
  final Object body;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// `GET /console/appointments/:id` as the server answers it.
const _wire = {
  'id': 'ap1',
  'reference': 'AP-X6KBDJ8DT',
  'status': 'confirmed',
  'startsAt': '2026-09-18T11:25:00.000Z',
  'endsAt': '2026-09-18T11:55:00.000Z',
  'priceMinor': '150000',
  'currency': 'INR',
  'quantity': 1,
  'paymentMethod': 'upi',
  'client': {
    'id': 'seeker1',
    'name': 'Jackie',
    'phone': '9686912637',
    'email': 'jackie@gmail.com',
    'country': 'India',
  },
  'intake': {
    'birthDate': '2001-09-11',
    'birthTime': '12:00',
    'birthPlace': 'Hassan',
  },
  'note': '',
  'cancelReason': null,
  'hasBirthChart': true,
  'hasReceipt': false,
  'birthChartUrl': 'https://files.test/chart?sig=1',
  'receiptUrl': null,
};

/// An astrologer whose diary holds nothing at all.
class _NoAppointments extends Fake implements ConsoleDataSource {
  @override
  Future<List<ConsoleAppointment>> appointments(AppointmentScope scope) async =>
      const [];
}

class _NoopGranter implements RoleGranter {
  @override
  Future<void> grant(AppRole role) async {}

  @override
  Future<void> revoke(AppRole role) async {}
}

void main() {
  group('the wire', () {
    late _StubAdapter adapter;
    ApiConsoleDataSource source(Object body) {
      adapter = _StubAdapter(body);
      return ApiConsoleDataSource(
        ApiClient(baseUrl: 'http://localhost/api/v1')
          ..dio.httpClientAdapter = adapter,
        () => 'en',
      );
    }

    test('reads an appointment with the client and birth details', () async {
      final a = await source(_wire).appointment('ap1');

      expect(
        adapter.requests.single.path,
        endsWith('/console/appointments/ap1'),
      );
      expect(a.status, ConsoleAppointmentStatus.confirmed);
      expect(a.clientName, 'Jackie');
      expect(a.clientPhone, '9686912637');
      expect(a.price, 1500);
      expect(a.birthPlace, 'Hassan');
      expect(a.birthTime, '12:00');
      expect(a.hasBirthChart, isTrue);
      expect(a.birthChartUrl, 'https://files.test/chart?sig=1');
      expect(a.length, const Duration(minutes: 30));
    });

    test('asks for one tab at a time', () async {
      await source([_wire]).appointments(AppointmentScope.past);
      final request = adapter.requests.single;
      expect(request.path, endsWith('/console/appointments'));
      expect(request.queryParameters, {'scope': 'past'});
    });

    test('a cancellation carries the reason the client will read', () async {
      await source({
        ..._wire,
        'status': 'cancelled',
      }).cancelAppointment('ap1', reason: 'Travelling');
      final request = adapter.requests.single;
      expect(request.method, 'POST');
      expect(request.path, endsWith('/console/appointments/ap1/cancel'));
      expect(request.data, {'reason': 'Travelling'});
    });

    test('a no-show and a completion go to different places', () async {
      final s = source(_wire);
      await s.recordAppointmentOutcome('ap1', completed: false);
      await s.recordAppointmentOutcome('ap1', completed: true);
      expect(adapter.requests.map((r) => r.path.split('/').last), [
        'no-show',
        'complete',
      ]);
    });
  });

  group('the screens', () {
    final sl = GetIt.instance;

    setUp(() {
      sl
        ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
        ..registerLazySingleton<RegionResolver>(
          () => const FixedRegionResolver(Region.nepal),
        )
        ..registerLazySingleton<RoleGranter>(_NoopGranter.new);
      registerAstrologerConsoleFeature(sl);
    });
    tearDown(sl.reset);

    Widget app(Widget page) => SessionScope(
      session: const AppSession(
        userId: 'a1',
        isAuthenticated: true,
        roles: {AppRole.astrologer},
      ),
      child: RegionScope(
        region: Region.nepal,
        child: MaterialApp.router(
          theme: AppTheme.light(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: GoRouter(
            initialLocation: AppRoutes.home,
            routes: [
              GoRoute(path: AppRoutes.home, builder: (_, _) => page),
              GoRoute(
                path: AppRoutes.astrologerAppointment,
                builder: (_, state) => ConsoleAppointmentDetailPage(
                  appointmentId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    testWidgets('lists what is coming up, and what is over on its own tab', (
      tester,
    ) async {
      await tester.pumpWidget(app(const ConsoleAppointmentsPage()));
      await tester.pumpAndSettle();

      expect(find.text('Appointments'), findsOneWidget);
      expect(find.text('Sabina K.'), findsOneWidget);
      expect(find.text('Rajan M.'), findsOneWidget);
      expect(find.text('For 2 people'), findsOneWidget);
      // Over and done with: not in the upcoming list.
      expect(find.text('Gita P.'), findsNothing);

      await tester.tap(find.text('Past'));
      await tester.pumpAndSettle();
      expect(find.text('Gita P.'), findsOneWidget);
      expect(find.text('Amrit S.'), findsOneWidget);
      expect(find.text('Sabina K.'), findsNothing);
      // Finished live sessions belong to the same history: an astrologer who
      // only takes sessions had nothing here at all.
      expect(find.text('Bina R.'), findsOneWidget);
      expect(find.textContaining('Chat'), findsOneWidget);
      expect(find.text('Missed'), findsOneWidget);
    });

    testWidgets('a finished session shows what the astrologer advised', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(900, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        app(const ConsoleAppointmentDetailPage(appointmentId: 'cs-1')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Chat'), findsWidgets);
      expect(find.text('What you advised'), findsOneWidget);
      expect(find.textContaining('Saturn transit until Magh'), findsOneWidget);
      expect(find.text('Blue sapphire'), findsOneWidget);
      expect(find.text('Wear on a Saturday morning.'), findsOneWidget);
      expect(find.text('Gemstone'), findsOneWidget);
      expect(find.text('Shani mantra, 108 times'), findsOneWidget);
      expect(find.text('Follow-up'), findsOneWidget);
    });

    testWidgets('says so plainly when nothing is over yet', (tester) async {
      // An astrologer with only future sittings: the Past tab is empty, and
      // must say that rather than show a blank screen.
      sl.unregister<ConsoleDataSource>();
      sl.registerLazySingleton<ConsoleDataSource>(_NoAppointments.new);

      await tester.pumpWidget(app(const ConsoleAppointmentsPage()));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Past'));
      await tester.pumpAndSettle();

      expect(find.text('No past appointments yet'), findsOneWidget);
    });

    testWidgets('an appointment shows the client, their birth details, and '
        'cancels only with a reason', (tester) async {
      tester.view.physicalSize = const Size(900, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        app(const ConsoleAppointmentDetailPage(appointmentId: 'ap-1')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sabina K.'), findsOneWidget);
      expect(find.text('Confirmed'), findsOneWidget);
      expect(find.text('Booking AP-X6KBDJ8DT'), findsOneWidget);
      // The dial code is added to a national number, for WhatsApp's sake.
      expect(find.text('+9779841000001'), findsOneWidget);
      expect(find.text('Kathmandu'), findsOneWidget);
      expect(
        find.text('Career questions — a job offer abroad.'),
        findsOneWidget,
      );
      expect(find.text('Birth chart (cheena)'), findsOneWidget);
      // Tomorrow's sitting: too early to say how it went.
      expect(find.text('Mark as completed'), findsNothing);
      expect(
        find.text('You can mark how it went once the sitting starts.'),
        findsOneWidget,
      );

      await tester.tap(find.text('Cancel appointment'));
      await tester.pumpAndSettle();
      expect(find.text('Cancel this appointment?'), findsOneWidget);

      // No reason, no cancellation.
      // The sheet's confirm button shares its label with the one that opened
      // it; it is the only PrimaryButton with that label.
      final confirm = find.widgetWithText(PrimaryButton, 'Cancel appointment');
      await tester.tap(confirm);
      await tester.pumpAndSettle();
      expect(find.text('Tell the client why, in a few words.'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Travelling that day');
      await tester.tap(confirm);
      await tester.pumpAndSettle();

      expect(find.text('Cancelled'), findsOneWidget);
      expect(
        find.text('Cancelled by the astrologer: Travelling that day'),
        findsOneWidget,
      );
      expect(find.text('Appointment cancelled.'), findsOneWidget);
      // Closed: nothing left to act on.
      expect(find.text('Cancel appointment'), findsNothing);
    });
  });
}
