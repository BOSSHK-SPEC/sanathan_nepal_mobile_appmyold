import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/session/app_role.dart';
import '../../../../core/session/role_granter.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/domain/entities/specialty.dart';
import '../../domain/entities/application.dart';
import '../../domain/entities/astrologer_client.dart';
import '../../domain/entities/astrologer_profile.dart';
import '../../domain/entities/compliance_notice.dart';
import '../../domain/entities/work_preferences.dart';
import '../../domain/entities/boost.dart';
import '../../domain/entities/availability.dart';
import '../../domain/entities/console_appointment.dart';
import '../../domain/entities/console_pricing.dart';
import '../../domain/entities/console_stats.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/payout.dart';
import '../../domain/entities/queue_entry.dart';
import 'console_data_source.dart';
import 'console_seed.dart';

/// In-memory astrologer console.
///
/// The pieces that carry real rules are enforced here rather than in the UI,
/// so the screens cannot drift from them: an application cannot be submitted
/// with a required document missing, a payout cannot exceed the available
/// balance or fall below the minimum, overlapping availability windows are
/// rejected, and a review can only be replied to once.
class MockConsoleDataSource implements ConsoleDataSource {
  MockConsoleDataSource(this._store, this._regions, this._roles);

  final KeyValueStore _store;
  final RegionResolver _regions;
  final RoleGranter _roles;

  static const _applicationKey = 'console.application';
  static const _availabilityKey = 'console.availability';
  static const _pricingKey = 'console.pricing';
  static const _payoutAccountKey = 'console.payoutAccount';
  static const _payoutsKey = 'console.payouts';
  static const _clientNotesKey = 'console.clientNotes';
  static const _repliesKey = 'console.reviewReplies';
  static const _declinedKey = 'console.declinedRequests';
  static const _profileKey = 'console.profile';
  static const _workPrefsKey = 'console.workPreferences';
  static const _noticeStateKey = 'console.noticeState';

  static const Duration _latency = Duration(milliseconds: 180);

  /// Below this a payout costs more to process than it moves.
  static const double minimumPayout = 500;

  /// Flat processing fee, in the region's currency.
  static const double payoutFee = 40;

  /// How long a submitted application sits before it is treated as reviewed.
  ///
  /// A human reviewer does this in production — the copy still says two
  /// working days. Compressed here so the apply → approved → console flow is
  /// walkable end to end before the admin console exists.
  static const Duration reviewAfter = Duration(seconds: 20);

  /// India's currency is worth more per unit, so seeded amounts are scaled
  /// rather than reused verbatim.
  double get _scale => _regions.region == Region.nepal ? 1.0 : 0.6;

  // --- Application ------------------------------------------------------

  @override
  Future<AstrologerApplication> application() async {
    await Future<void>.delayed(_latency);
    return _reviewIfDue(_readApplication());
  }

  /// Advances a submitted application through review on elapsed time, and
  /// grants the astrologer role on approval.
  ///
  /// Derived from `submittedAt` rather than a stored flag, so reopening the
  /// app mid-review lands on the same state rather than restarting it.
  Future<AstrologerApplication> _reviewIfDue(
    AstrologerApplication application,
  ) async {
    if (application.status != ApplicationStatus.submitted &&
        application.status != ApplicationStatus.underReview) {
      return application;
    }
    final submittedAt = application.submittedAt;
    if (submittedAt == null) return application;

    final waited = DateTime.now().difference(submittedAt);
    if (waited < reviewAfter) {
      // Halfway through the window it moves to "under review", so the status
      // screen shows progress rather than sitting still.
      if (waited > reviewAfter ~/ 2 &&
          application.status == ApplicationStatus.submitted) {
        final reviewing = application.copyWith(
          status: ApplicationStatus.underReview,
        );
        await _writeApplication(reviewing);
        return reviewing;
      }
      return application;
    }

    final approved = application.copyWith(
      status: ApplicationStatus.approved,
      reviewedAt: DateTime.now(),
    );
    await _writeApplication(approved);
    // Approval is what actually turns the console on.
    await _roles.grant(AppRole.astrologer);
    return approved;
  }

  @override
  Future<AstrologerApplication> saveApplication(
    AstrologerApplication application,
  ) async {
    await Future<void>.delayed(_latency);
    final current = _readApplication();
    if (!current.status.isEditable) {
      throw const ValidationException(
        'This application is being reviewed and cannot be edited',
      );
    }
    final next = application.status == ApplicationStatus.notStarted
        ? application.copyWith(status: ApplicationStatus.draft)
        : application;
    await _writeApplication(next);
    return next;
  }

  @override
  Future<AstrologerApplication> uploadDocument({
    required KycDocumentKind kind,
    required String fileRef,
  }) async {
    await Future<void>.delayed(_latency);
    final current = _readApplication();
    final documents = [
      ...current.documents.where((d) => d.kind != kind),
      KycDocument(
        kind: kind,
        status: DocumentStatus.uploaded,
        fileRef: fileRef,
      ),
    ];
    final next = current.copyWith(
      documents: documents,
      status: current.status == ApplicationStatus.notStarted
          ? ApplicationStatus.draft
          : current.status,
    );
    await _writeApplication(next);
    return next;
  }

