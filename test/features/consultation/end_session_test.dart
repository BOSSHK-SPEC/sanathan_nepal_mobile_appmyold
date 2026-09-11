import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/consultation.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/presentation/cubit/astrologer_session_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/presentation/cubit/live_session_cubit.dart';

/// Ending a session used to fail in complete silence: the outcome was written
/// to state that no widget read, so the button confirmed, did nothing, and
/// explained nothing — while the session stayed open and kept billing.
void main() {
  group('seeker', () {
    test('a failed end has a reason to show', () {
      const state = LiveSessionState(
        ending: LoadState<Consultation>.failed(
          ValidationFailure('Not enough balance in your wallet'),
        ),
      );

      expect(state.endError, 'Not enough balance in your wallet');
      expect(state.isEnding, isFalse);
    });

    test('in flight while the request is out', () {
      const state = LiveSessionState(ending: LoadState<Consultation>.loading());

      expect(state.isEnding, isTrue);
      expect(state.endError, isNull);
    });

    test('nothing to report before anyone has tried', () {
      const state = LiveSessionState();

      expect(state.endError, isNull);
      expect(state.isEnding, isFalse);
    });
  });

  group('astrologer', () {
    test('a failed end has a reason to show', () {
      const state = AstrologerSessionState(
        ending: LoadState<Consultation>.failed(ServerFailure('down')),
      );

      expect(state.endError, 'down');
    });

    test('in flight while the request is out', () {
      expect(
        const AstrologerSessionState(
          ending: LoadState<Consultation>.loading(),
        ).isEnding,
        isTrue,
      );
    });
  });
}
