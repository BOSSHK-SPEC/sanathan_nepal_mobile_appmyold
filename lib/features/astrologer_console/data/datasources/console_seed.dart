import 'dart:math';

import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/astrologer_client.dart';
import '../../domain/entities/availability.dart';
import '../../domain/entities/console_pricing.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/payout.dart';
import '../../domain/entities/queue_entry.dart';

/// Seed data for the astrologer console.
///
/// Scaled by region so the numbers read plausibly in either currency, and
/// generated from a fixed seed so charts and totals are stable across runs.
abstract final class ConsoleSeed {
  /// Fixed seed for the generated ledger.
  ///
  /// A *new* [Random] is created per call rather than shared: a shared
  /// generator advances between calls, so the dashboard and the earnings
  /// screen would compute different totals from what is meant to be the
  /// same data.
  static const int _randomSeed = 20260903;

  /// A working week: mornings every weekday, plus a long Saturday.
  static const Availability availability = Availability(
    isOnline: true,
    windows: [
      AvailabilityWindow(weekday: 1, startMinute: 540, endMinute: 780),
      AvailabilityWindow(weekday: 2, startMinute: 540, endMinute: 780),
      AvailabilityWindow(weekday: 3, startMinute: 540, endMinute: 780),
      AvailabilityWindow(weekday: 4, startMinute: 540, endMinute: 780),
      AvailabilityWindow(weekday: 5, startMinute: 540, endMinute: 780),
      AvailabilityWindow(
        weekday: 6,
        startMinute: 600,
        endMinute: 1020,
        channels: {ConsultChannel.chat, ConsultChannel.voice},
      ),
    ],
  );

  static const ConsolePricing pricing = ConsolePricing(
    ratePerMinute: {
      ConsultChannel.chat: 25,
      ConsultChannel.voice: 40,
      ConsultChannel.video: 60,
    },
    freeFirstMinutes: 2,
  );

  static List<QueueEntry> queue({DateTime? now}) {
    final at = now ?? DateTime.now();
    return [
      QueueEntry(
        id: 'q1',
        seekerName: 'Sabina K.',
        channel: ConsultChannel.chat,
        joinedAt: at.subtract(const Duration(minutes: 4)),
        question: 'Should I accept the job offer in Pokhara?',
        isRepeatClient: true,
        affordableMinutes: 18,
      ),
      QueueEntry(
        id: 'q2',
        seekerName: 'Rajan M.',
        channel: ConsultChannel.voice,
        joinedAt: at.subtract(const Duration(minutes: 2)),
        question: 'Marriage timing',
        affordableMinutes: 2,
      ),
      QueueEntry(
        id: 'q3',
        seekerName: 'Nisha T.',
        channel: ConsultChannel.chat,
        joinedAt: at.subtract(const Duration(seconds: 40)),
        question: 'Property purchase muhurta',
        affordableMinutes: 25,
      ),
    ];
  }

  static List<AstrologerClient> clients({double scale = 1}) {
    final now = DateTime.now();
    return [
      AstrologerClient(
        id: 'c1',
        name: 'Sabina K.',
        sessionCount: 6,
        lifetimeValue: 4200 * scale,
        lastSessionAt: now.subtract(const Duration(days: 2)),
        birthDetails: '12 Mar 1994 · 06:20 · Kathmandu',
        notes: 'Jupiter dasha until 2027. Career questions.',
        averageRating: 5,
      ),
      AstrologerClient(
        id: 'c2',
        name: 'Rajan M.',
        sessionCount: 1,
        lifetimeValue: 500 * scale,
        lastSessionAt: now.subtract(const Duration(days: 9)),
        birthDetails: '3 Aug 1988 · 22:10 · Biratnagar',
        averageRating: 4,
      ),
      AstrologerClient(
        id: 'c3',
        name: 'Gita P.',
        sessionCount: 3,
        lifetimeValue: 2100 * scale,
        lastSessionAt: now.subtract(const Duration(days: 21)),
        birthDetails: '19 Nov 1979 · time unknown · Butwal',
        notes: 'Prashna only — birth time not available.',
        averageRating: 5,
      ),
      AstrologerClient(
        id: 'c4',
        name: 'Amrit S.',
        sessionCount: 2,
        lifetimeValue: 1150 * scale,
        lastSessionAt: now.subtract(const Duration(days: 34)),
        birthDetails: '27 Jan 2000 · 14:45 · Lalitpur',
        averageRating: 4,
      ),
    ];
  }