  @override
  Future<AstrologerApplication> removeDocument({
    required KycDocumentKind kind,
  }) async {
    await Future<void>.delayed(_latency);
    final current = _readApplication();
    // Mirrors the server's guard, so the mock cannot demo a flow the real API
    // refuses.
    if (!current.status.allowsDocumentChanges) {
      throw const ValidationException(
        'Documents cannot be changed while the application is under review.',
        'documents',
      );
    }
    final next = current.copyWith(
      documents: current.documents.where((d) => d.kind != kind).toList(),
    );
    await _writeApplication(next);
    return next;
  }

  @override
  Future<AstrologerApplication> acceptTerms(String version) async {
    await Future<void>.delayed(_latency);
    final next = _readApplication().copyWith(
      termsAcceptedAt: DateTime.now(),
      termsVersion: version,
    );
    await _writeApplication(next);
    return next;
  }

  @override
  Future<AstrologerApplication> submitApplication() async {
    await Future<void>.delayed(_latency);
    final current = _readApplication();
    if (current.missingRequired.isNotEmpty) {
      throw const ValidationException(
        'Upload every required document before submitting',
      );
    }
    if (!current.canSubmit) {
      throw const ValidationException('Complete every step before submitting');
    }
    final next = current.copyWith(
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );
    await _writeApplication(next);
    return next;
  }

  // --- Operations -------------------------------------------------------

  @override
  Future<DashboardStats> dashboard() async {
    await Future<void>.delayed(_latency);
    final entries = ConsoleSeed.earnings(scale: _scale);
    final now = DateTime.now();
    final today = entries.where(
      (e) =>
          e.occurredAt.year == now.year &&
          e.occurredAt.month == now.month &&
          e.occurredAt.day == now.day,
    );
    final weekStart = now.subtract(const Duration(days: 7));
    final week = entries.where((e) => e.occurredAt.isAfter(weekStart));

    // Last seven days, oldest first.
    final trend = <double>[];
    for (var back = 6; back >= 0; back--) {
      final day = now.subtract(Duration(days: back));
      trend.add(
        entries
            .where(
              (e) =>
                  e.occurredAt.year == day.year &&
                  e.occurredAt.month == day.month &&
                  e.occurredAt.day == day.day,
            )
            .fold<double>(0, (sum, e) => sum + e.net),
      );
    }

    return DashboardStats(
      earningsToday: today.fold<double>(0, (sum, e) => sum + e.net),
      earningsThisWeek: week.fold<double>(0, (sum, e) => sum + e.net),
      sessionsToday: today.length,
      minutesToday: today.fold<int>(0, (sum, e) => sum + e.minutes),
      waitingNow: (await queue()).length,
      rating: 4.8,
      reviewCount: 1240,
      acceptanceRate: 0.86,
      responseSeconds: 22,
      repeatRate: 0.41,
      earningsTrend: trend,
    );
  }

  @override
  Future<Availability> availability() async {
    await Future<void>.delayed(_latency);
    return _readAvailability();
  }

  @override
  Future<Availability> saveAvailability(Availability availability) async {
    await Future<void>.delayed(_latency);
    for (final window in availability.windows) {
      if (!window.isValid) {
        throw const ValidationException('End time must be after start time');
      }
    }
    // Overlapping windows on the same day would double-book the astrologer.
    for (var i = 0; i < availability.windows.length; i++) {
      for (var j = i + 1; j < availability.windows.length; j++) {
        if (availability.windows[i].overlaps(availability.windows[j])) {
          throw const ValidationException(
            'Two windows on the same day overlap',
          );
        }
      }
    }
    await _writeAvailability(availability);
    return availability;
  }

  @override
  Future<Availability> setOnline({required bool online}) async {
    await Future<void>.delayed(_latency);
    final current = _readAvailability();
    if (online && !current.hasSchedule) {
      throw const ValidationException(
        'Set your weekly hours before going online',
      );
    }
    final next = current.copyWith(isOnline: online);
    await _writeAvailability(next);
    return next;
  }

  @override
  Future<List<QueueEntry>> queue() async {
    if (!_readAvailability().isOnline) return [];
    final declined = _declined;
    return ConsoleSeed.queue().where((e) => !declined.contains(e.id)).toList();
  }

  @override
  Future<IncomingRequest?> pendingRequest() async {
    await Future<void>.delayed(_latency);
    final waiting = await queue();
    if (waiting.isEmpty) return null;
    // The longest-waiting person is offered first.
    final next = waiting.reduce(
      (a, b) => a.joinedAt.isBefore(b.joinedAt) ? a : b,
    );
    return IncomingRequest(entry: next, offeredAt: DateTime.now());
  }

  @override
  Future<void> respondToRequest({
    required String requestId,
    required bool accept,
  }) async {
    await Future<void>.delayed(_latency);
    if (accept) return;
    // Declining removes them from this astrologer's queue for good.
    await _store.setStringList(_declinedKey, [..._declined, requestId]);
  }

  Set<String> get _declined =>
      (_store.getStringList(_declinedKey) ?? const <String>[]).toSet();

  @override
  Future<List<AstrologerClient>> clients() async {
    await Future<void>.delayed(_latency);
    final notes = _clientNotes;
    return [
      for (final client in ConsoleSeed.clients(scale: _scale))
        notes.containsKey(client.id)
            ? client.copyWith(notes: notes[client.id]!)
            : client,
    ]..sort((a, b) => b.lastSessionAt.compareTo(a.lastSessionAt));
  }

  @override
  Future<AstrologerClient> client(String clientId) async {
    final all = await clients();
    final matches = all.where((c) => c.id == clientId);
    if (matches.isEmpty) {
      throw NotFoundException('No client with id "$clientId"');
    }
    return matches.first;
  }

