import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/availability.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/queue_entry.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/usecases/console_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/cubit/console_dashboard_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/usecases/consultation_usecases.dart';

class _MockDashboard extends Mock implements GetDashboard {}

class _MockAvailability extends Mock implements GetAvailability {}

class _MockSetOnline extends Mock implements SetOnline {}

class _MockQueue extends Mock implements GetQueue {}

class _MockPending extends Mock implements GetPendingRequest {}

class _MockRespond extends Mock implements RespondToRequest {}

class _MockSessions extends Mock implements GetAstrologerSessions {}

class _MockAcceptFromQueue extends Mock implements AcceptFromQueue {}

/// One window, which is all `hasSchedule` asks for.
const _withSchedule = Availability(
  windows: [
    AvailabilityWindow(weekday: 1, startMinute: 9 * 60, endMinute: 17 * 60),
  ],
);

void main() {
  late _MockAvailability getAvailability;
  late _MockSetOnline setOnline;
  late _MockQueue getQueue;

  setUpAll(() => registerFallbackValue(false));

  ConsoleDashboardCubit build() => ConsoleDashboardCubit(
    getDashboard: _MockDashboard(),
    getAvailability: getAvailability,
    setOnline: setOnline,
    getQueue: getQueue,
    getPendingRequest: _MockPending(),
    respondToRequest: _MockRespond(),
    acceptFromQueue: _MockAcceptFromQueue(),
    getSessions: _MockSessions(),
  );

  setUp(() {
    getAvailability = _MockAvailability();
    setOnline = _MockSetOnline();
    getQueue = _MockQueue();
    when(
      () => getQueue(),
    ).thenAnswer((_) async => const Result.success(<QueueEntry>[]));
  });

  group('why the online switch is unavailable', () {
    test(
      'a failed availability read is not reported as a missing schedule',
      () async {
        when(
          () => getAvailability(),
        ).thenAnswer((_) async => const Result.failure(ServerFailure('no')));
        final cubit = build();

        await cubit.retryAvailability();

        // The screen used to blame an empty schedule for this, sending the
        // astrologer to a schedule page where everything already looked right
        // while the real problem was a refused request.
        expect(cubit.state.onlineBlocker, OnlineBlocker.unavailable);
        expect(cubit.state.canGoOnline, isFalse);
        await cubit.close();
      },
    );

    test(
      'a loaded but empty schedule is reported as a missing schedule',
      () async {
        when(
          () => getAvailability(),
        ).thenAnswer((_) async => const Result.success(Availability()));
        final cubit = build();

        await cubit.retryAvailability();

        expect(cubit.state.onlineBlocker, OnlineBlocker.noSchedule);
        await cubit.close();
      },
    );

    test('a schedule with a window unblocks the switch', () async {
      when(
        () => getAvailability(),
      ).thenAnswer((_) async => const Result.success(_withSchedule));
      final cubit = build();

      await cubit.retryAvailability();

      expect(cubit.state.onlineBlocker, OnlineBlocker.none);
      expect(cubit.state.canGoOnline, isTrue);
      await cubit.close();
    });

    test('Retry recovers without a full reload', () async {
      var attempt = 0;
      when(() => getAvailability()).thenAnswer((_) async {
        attempt += 1;
        return attempt == 1
            ? const Result.failure(ServerFailure('stale token'))
            : const Result.success(_withSchedule);
      });
      final cubit = build();

      await cubit.retryAvailability();
      expect(cubit.state.onlineBlocker, OnlineBlocker.unavailable);

      await cubit.retryAvailability();
      expect(cubit.state.onlineBlocker, OnlineBlocker.none);
      await cubit.close();
    });
  });

  group('flipping the switch', () {
    test(
      'a refused change keeps the last confirmed value and reports it',
      () async {
        when(
          () => getAvailability(),
        ).thenAnswer((_) async => const Result.success(_withSchedule));
        when(() => setOnline(any())).thenAnswer(
          (_) async => const Result.failure(PermissionFailure('nope')),
        );
        final cubit = build();
        await cubit.retryAvailability();

        await cubit.toggleOnline();

        // Failing to "offline" would show a state the server never stored.
        expect(cubit.state.isOnline, isFalse);
        expect(cubit.state.availability.isFailed, isTrue);
        expect(cubit.state.availability.errorMessage, 'nope');
        // And the switch must not be left spinning.
        expect(cubit.state.togglingOnline, isFalse);
        await cubit.close();
      },
    );

    test('a second tap while one is in flight is dropped', () async {
      when(
        () => getAvailability(),
      ).thenAnswer((_) async => const Result.success(_withSchedule));
      final gate = Completer<Result<Availability>>();
      when(() => setOnline(any())).thenAnswer((_) => gate.future);

      final cubit = build();
      await cubit.retryAvailability();

      final first = cubit.toggleOnline();
      expect(cubit.state.togglingOnline, isTrue);
      // The switch is disabled while busy, but a fast double tap still lands.
      expect(cubit.state.canGoOnline, isFalse);

      await cubit.toggleOnline();

      gate.complete(Result.success(_withSchedule.copyWith(isOnline: true)));
      await first;

      // Two racing calls can land in either order, leaving the switch showing
      // the opposite of what the server stored.
      verify(() => setOnline(any())).called(1);
      expect(cubit.state.togglingOnline, isFalse);
      expect(cubit.state.isOnline, isTrue);
      await cubit.close();
    });
  });
}