  /// Ninety days of sessions, so every range on the earnings screen has
  /// something real to sum.
  static List<EarningEntry> earnings({
    double scale = 1,
    double commissionRate = 0.2,
  }) {
    final random = Random(_randomSeed);
    final now = DateTime.now();
    final names = ['Sabina K.', 'Rajan M.', 'Gita P.', 'Amrit S.', 'Dipesh L.'];
    const channels = ['chat', 'voice', 'video'];
    final entries = <EarningEntry>[];

    for (var day = 0; day < 90; day++) {
      // Two or three sessions on most days, none on some.
      final count = random.nextInt(4);
      for (var i = 0; i < count; i++) {
        final minutes = 4 + random.nextInt(26);
        final channel = channels[random.nextInt(channels.length)];
        final rate = switch (channel) {
          'chat' => 25.0,
          'voice' => 40.0,
          _ => 60.0,
        };
        final gross = minutes * rate * scale;
        entries.add(
          EarningEntry(
            id: 'e-$day-$i',
            clientName: names[random.nextInt(names.length)],
            channel: channel,
            minutes: minutes,
            gross: gross,
            commission: gross * commissionRate,
            occurredAt: now.subtract(Duration(days: day, hours: 9 + i * 2)),
            settled: day > 7,
          ),
        );
      }
    }
    return entries..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
  }

  static List<PayoutRequest> payouts({double scale = 1}) {
    final now = DateTime.now();
    return [
      PayoutRequest(
        id: 'po-1',
        amount: 18400 * scale,
        fee: 40 * scale,
        status: PayoutStatus.paid,
        requestedAt: now.subtract(const Duration(days: 31)),
        settledAt: now.subtract(const Duration(days: 29)),
        reference: 'PO-2026-0731',
      ),
      PayoutRequest(
        id: 'po-2',
        amount: 22150 * scale,
        fee: 40 * scale,
        status: PayoutStatus.paid,
        requestedAt: now.subtract(const Duration(days: 14)),
        settledAt: now.subtract(const Duration(days: 12)),
        reference: 'PO-2026-0818',
      ),
      PayoutRequest(
        id: 'po-3',
        amount: 9600 * scale,
        fee: 40 * scale,
        status: PayoutStatus.processing,
        requestedAt: now.subtract(const Duration(days: 2)),
      ),
    ];
  }

  static List<TaxDocument> taxDocuments({double scale = 1}) {
    final now = DateTime.now();
    return [
      TaxDocument(
        id: 'tax-1',
        title: 'Annual earnings statement',
        financialYear: '2025–26',
        amount: 412000 * scale,
        issuedAt: DateTime(now.year, 4, 15),
      ),
      TaxDocument(
        id: 'tax-2',
        title: 'Tax deducted certificate',
        financialYear: '2025–26',
        amount: 41200 * scale,
        issuedAt: DateTime(now.year, 5, 2),
      ),
    ];
  }

  static List<AstrologerReview> reviews() {
    final now = DateTime.now();
    return [
      AstrologerReview(
        id: 'ar-1',
        astrologerId: 'me',
        authorName: 'Sabina K.',
        rating: 5,
        comment:
            'Very detailed reading. The Dasha explanation finally made sense.',
        tags: const ['Accurate', 'Patient'],
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      AstrologerReview(
        id: 'ar-2',
        astrologerId: 'me',
        authorName: 'Rajan M.',
        rating: 3,
        comment: 'Helpful, but we ran out of time before the Vaastu part.',
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      AstrologerReview(
        id: 'ar-3',
        astrologerId: 'me',
        authorName: 'Gita P.',
        rating: 5,
        comment: 'Third reading with him. Consistent every time.',
        tags: const ['Honest'],
        createdAt: now.subtract(const Duration(days: 12)),
        reply: 'Thank you Gita. Always good to speak with you.',
        repliedAt: now.subtract(const Duration(days: 11)),
      ),
    ];
  }
}