  @override
  Future<AstrologerClient> saveClientNotes({
    required String clientId,
    required String notes,
  }) async {
    await Future<void>.delayed(_latency);
    final all = {..._clientNotes, clientId: notes};
    await _store.setString(_clientNotesKey, jsonEncode(all));
    return client(clientId);
  }

  Map<String, String> get _clientNotes {
    final raw = _store.getString(_clientNotesKey);
    if (raw == null || raw.isEmpty) return {};
    return (jsonDecode(raw) as Map<String, dynamic>).map(
      (k, v) => MapEntry(k, v as String),
    );
  }

  // --- Money ------------------------------------------------------------

  Duration _window(EarningsRange range) => switch (range) {
    EarningsRange.today => const Duration(days: 1),
    EarningsRange.week => const Duration(days: 7),
    EarningsRange.month => const Duration(days: 30),
    EarningsRange.year => const Duration(days: 365),
  };

  List<EarningEntry> _entriesIn(EarningsRange range) {
    final cutoff = DateTime.now().subtract(_window(range));
    return ConsoleSeed.earnings(
      scale: _scale,
    ).where((e) => e.occurredAt.isAfter(cutoff)).toList();
  }

  @override
  Future<EarningsSummary> earnings(EarningsRange range) async {
    await Future<void>.delayed(_latency);
    final all = ConsoleSeed.earnings(scale: _scale);
    final unsettled = all.where((e) => !e.settled);
    final settledButUnpaid = all.where((e) => e.settled);
    final alreadyRequested = _readPayouts()
        .where((p) => p.status != PayoutStatus.failed)
        .fold<double>(0, (sum, p) => sum + p.amount);

    return EarningsSummary(
      entries: _entriesIn(range),
      range: range,
      pendingBalance: unsettled.fold<double>(0, (sum, e) => sum + e.net),
      availableBalance:
          (settledButUnpaid.fold<double>(0, (sum, e) => sum + e.net) -
                  alreadyRequested)
              .clamp(0, double.infinity),
    );
  }

  @override
  Future<PerformanceMetrics> performance(EarningsRange range) async {
    await Future<void>.delayed(_latency);
    final entries = _entriesIn(range);
    final byChannel = <String, int>{};
    for (final e in entries) {
      byChannel[e.channel] = (byChannel[e.channel] ?? 0) + 1;
    }

    final days = _window(range).inDays.clamp(1, 90);
    final now = DateTime.now();
    final series = <double>[];
    for (var back = days - 1; back >= 0; back--) {
      final day = now.subtract(Duration(days: back));
      series.add(
        entries
            .where(
              (e) =>
                  e.occurredAt.year == day.year &&
                  e.occurredAt.month == day.month &&
                  e.occurredAt.day == day.day,
            )
            .fold<double>(0, (sum, e) => sum + e.net),
      );
    }

    return PerformanceMetrics(
      totalSessions: entries.length,
      totalMinutes: entries.fold<int>(0, (sum, e) => sum + e.minutes),
      totalEarnings: entries.fold<double>(0, (sum, e) => sum + e.net),
      averageRating: 4.8,
      acceptanceRate: 0.86,
      repeatRate: 0.41,
      sessionsByChannel: byChannel,
      earningsSeries: series,
    );
  }

  @override
  Future<PayoutAccount?> payoutAccount() async {
    await Future<void>.delayed(_latency);
    final raw = _store.getString(_payoutAccountKey);
    if (raw == null || raw.isEmpty) return null;
    final e = jsonDecode(raw) as Map<String, dynamic>;
    return PayoutAccount(
      destination: PayoutDestination.values.firstWhere(
        (d) => d.name == e['destination'],
        orElse: () => PayoutDestination.bankAccount,
      ),
      identifier: e['identifier'] as String? ?? '',
      holderName: e['holderName'] as String? ?? '',
      bankName: e['bankName'] as String? ?? '',
      verification: VerificationState.values.firstWhere(
        (v) => v.name == e['verification'],
        orElse: () => VerificationState.unverified,
      ),
    );
  }

  @override
  Future<PayoutAccount> savePayoutAccount(PayoutAccount account) async {
    await Future<void>.delayed(_latency);
    if (account.identifier.trim().isEmpty) {
      throw const ValidationException('Enter your account details');
    }
    if (account.holderName.trim().isEmpty) {
      throw const ValidationException('Enter the account holder name');
    }
    if (!PayoutAccount.forRegion(
      _regions.region,
    ).contains(account.destination)) {
      throw const ValidationException(
        'That payout method is not available in your region',
      );
    }
    // Verification is a real, asynchronous step — a penny-drop or a wallet
    // callback — so a saved account starts pending, never verified.
    final saved = account.copyWith(verification: VerificationState.pending);
    await _store.setString(
      _payoutAccountKey,
      jsonEncode({
        'destination': saved.destination.name,
        'identifier': saved.identifier,
        'holderName': saved.holderName,
        'bankName': saved.bankName,
        'verification': saved.verification.name,
      }),
    );
    return saved;
  }

  @override
  Future<List<PayoutRequest>> payouts() async {
    await Future<void>.delayed(_latency);
    return _readPayouts();
  }

