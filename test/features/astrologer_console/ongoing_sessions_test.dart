import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/localized_text.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/cubit/console_dashboard_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/consultation.dart';

Consultation _session({
  required String id,
  required ConsultationStatus status,
  DateTime? startedAt,
  ConsultChannel channel = ConsultChannel.chat,
}) => Consultation(
  id: id,
  astrologerId: 'a1',
  astrologerName: const LocalizedText(en: 'Astro', ne: 'Astro'),
  channel: channel,
  status: status,
  ratePerMinute: 20,
  createdAt: DateTime(2026, 9, 10),
  startedAt: startedAt,
);

/// Accepting a request removes it from the queue server-side, so once the
/// session screen was closed nothing anywhere pointed back at it — the
/// astrologer could not return to a conversation the seeker was still in and
/// still being charged for. These pin the list that fixes that.
void main() {
  test('only active sessions are offered', () {
    final state = ConsoleDashboardState(
      sessions: LoadState.loaded([
        _session(id: 'live', status: ConsultationStatus.active),
        _session(id: 'done', status: ConsultationStatus.completed),
        _session(id: 'gone', status: ConsultationStatus.cancelled),
        _session(id: 'waiting', status: ConsultationStatus.queued),
      ]),
    );

    expect(state.liveSessions.map((s) => s.id), ['live']);
    expect(state.hasLiveSessions, isTrue);
  });

  test('the most recently started comes first', () {
    final state = ConsoleDashboardState(
      sessions: LoadState.loaded([
        _session(
          id: 'older',
          status: ConsultationStatus.active,
          startedAt: DateTime(2026, 9, 10, 9),
        ),
        _session(
          id: 'newer',
          status: ConsultationStatus.active,
          startedAt: DateTime(2026, 9, 10, 11),
        ),
      ]),
    );

    expect(state.liveSessions.map((s) => s.id), ['newer', 'older']);
  });

  test('nothing running means the section stays hidden', () {
    final state = ConsoleDashboardState(
      sessions: LoadState.loaded([
        _session(id: 'done', status: ConsultationStatus.completed),
      ]),
    );

    expect(state.hasLiveSessions, isFalse);
  });

  test('a failed poll keeps the last known sessions on screen', () {
    final state = ConsoleDashboardState(
      sessions: LoadState.failed(
        const Failure.server('flaky'),
        previous: [_session(id: 'live', status: ConsultationStatus.active)],
      ),
    );

    // The astrologer was about to tap it; a dropped poll must not blank it.
    expect(state.liveSessions.map((s) => s.id), ['live']);
  });
}