  @override
  Future<PayoutRequest> requestPayout(double amount) async {
    await Future<void>.delayed(_latency);
    final account = await payoutAccount();
    if (account == null) {
      throw const ValidationException('Add a payout account first');
    }
    if (amount < minimumPayout) {
      throw ValidationException(
        'The minimum payout is ${minimumPayout.toStringAsFixed(0)}',
      );
    }
    final summary = await earnings(EarningsRange.year);
    if (amount > summary.availableBalance) {
      throw const ValidationException(
        'That is more than your available balance',
      );
    }

    final request = PayoutRequest(
      id: 'po-${DateTime.now().microsecondsSinceEpoch}',
      amount: amount,
      fee: payoutFee * _scale,
      status: PayoutStatus.requested,
      requestedAt: DateTime.now(),
    );
    await _writePayouts([request, ..._readPayouts()]);
    return request;
  }

  @override
  Future<List<TaxDocument>> taxDocuments() async {
    await Future<void>.delayed(_latency);
    return ConsoleSeed.taxDocuments(scale: _scale);
  }

  @override
  Future<ConsolePricing> pricing() async {
    await Future<void>.delayed(_latency);
    final raw = _store.getString(_pricingKey);
    if (raw == null || raw.isEmpty) return ConsoleSeed.pricing;
    final e = jsonDecode(raw) as Map<String, dynamic>;
    return ConsolePricing(
      ratePerMinute: {
        for (final entry in (e['rates'] as Map<String, dynamic>).entries)
          ConsultChannel.fromName(entry.key): (entry.value as num).toDouble(),
      },
      firstSessionRate: (e['firstSessionRate'] as num?)?.toDouble(),
      freeFirstMinutes: e['freeFirstMinutes'] as int? ?? 0,
      commissionRate: (e['commissionRate'] as num?)?.toDouble() ?? 0.2,
    );
  }

  @override
  Future<ConsolePricing> savePricing(ConsolePricing pricing) async {
    await Future<void>.delayed(_latency);
    if (!pricing.isValid) {
      throw const ValidationException('Set a rate for at least one channel');
    }
    await _store.setString(
      _pricingKey,
      jsonEncode({
        'rates': {
          for (final e in pricing.ratePerMinute.entries) e.key.name: e.value,
        },
        'firstSessionRate': pricing.firstSessionRate,
        'freeFirstMinutes': pricing.freeFirstMinutes,
        'commissionRate': pricing.commissionRate,
      }),
    );
    return pricing;
  }

  @override
  Future<List<AstrologerReview>> reviews() async {
    await Future<void>.delayed(_latency);
    final replies = _replies;
    return [
      for (final review in ConsoleSeed.reviews())
        replies.containsKey(review.id)
            ? review.copyWith(
                reply: replies[review.id],
                repliedAt: DateTime.now(),
              )
            : review,
    ];
  }

  @override
  Future<AstrologerReview> replyToReview({
    required String reviewId,
    required String reply,
  }) async {
    await Future<void>.delayed(_latency);
    if (reply.trim().isEmpty) {
      throw const ValidationException('Write a reply first');
    }
    final all = await reviews();
    final matches = all.where((r) => r.id == reviewId);
    if (matches.isEmpty) {
      throw NotFoundException('No review with id "$reviewId"');
    }
    if (matches.first.hasReply) {
      throw const ValidationException(
        'You have already replied to this review',
      );
    }
    await _store.setString(
      _repliesKey,
      jsonEncode({..._replies, reviewId: reply.trim()}),
    );
    return matches.first.copyWith(
      reply: reply.trim(),
      repliedAt: DateTime.now(),
    );
  }

  Map<String, String> get _replies {
    final raw = _store.getString(_repliesKey);
    if (raw == null || raw.isEmpty) return {};
    return (jsonDecode(raw) as Map<String, dynamic>).map(
      (k, v) => MapEntry(k, v as String),
    );
  }

  // --- Boost -------------------------------------------------------------

  static const _campaignsKey = 'console.boostCampaigns';

  @override
  Future<List<BoostPlan>> boostPlans() async {
    await Future<void>.delayed(_latency);
    return [
      BoostPlan(
        id: 'bp-top-3',
        placement: BoostPlacement.topOfList,
        days: 3,
        price: 900 * _scale,
        estimatedImpressions: 4500,
      ),
      BoostPlan(
        id: 'bp-top-7',
        placement: BoostPlacement.topOfList,
        days: 7,
        price: 1800 * _scale,
        estimatedImpressions: 11000,
        popular: true,
      ),
      BoostPlan(
        id: 'bp-home-7',
        placement: BoostPlacement.homeRail,
        days: 7,
        price: 2600 * _scale,
        estimatedImpressions: 18000,
      ),
      BoostPlan(
        id: 'bp-target-14',
        placement: BoostPlacement.targeted,
        days: 14,
        price: 3200 * _scale,
        estimatedImpressions: 9000,
      ),
    ];
  }

  @override
  Future<List<BoostCampaign>> boostCampaigns() async {
    await Future<void>.delayed(_latency);
    return _readCampaigns()..sort((a, b) => b.startedAt.compareTo(a.startedAt));
  }

  @override
  Future<BoostCampaign> buyBoost(String planId) async {
    await Future<void>.delayed(_latency);
    final plans = await boostPlans();
    final matches = plans.where((p) => p.id == planId);
    if (matches.isEmpty) {
      throw NotFoundException('No boost plan with id "$planId"');
    }
    final plan = matches.first;

    // Boost is paid out of earnings, so an astrologer who has already
    // withdrawn cannot buy visibility on credit.
    final summary = await earnings(EarningsRange.year);
    if (plan.price > summary.availableBalance) {
      throw const ValidationException(
        'Not enough available balance to buy this boost',
      );
    }

    final existing = _readCampaigns();
    if (existing.any((c) => c.isActive() && c.placement == plan.placement)) {
      throw const ValidationException(
        'You already have an active boost in that placement',
      );
    }

    final now = DateTime.now();
    final campaign = BoostCampaign(
      id: 'bc-${now.microsecondsSinceEpoch}',
      placement: plan.placement,
      startedAt: now,
      endsAt: now.add(Duration(days: plan.days)),
      spent: plan.price,
    );
    await _writeCampaigns([campaign, ...existing]);
    return campaign;
  }

  List<BoostCampaign> _readCampaigns() {
    final raw = _store.getString(_campaignsKey);
    if (raw == null || raw.isEmpty) {
      // One finished campaign, so the results view has something to show
      // before the astrologer has bought anything.
      final now = DateTime.now();
      return [
        BoostCampaign(
          id: 'bc-seed-1',
          placement: BoostPlacement.topOfList,
          startedAt: now.subtract(const Duration(days: 17)),
          endsAt: now.subtract(const Duration(days: 10)),
          spent: 1800 * _scale,
          impressions: 10400,
          profileViews: 612,
          consultations: 24,
        ),
      ];
    }
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        BoostCampaign(
          id: (e as Map<String, dynamic>)['id'] as String,
          placement: BoostPlacement.values.firstWhere(
            (p) => p.name == e['placement'],
            orElse: () => BoostPlacement.topOfList,
          ),
          startedAt: DateTime.parse(e['startedAt'] as String),
          endsAt: DateTime.parse(e['endsAt'] as String),
          spent: (e['spent'] as num).toDouble(),
          impressions: e['impressions'] as int? ?? 0,
          profileViews: e['profileViews'] as int? ?? 0,
          consultations: e['consultations'] as int? ?? 0,
        ),
    ];
  }

  Future<void> _writeCampaigns(List<BoostCampaign> campaigns) =>
      _store.setString(
        _campaignsKey,
        jsonEncode([
          for (final c in campaigns)
            {
              'id': c.id,
              'placement': c.placement.name,
              'startedAt': c.startedAt.toIso8601String(),
              'endsAt': c.endsAt.toIso8601String(),
              'spent': c.spent,
              'impressions': c.impressions,
              'profileViews': c.profileViews,
              'consultations': c.consultations,
            },
        ]),
      );

  // --- Compliance -------------------------------------------------------

  @override
  Future<List<ComplianceNotice>> complianceNotices() async {
    await Future<void>.delayed(_latency);
    final overrides = _noticeOverrides();
    final notices = [
      for (final n in _seedNotices()) _applyOverride(n, overrides[n.id]),
    ]..sort((a, b) => b.issuedAt.compareTo(a.issuedAt));
    return notices;
  }

  @override
  Future<ComplianceNotice> acknowledgeNotice(String id) =>
      _mutateNotice(id, (notice) {
        if (notice.status != ComplianceStatus.open) return notice;
        return notice.copyWith(
          status: ComplianceStatus.acknowledged,
          acknowledgedAt: DateTime.now(),
        );
      });

  @override
  Future<ComplianceNotice> appealNotice(String id, String reason) =>
      _mutateNotice(id, (notice) {
        if (!notice.canAppeal) {
          // Enforced here rather than in the UI: a closed appeal window is a
          // policy rule, and a screen must not be able to talk past it.
          throw const ValidationException(
            'This notice can no longer be appealed.',
          );
        }
        if (reason.trim().length < 20) {
          throw const ValidationException(
            'Explain what happened in a little more detail.',
          );
        }
        return notice.copyWith(
          status: ComplianceStatus.appealed,
          appealReason: reason.trim(),
          appealedAt: DateTime.now(),
        );
      });

  Future<ComplianceNotice> _mutateNotice(
    String id,
    ComplianceNotice Function(ComplianceNotice) change,
  ) async {
    await Future<void>.delayed(_latency);
    final overrides = _noticeOverrides();
    final seed = _seedNotices().firstWhere(
      (n) => n.id == id,
      orElse: () => throw NotFoundException('No notice with id "$id"'),
    );
    final updated = change(_applyOverride(seed, overrides[id]));
    overrides[id] = {
      'status': updated.status.name,
      'acknowledgedAt': updated.acknowledgedAt?.toIso8601String(),
      'appealReason': updated.appealReason,
      'appealedAt': updated.appealedAt?.toIso8601String(),
    };
    await _store.setString(_noticeStateKey, jsonEncode(overrides));
    return updated;
  }

  /// Only the astrologer-mutable fields are persisted; the notice itself is
  /// issued by the platform and stays as seeded.
  Map<String, dynamic> _noticeOverrides() {
    final raw = _store.getString(_noticeStateKey);
    if (raw == null || raw.isEmpty) return <String, dynamic>{};
    return (jsonDecode(raw) as Map<String, dynamic>);
  }

  ComplianceNotice _applyOverride(ComplianceNotice notice, Object? override) {
    if (override is! Map<String, dynamic>) return notice;
    return notice.copyWith(
      status: ComplianceStatus.values.firstWhere(
        (s) => s.name == override['status'],
        orElse: () => notice.status,
      ),
      acknowledgedAt: override['acknowledgedAt'] == null
          ? null
          : DateTime.parse(override['acknowledgedAt'] as String),
      appealReason: override['appealReason'] as String?,
      appealedAt: override['appealedAt'] == null
          ? null
          : DateTime.parse(override['appealedAt'] as String),
    );
  }

  List<ComplianceNotice> _seedNotices() {
    final now = DateTime.now();
    final currency = _regions.config.currencyCode;
    return [
      ComplianceNotice(
        id: 'notice-late-response',
        kind: ComplianceKind.lateResponse,
        severity: ComplianceSeverity.warning,
        title: 'Three requests went unanswered last week',
        body:
            'Requests that time out push seekers to another astrologer and '
            'lower your placement in search. Going offline when you are away '
            'protects your acceptance rate.',
        requiredAction: 'Review your schedule and quiet hours.',
        issuedAt: now.subtract(const Duration(days: 2)),
        dueBy: now.add(const Duration(days: 5)),
      ),
      ComplianceNotice(
        id: 'notice-refund',
        kind: ComplianceKind.refundIssued,
        severity: ComplianceSeverity.warning,
        title: 'A session was refunded',
        body:
            'The seeker reported that the call dropped four minutes in and '
            'did not reconnect. The session amount has been reversed from '
            'your next payout.',
        penaltyAmount: 480,
        referenceId: 'consult-2261',
        issuedAt: now.subtract(const Duration(days: 9)),
      ),
      ComplianceNotice(
        id: 'notice-policy',
        kind: ComplianceKind.policyUpdate,
        severity: ComplianceSeverity.info,
        title: 'Updated consultation policy',
        body:
            'From next month, remedies that require a payment outside the app '
            'are not permitted. Charges in $currency must go through the '
            'platform so seekers keep their refund protection.',
        issuedAt: now.subtract(const Duration(days: 21)),
        appealable: false,
      ),
    ];
  }

  // --- Work preferences -------------------------------------------------

  @override
  Future<WorkPreferences> workPreferences() async {
    await Future<void>.delayed(_latency);
    final raw = _store.getString(_workPrefsKey);
    if (raw == null || raw.isEmpty) return const WorkPreferences();
    final e = jsonDecode(raw) as Map<String, dynamic>;
    return WorkPreferences(
      newRequestAlerts: e['newRequestAlerts'] as bool? ?? true,
      alertSound: e['alertSound'] as bool? ?? true,
      ringUntilAnswered: e['ringUntilAnswered'] as bool? ?? true,
      scheduleReminders: e['scheduleReminders'] as bool? ?? true,
      payoutAlerts: e['payoutAlerts'] as bool? ?? true,
      reviewAlerts: e['reviewAlerts'] as bool? ?? true,
      marketingAlerts: e['marketingAlerts'] as bool? ?? false,
      quietHoursEnabled: e['quietHoursEnabled'] as bool? ?? false,
      quietStartMinute: e['quietStartMinute'] as int? ?? 22 * 60,
      quietEndMinute: e['quietEndMinute'] as int? ?? 7 * 60,
      acceptedChannels: {
        for (final c in (e['acceptedChannels'] as List<dynamic>? ?? []))
          ConsultChannel.fromName(c as String),
      },
      maxQueueLength: e['maxQueueLength'] as int? ?? 0,
      autoDeclineAfterSeconds: e['autoDeclineAfterSeconds'] as int? ?? 30,
      autoAcceptRepeatClients: e['autoAcceptRepeatClients'] as bool? ?? false,
    );
  }

  @override
  Future<WorkPreferences> saveWorkPreferences(WorkPreferences prefs) async {
    await Future<void>.delayed(_latency);
    if (!prefs.isValid) {
      throw const ValidationException('Those settings cannot be applied.');
    }
    await _store.setString(
      _workPrefsKey,
      jsonEncode({
        'newRequestAlerts': prefs.newRequestAlerts,
        'alertSound': prefs.alertSound,
        'ringUntilAnswered': prefs.ringUntilAnswered,
        'scheduleReminders': prefs.scheduleReminders,
        'payoutAlerts': prefs.payoutAlerts,
        'reviewAlerts': prefs.reviewAlerts,
        'marketingAlerts': prefs.marketingAlerts,
        'quietHoursEnabled': prefs.quietHoursEnabled,
        'quietStartMinute': prefs.quietStartMinute,
        'quietEndMinute': prefs.quietEndMinute,
        'acceptedChannels': [for (final c in prefs.acceptedChannels) c.name],
        'maxQueueLength': prefs.maxQueueLength,
        'autoDeclineAfterSeconds': prefs.autoDeclineAfterSeconds,
        'autoAcceptRepeatClients': prefs.autoAcceptRepeatClients,
      }),
    );
    return prefs;
  }

  // --- Public profile ---------------------------------------------------

  @override
  Future<AstrologerProfileDraft> profile() async {
    await Future<void>.delayed(_latency);
    final raw = _store.getString(_profileKey);
    // First read after approval: seed from the application so the astrologer
    // edits what reviewers already saw rather than a blank form.
    if (raw == null || raw.isEmpty) return _seedProfile(_readApplication());
    final e = jsonDecode(raw) as Map<String, dynamic>;
    return AstrologerProfileDraft(
      displayName: e['displayName'] as String? ?? '',
      headline: e['headline'] as String? ?? '',
      about: e['about'] as String? ?? '',
      specialties: [
        for (final s in (e['specialties'] as List<dynamic>? ?? []))
          Specialty.fromName(s as String),
      ],
      languageCodes: [
        for (final s in (e['languageCodes'] as List<dynamic>? ?? []))
          s as String,
      ],
      experienceYears: e['experienceYears'] as int? ?? 0,
      avatarRef: e['avatarRef'] as String?,
      introVideoRef: e['introVideoRef'] as String?,
      hiddenFromSearch: e['hiddenFromSearch'] as bool? ?? false,
    );
  }

  @override
  Future<AstrologerProfileDraft> saveProfile(
    AstrologerProfileDraft profile,
  ) async {
    await Future<void>.delayed(_latency);
    // A profile that seekers browse is not a draft — refusing to publish an
    // unusable one here means no screen can push one through by accident.
    if (!profile.isPublishable) {
      throw const ValidationException('Complete every required field first.');
    }
    await _store.setString(
      _profileKey,
      jsonEncode({
        'displayName': profile.displayName,
        'headline': profile.headline,
        'about': profile.about,
        'specialties': [for (final s in profile.specialties) s.name],
        'languageCodes': profile.languageCodes,
        'experienceYears': profile.experienceYears,
        'avatarRef': profile.avatarRef,
        'introVideoRef': profile.introVideoRef,
        'hiddenFromSearch': profile.hiddenFromSearch,
      }),
    );
    return profile;
  }

  AstrologerProfileDraft _seedProfile(AstrologerApplication a) =>
      AstrologerProfileDraft(
        displayName: a.fullName,
        headline: a.specialties.isEmpty
            ? ''
            : '${a.experienceYears}+ years · ${a.specialties.first.name}',
        about: a.bio,
        specialties: a.specialties,
        languageCodes: a.languageCodes,
        experienceYears: a.experienceYears,
        introVideoRef: a.introVideoRef,
      );

  // --- Persistence ------------------------------------------------------

  AstrologerApplication _readApplication() {
    final raw = _store.getString(_applicationKey);
    if (raw == null || raw.isEmpty) return const AstrologerApplication();
    final e = jsonDecode(raw) as Map<String, dynamic>;
    return AstrologerApplication(
      status: ApplicationStatus.values.firstWhere(
        (s) => s.name == e['status'],
        orElse: () => ApplicationStatus.notStarted,
      ),
      fullName: e['fullName'] as String? ?? '',
      phone: e['phone'] as String? ?? '',
      email: e['email'] as String? ?? '',
      experienceYears: e['experienceYears'] as int? ?? 0,
      bio: e['bio'] as String? ?? '',
      specialties: [
        for (final s in (e['specialties'] as List<dynamic>? ?? []))
          Specialty.fromName(s as String),
      ],
      languageCodes: [
        for (final s in (e['languageCodes'] as List<dynamic>? ?? []))
          s as String,
      ],
      ratePerMinute: {
        for (final entry in (e['rates'] as Map<String, dynamic>? ?? {}).entries)
          ConsultChannel.fromName(entry.key): (entry.value as num).toDouble(),
      },
      documents: [
        for (final d in (e['documents'] as List<dynamic>? ?? []))
          KycDocument(
            kind: KycDocumentKind.values.firstWhere(
              (k) => k.name == (d as Map<String, dynamic>)['kind'],
              orElse: () => KycDocumentKind.identityFront,
            ),
            status: DocumentStatus.values.firstWhere(
              (s) => s.name == (d as Map<String, dynamic>)['status'],
              orElse: () => DocumentStatus.missing,
            ),
            fileRef: (d as Map<String, dynamic>)['fileRef'] as String?,
          ),
      ],
      introVideoRef: e['introVideoRef'] as String?,
      termsVersion: e['termsVersion'] as String? ?? '',
      termsAcceptedAt: e['termsAcceptedAt'] == null
          ? null
          : DateTime.parse(e['termsAcceptedAt'] as String),
      submittedAt: e['submittedAt'] == null
          ? null
          : DateTime.parse(e['submittedAt'] as String),
      reviewerNote: e['reviewerNote'] as String?,
    );
  }

  Future<void> _writeApplication(AstrologerApplication a) => _store.setString(
    _applicationKey,
    jsonEncode({
      'status': a.status.name,
      'fullName': a.fullName,
      'phone': a.phone,
      'email': a.email,
      'experienceYears': a.experienceYears,
      'bio': a.bio,
      'specialties': [for (final s in a.specialties) s.name],
      'languageCodes': a.languageCodes,
      'rates': {for (final e in a.ratePerMinute.entries) e.key.name: e.value},
      'documents': [
        for (final d in a.documents)
          {'kind': d.kind.name, 'status': d.status.name, 'fileRef': d.fileRef},
      ],
      'introVideoRef': a.introVideoRef,
      'termsVersion': a.termsVersion,
      'termsAcceptedAt': a.termsAcceptedAt?.toIso8601String(),
      'submittedAt': a.submittedAt?.toIso8601String(),
      'reviewerNote': a.reviewerNote,
    }),
  );

  Availability _readAvailability() {
    final raw = _store.getString(_availabilityKey);
    if (raw == null || raw.isEmpty) return ConsoleSeed.availability;
    final e = jsonDecode(raw) as Map<String, dynamic>;
    return Availability(
      isOnline: e['isOnline'] as bool? ?? false,
      bufferMinutes: e['bufferMinutes'] as int? ?? 5,
      windows: [
        for (final w in (e['windows'] as List<dynamic>? ?? []))
          AvailabilityWindow(
            weekday: (w as Map<String, dynamic>)['weekday'] as int,
            startMinute: w['startMinute'] as int,
            endMinute: w['endMinute'] as int,
            channels: {
              for (final c in (w['channels'] as List<dynamic>? ?? []))
                ConsultChannel.fromName(c as String),
            },
          ),
      ],
      blackouts: [
        for (final b in (e['blackouts'] as List<dynamic>? ?? []))
          BlackoutDate(
            date: DateTime.parse((b as Map<String, dynamic>)['date'] as String),
            reason: b['reason'] as String? ?? '',
          ),
      ],
    );
  }

  Future<void> _writeAvailability(Availability a) => _store.setString(
    _availabilityKey,
    jsonEncode({
      'isOnline': a.isOnline,
      'bufferMinutes': a.bufferMinutes,
      'windows': [
        for (final w in a.windows)
          {
            'weekday': w.weekday,
            'startMinute': w.startMinute,
            'endMinute': w.endMinute,
            'channels': [for (final c in w.channels) c.name],
          },
      ],
      'blackouts': [
        for (final b in a.blackouts)
          {'date': b.date.toIso8601String(), 'reason': b.reason},
      ],
    }),
  );

  List<PayoutRequest> _readPayouts() {
    final raw = _store.getString(_payoutsKey);
    if (raw == null || raw.isEmpty) return ConsoleSeed.payouts(scale: _scale);
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        PayoutRequest(
          id: (e as Map<String, dynamic>)['id'] as String,
          amount: (e['amount'] as num).toDouble(),
          fee: (e['fee'] as num?)?.toDouble() ?? 0,
          status: PayoutStatus.values.firstWhere(
            (s) => s.name == e['status'],
            orElse: () => PayoutStatus.requested,
          ),
          requestedAt: DateTime.parse(e['requestedAt'] as String),
          settledAt: e['settledAt'] == null
              ? null
              : DateTime.parse(e['settledAt'] as String),
          reference: e['reference'] as String?,
        ),
    ];
  }

  Future<void> _writePayouts(List<PayoutRequest> payouts) => _store.setString(
    _payoutsKey,
    jsonEncode([
      for (final p in payouts)
        {
          'id': p.id,
          'amount': p.amount,
          'fee': p.fee,
          'status': p.status.name,
          'requestedAt': p.requestedAt.toIso8601String(),
          'settledAt': p.settledAt?.toIso8601String(),
          'reference': p.reference,
        },
    ]),
  );

  // --- Appointments -----------------------------------------------------

  /// The same rules as the server: only open sittings can be closed, the
  /// outcome only once the sitting has started, cancelling only before it
  /// ends — and a cancellation always carries a reason for the client.
  late List<ConsoleAppointment> _appointments = ConsoleSeed.appointments(
    scale: _scale,
    currency: _regions.region == Region.nepal ? 'NPR' : 'INR',
  );

  @override
  Future<List<ConsoleAppointment>> appointments(AppointmentScope scope) async {
    await Future<void>.delayed(_latency);
    final now = DateTime.now();
    bool upcoming(ConsoleAppointment a) =>
        a.status.isOpen && a.endsAt.isAfter(now);
    final wantUpcoming = scope == AppointmentScope.upcoming;
    return _appointments.where((a) => upcoming(a) == wantUpcoming).toList()
      ..sort(
        (a, b) => wantUpcoming
            ? a.startsAt.compareTo(b.startsAt)
            : b.startsAt.compareTo(a.startsAt),
      );
  }

  @override
  Future<ConsoleAppointment> appointment(String id) async {
    await Future<void>.delayed(_latency);
    return _findAppointment(id);
  }

  @override
  Future<ConsoleAppointment> recordAppointmentOutcome(
    String id, {
    required bool completed,
  }) async {
    await Future<void>.delayed(_latency);
    final current = _findAppointment(id);
    if (!current.status.isOpen) {
      throw const ValidationException('This appointment is already closed');
    }
    if (current.startsAt.isAfter(DateTime.now())) {
      throw const ValidationException(
        'You can mark this once the sitting has started',
      );
    }
    return _replaceAppointment(
      current.copyWith(
        status: completed
            ? ConsoleAppointmentStatus.completed
            : ConsoleAppointmentStatus.noShow,
      ),
    );
  }

  @override
  Future<ConsoleAppointment> cancelAppointment(
    String id, {
    required String reason,
  }) async {
    await Future<void>.delayed(_latency);
    final current = _findAppointment(id);
    final why = reason.trim();
    if (why.length < 3) {
      throw const ValidationException(
        'Tell the client why, in a few words.',
        'reason',
      );
    }
    if (!current.status.isOpen) {
      throw const ValidationException('This appointment is already closed');
    }
    if (!current.endsAt.isAfter(DateTime.now())) {
      throw const ValidationException(
        'This sitting is over — mark how it went instead',
      );
    }
    return _replaceAppointment(
      current.copyWith(
        status: ConsoleAppointmentStatus.cancelled,
        cancelReason: 'Cancelled by the astrologer: $why',
      ),
    );
  }

  ConsoleAppointment _findAppointment(String id) => _appointments.firstWhere(
    (a) => a.id == id,
    orElse: () => throw NotFoundException('Appointment $id not found'),
  );

  ConsoleAppointment _replaceAppointment(ConsoleAppointment updated) {
    _appointments = [
      for (final a in _appointments) a.id == updated.id ? updated : a,
    ];
    return updated;
  }
}
