import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_localized.dart';
import '../../../../core/network/api_money.dart';
import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/domain/entities/specialty.dart';
import '../../../consultation/domain/entities/session_summary.dart';
import '../../domain/entities/application.dart';
import '../../domain/entities/astrologer_client.dart';
import '../../domain/entities/astrologer_profile.dart';
import '../../domain/entities/availability.dart';
import '../../domain/entities/boost.dart';
import '../../domain/entities/compliance_notice.dart';
import '../../domain/entities/console_appointment.dart';
import '../../domain/entities/console_pricing.dart';
import '../../domain/entities/console_stats.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/payout.dart';
import '../../domain/entities/queue_entry.dart';
import '../../domain/entities/work_preferences.dart';
import 'console_data_source.dart';

/// The astrologer console, backed by the API.
///
/// Everything money- or standing-related is read, never computed here:
/// earnings, commission, acceptance rate and compliance notices all come from
/// the server, because they are the numbers the astrologer is paid and judged
/// on and the device is not a trustworthy place to derive them.
class ApiConsoleDataSource implements ConsoleDataSource {
  const ApiConsoleDataSource(this._client, this._languageCode);

  final ApiClient _client;
  final String Function() _languageCode;

  // ----------------------------------------------------------- application --

  @override
  Future<AstrologerApplication> application() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consoleApplication,
    );
    return _toApplication(asJsonMap(response));
  });

  @override
  Future<AstrologerApplication> saveApplication(
    AstrologerApplication application,
  ) => guardApi(() async {
    final response = await _client.put<dynamic>(
      ApiEndpoints.consoleApplication,
      data: {
        'fullName': application.fullName,
        // Both are asked for on the wizard's identity step, and both gate it:
        // an application the reviewer cannot ring, or that quotes no rate, is
        // not an application.
        'phone': application.phone,
        'ratePerMinute': {
          for (final entry in application.ratePerMinute.entries)
            entry.key.name: ApiMoney.toMinorString(entry.value),
        },
        // Only when there is something to send. The server requires a
        // non-empty English string inside a localized field, so posting
        // `{en: ''}` — which is what an untouched bio produces — made every
        // draft save fail while the applicant was still on the first step.
        if (application.bio.trim().isNotEmpty) ...{
          'headline': {'en': application.bio.split('.').first.trim()},
          'about': {'en': application.bio.trim()},
        },
        'languageCodes': application.languageCodes,
        'specialties': application.specialties.map((s) => s.name).toList(),
        'experienceYears': application.experienceYears,
      },
    );
    return _toApplication(asJsonMap(response));
  });

  @override
  Future<AstrologerApplication> uploadDocument({
    required KycDocumentKind kind,
    required String fileRef,
  }) => guardApi(() async {
    // The file itself is uploaded to storage first; only its media id is sent
    // here, so a KYC document never travels through the JSON API.
    final response = await _client.post<dynamic>(
      ApiEndpoints.consoleApplicationDocuments,
      data: {'kind': _documentKind(kind), 'mediaId': fileRef},
    );
    return _toApplication(asJsonMap(response));
  });

  @override
  Future<AstrologerApplication> removeDocument({
    required KycDocumentKind kind,
  }) => guardApi(() async {
    // The server deletes the stored file too, so this is the only call needed
    // — issuing a separate DELETE /media/:id would race with it and leave one
    // of the two failing on an object the other already removed.
    final response = await _client.delete<dynamic>(
      ApiEndpoints.consoleApplicationDocument(_documentKind(kind)),
    );
    return _toApplication(asJsonMap(response));
  });

  @override
  Future<AstrologerApplication> acceptTerms(String version) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.consoleApplicationTerms,
          data: {'version': version},
        );
        return _toApplication(asJsonMap(response));
      });

  @override
  Future<AstrologerApplication> submitApplication() => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consoleApplicationSubmit,
    );
    return _toApplication(asJsonMap(response));
  });

  // ------------------------------------------------------------- dashboard --

  @override
  Future<DashboardStats> dashboard() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consoleDashboard);
    final json = asJsonMap(response);
    return DashboardStats(
      earningsToday: ApiMoney.toMajor(json['earningsTodayMinor']),
      earningsThisWeek: ApiMoney.toMajor(json['earningsThisWeekMinor']),
      sessionsToday: _int(json['sessionsToday']),
      minutesToday: _int(json['minutesToday']),
      waitingNow: _int(json['queueLength']),
      rating: _double(json['ratingAvg']),
      reviewCount: _int(json['reviewCount']),
      acceptanceRate: _double(json['acceptanceRate']),
      responseSeconds: _int(json['responseSeconds']),
      repeatRate: _double(json['repeatRate']),
      earningsTrend:
          (json['earningsTrendMinor'] as List?)
              ?.map(ApiMoney.toMajor)
              .toList(growable: false) ??
          const [],
    );
  });

  // ---------------------------------------------------------- availability --

  @override
  Future<Availability> availability() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consoleAvailability,
    );
    return _toAvailability(asJsonMap(response));
  });

  @override
  Future<Availability> saveAvailability(Availability availability) =>
      guardApi(() async {
        final response = await _client.put<dynamic>(
          ApiEndpoints.consoleAvailability,
          data: {
            'weekly': _weeklyPayload(availability),
            'exceptions': availability.blackouts
                .map(
                  (b) => {
                    'date': _isoDate(b.date),
                    'unavailable': true,
                    if (b.reason.isNotEmpty) 'reason': b.reason,
                  },
                )
                .toList(),
            'autoAccept': false,
            'maxQueueLength': 10,
            'bufferMinutes': availability.bufferMinutes,
          },
        );
        return _toAvailability(asJsonMap(response));
      });

  @override
  Future<Availability> setOnline({required bool online}) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consoleOnline,
      data: {'online': online},
    );
    return _toAvailability(asJsonMap(response));
  });

  // --------------------------------------------------------------- queue ----

  @override
  Future<List<QueueEntry>> queue() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consoleQueue);
    return asJsonList(response).map(_toQueueEntry).toList(growable: false);
  });

  @override
  Future<IncomingRequest?> pendingRequest() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consolePendingRequest,
    );
    // Nothing ringing is the normal state, and the endpoint says so with a
    // null body rather than a 404.
    if (response.data == null) return null;
    final json = asJsonMap(response);

    final offeredAt = DateTime.now().subtract(
      Duration(seconds: _int(json['waitingSeconds'])),
    );
    final expiresAt = ApiTime.instant(json['expiresAt']);

    return IncomingRequest(
      entry: QueueEntry(
        // The consultation id is what `respondToRequest` needs back.
        id: json['consultationId'] as String? ?? '',
        seekerName: json['seekerName'] as String? ?? '',
        channel: ConsultChannel.fromName(json['channel'] as String?),
        joinedAt: offeredAt,
        seekerAvatar: json['seekerAvatar'] as String?,
        question: json['question'] as String? ?? '',
      ),
      offeredAt: offeredAt,
      timeoutSeconds: expiresAt == null
          ? 30
          : expiresAt.difference(offeredAt).inSeconds.clamp(5, 300),
    );
  });

  @override
  Future<void> respondToRequest({
    required String requestId,
    required bool accept,
  }) => guardApi(
    () => _client.post<dynamic>(
      ApiEndpoints.consoleRespondToRequest(requestId),
      data: {'accept': accept},
    ),
  );

  // -------------------------------------------------------------- clients ---

  @override
  Future<List<AstrologerClient>> clients() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consoleClients);
    return asJsonList(response).map(_toClient).toList(growable: false);
  });

  @override
  Future<AstrologerClient> client(String clientId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consoleClient(clientId),
    );
    return _toClient(asJsonMap(response));
  });

  @override
  Future<AstrologerClient> saveClientNotes({
    required String clientId,
    required String notes,
  }) => guardApi(() async {
    final response = await _client.put<dynamic>(
      ApiEndpoints.consoleClientNotes(clientId),
      data: {'notes': notes},
    );
    return _toClient(asJsonMap(response));
  });

  // --------------------------------------------------------- appointments --

  @override
  Future<List<ConsoleAppointment>> appointments(AppointmentScope scope) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.consoleAppointments,
          query: {'scope': scope.name},
        );
        return asJsonList(response).map(_toAppointment).toList(growable: false);
      });

  @override
  Future<ConsoleAppointment> appointment(String id) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consoleAppointment(id),
    );
    return _toAppointment(asJsonMap(response));
  });

  @override
  Future<ConsoleAppointment> recordAppointmentOutcome(
    String id, {
    required bool completed,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      completed
          ? ApiEndpoints.consoleAppointmentComplete(id)
          : ApiEndpoints.consoleAppointmentNoShow(id),
    );
    return _toAppointment(asJsonMap(response));
  });

  @override
  Future<ConsoleAppointment> cancelAppointment(
    String id, {
    required String reason,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consoleAppointmentCancel(id),
      data: {'reason': reason},
    );
    return _toAppointment(asJsonMap(response));
  });

  ConsoleAppointment _toAppointment(Map<String, dynamic> json) {
    Map<String, dynamic> map(Object? raw) =>
        raw is Map ? Map<String, dynamic>.from(raw) : const <String, dynamic>{};
    String? text(Object? raw) =>
        raw is String && raw.trim().isNotEmpty ? raw : null;
    final client = map(json['client']);
    final intake = map(json['intake']);
    final advice = map(json['advice']);
    final startsAt = ApiTime.instantOr(json['startsAt'], DateTime.now());
    return ConsoleAppointment(
      id: json['id'] as String? ?? '',
      reference: json['reference'] as String? ?? '',
      kind: json['kind'] == 'consultation'
          ? ConsoleAppointmentKind.consultation
          : ConsoleAppointmentKind.appointment,
      channel: text(json['channel']),
      status:
          ConsoleAppointmentStatus.values.asNameMap()[json['status']] ??
          ConsoleAppointmentStatus.pending,
      startsAt: startsAt,
      endsAt: ApiTime.instantOr(json['endsAt'], startsAt),
      price: ApiMoney.toMajor(json['priceMinor']),
      currency: json['currency'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      paymentMethod: text(json['paymentMethod']),
      clientId: client['id'] as String? ?? '',
      clientName: client['name'] as String? ?? '',
      clientPhone: client['phone'] as String? ?? '',
      clientEmail: client['email'] as String? ?? '',
      country: client['country'] as String? ?? '',
      birthDate: text(intake['birthDate']),
      birthTime: text(intake['birthTime']),
      birthPlace: text(intake['birthPlace']),
      note: json['note'] as String? ?? '',
      cancelReason: text(json['cancelReason']),
      hasBirthChart: json['hasBirthChart'] == true,
      hasReceipt: json['hasReceipt'] == true,
      birthChartUrl: text(json['birthChartUrl']),
      receiptUrl: text(json['receiptUrl']),
      adviceNotes: advice['notes'] as String? ?? '',
      remedies: _remedies(advice['remedies']),
      followUpAt: advice['followUpAt'] == null
          ? null
          : ApiTime.instantOr(advice['followUpAt'], DateTime.now()),
    );
  }

  /// The remedies the astrologer saved, however an older app wrote them.
  static List<Remedy> _remedies(Object? raw) {
    if (raw is! List) return const [];
    return [
      for (final item in raw.whereType<Map>())
        Remedy(
          kind:
              RemedyKind.values.asNameMap()[item['kind']] ??
              RemedyKind.practice,
          title: asLocalizedText(item['title']),
          description: asLocalizedText(item['description']),
          productId: item['productId'] as String?,
        ),
    ];
  }

  // ------------------------------------------------------------- earnings ---

  @override
  Future<EarningsSummary> earnings(EarningsRange range) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consoleEarnings,
      query: {'days': _daysIn(range)},
    );
    final json = asJsonMap(response);

    return EarningsSummary(
      entries: _list(json['entries'])
          .map(
            (e) => EarningEntry(
              id: e['id'] as String? ?? '',
              clientName: e['clientName'] as String? ?? '',
              channel: e['channel'] as String? ?? '',
              minutes: _int(e['minutes']),
              gross: ApiMoney.toMajor(e['grossMinor']),
              commission: ApiMoney.toMajor(e['commissionMinor']),
              occurredAt: ApiTime.instantOr(e['occurredAt'], DateTime.now()),
              settled: e['settled'] as bool? ?? false,
            ),
          )
          .toList(growable: false),
      // What is earned but not yet paid out, and what a payout could take
      // today — the server nets both off the ledger.
      pendingBalance:
          ApiMoney.toMajor(json['netMinor']) -
          ApiMoney.toMajor(json['availableMinor']),
      availableBalance: ApiMoney.toMajor(json['availableMinor']),
      range: range,
    );
  });

  @override
  Future<PerformanceMetrics> performance(EarningsRange range) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.consolePerformance,
          query: {'days': _daysIn(range)},
        );
        final json = asJsonMap(response);
        final completed = _int(json['completed']);

        return PerformanceMetrics(
          totalSessions: completed,
          totalMinutes: (completed * _double(json['averageSessionMinutes']))
              .round(),
          averageRating: _double(json['ratingAvg']),
          acceptanceRate: _double(json['acceptanceRate']),
          repeatRate: _double(json['repeatClientRate']),
          sessionsByChannel: {
            'completed': completed,
            'declined': _int(json['declined']),
            'missed': _int(json['missed']),
            'cancelled': _int(json['cancelled']),
          },
        );
      });

  // -------------------------------------------------------------- payouts ---

  @override
  Future<PayoutAccount?> payoutAccount() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consolePayoutAccount,
    );
    if (response.data == null) return null;
    final json = asJsonMap(response);

    return PayoutAccount(
      destination: switch (json['kind']) {
        'esewa' => PayoutDestination.esewa,
        'khalti' => PayoutDestination.khalti,
        'upi' => PayoutDestination.upi,
        _ => PayoutDestination.bankAccount,
      },
      // Only the masked number ever leaves the server; the account screen
      // shows exactly what the server is willing to say.
      identifier: json['accountNumberMasked'] as String? ?? '',
      holderName: json['accountName'] as String? ?? '',
      bankName: json['bankName'] as String? ?? '',
      verification: json['verified'] == true
          ? VerificationState.verified
          : VerificationState.pending,
    );
  });

  @override
  Future<PayoutAccount> savePayoutAccount(PayoutAccount account) =>
      guardApi(() async {
        final response = await _client.put<dynamic>(
          ApiEndpoints.consolePayoutAccount,
          data: {
            'kind': switch (account.destination) {
              PayoutDestination.bankAccount => 'bank',
              PayoutDestination.esewa => 'esewa',
              PayoutDestination.khalti => 'khalti',
              PayoutDestination.upi => 'upi',
            },
            'accountName': account.holderName,
            'accountNumber': account.identifier,
            'bankName': account.bankName,
          },
        );
        final saved = asJsonMap(response);
        return account.copyWith(
          identifier: saved['accountNumberMasked'] as String? ?? '',
          verification: saved['verified'] == true
              ? VerificationState.verified
              : VerificationState.pending,
        );
      });

  @override
  Future<List<PayoutRequest>> payouts() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consolePayouts);
    return asJsonList(response).map(_toPayout).toList(growable: false);
  });

  @override
  Future<PayoutRequest> requestPayout(double amount) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consolePayouts,
      data: {'amountMinor': ApiMoney.toMinorString(amount)},
    );
    return _toPayout(asJsonMap(response));
  });

  @override
  Future<List<TaxDocument>> taxDocuments() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consoleTaxDocuments,
    );
    return asJsonList(response)
        .map(
          (json) => TaxDocument(
            id: json['id'] as String? ?? '',
            title: json['label'] as String? ?? '',
            financialYear: '${json['year']}',
            amount: ApiMoney.toMajor(json['netMinor']),
            // A yearly statement is issued at the close of its year.
            issuedAt: DateTime(_int(json['year']) + 1),
          ),
        )
        .toList(growable: false);
  });

  // -------------------------------------------------------------- pricing ---

  @override
  Future<ConsolePricing> pricing() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consolePricing);
    return _toPricing(asJsonMap(response));
  });

  @override
  Future<ConsolePricing> savePricing(ConsolePricing pricing) =>
      guardApi(() async {
        final response = await _client.put<dynamic>(
          ApiEndpoints.consolePricing,
          // Every channel is sent, not only the priced ones. The server upserts
          // what it receives and leaves the rest alone, so omitting a channel
          // the astrologer had just switched off left its old row enabled —
          // they could raise a rate but never stop offering the channel.
          data: {
            for (final channel in ConsultChannel.values)
              channel.name: {
                'ratePerMinuteMinor': ApiMoney.toMinorString(
                  pricing.rateFor(channel) ?? 0,
                ),
                'enabled': (pricing.rateFor(channel) ?? 0) > 0,
              },
          },
        );
        return _toPricing(asJsonMap(response));
      });

  // -------------------------------------------------------------- reviews ---

  @override
  Future<List<AstrologerReview>> reviews() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consoleReviews);
    return asJsonList(response).map(_toReview).toList(growable: false);
  });

  @override
  Future<AstrologerReview> replyToReview({
    required String reviewId,
    required String reply,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.astrologerReviewReply(reviewId),
      data: {'reply': reply},
    );
    return _toReview(asJsonMap(response));
  });

  // --------------------------------------------------------------- boosts ---

  @override
  Future<List<BoostPlan>> boostPlans() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.boostPlans);
    return asJsonList(response)
        .map(
          (json) => BoostPlan(
            id: json['id'] as String? ?? '',
            placement: _placement(json['placement'] as String?),
            days: _int(json['days']),
            price: ApiMoney.toMajor(json['priceMinor']),
            estimatedImpressions: _int(json['estimatedImpressions']),
            popular: json['popular'] as bool? ?? false,
          ),
        )
        .toList(growable: false);
  });

  @override
  Future<List<BoostCampaign>> boostCampaigns() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consoleBoosts);
    return asJsonList(response)
        .map(
          (json) => BoostCampaign(
            id: json['id'] as String? ?? '',
            placement: _placement(json['placement'] as String?),
            startedAt: ApiTime.instantOr(json['startsAt'], DateTime.now()),
            endsAt: ApiTime.instantOr(json['endsAt'], DateTime.now()),
            spent: ApiMoney.toMajor(json['paidMinor']),
            // Impression and click counts are not instrumented yet; showing
            // zero is honest, showing an estimate would not be.
            impressions: _int(json['impressions']),
            profileViews: _int(json['profileViews']),
            consultations: _int(json['consultations']),
          ),
        )
        .toList(growable: false);
  });

  @override
  Future<BoostCampaign> buyBoost(String planId) => guardApi(() async {
    // The boost endpoint is shared with product boosts, so the target has to
    // be named. The astrologer id is not on the profile draft the console
    // edits, so it is read from the same profile payload.
    final profileResponse = await _client.get<dynamic>(
      ApiEndpoints.consoleProfile,
    );
    final astrologerId = asJsonMap(profileResponse)['id'] as String?;
    if (astrologerId == null) {
      throw const ServerException('Your astrologer profile is not set up yet');
    }

    final response = await _client.post<dynamic>(
      ApiEndpoints.boosts,
      data: {
        'planId': planId,
        'target': 'astrologer',
        'targetId': astrologerId,
      },
    );
    final json = asJsonMap(response);

    return BoostCampaign(
      id: json['campaignId'] as String? ?? '',
      placement: BoostPlacement.topOfList,
      startedAt: ApiTime.instantOr(json['startsAt'], DateTime.now()),
      endsAt: ApiTime.instantOr(json['endsAt'], DateTime.now()),
      spent: ApiMoney.toMajor(json['paidMinor']),
    );
  });

  // ----------------------------------------------------------- compliance ---

  @override
  Future<List<ComplianceNotice>> complianceNotices() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consoleCompliance);
    return asJsonList(response).map(_toNotice).toList(growable: false);
  });

  @override
  Future<ComplianceNotice> acknowledgeNotice(String id) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consoleComplianceAcknowledge(id),
    );
    return _toNotice(asJsonMap(response));
  });

  @override
  Future<ComplianceNotice> appealNotice(String id, String reason) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.consoleComplianceAppeal(id),
          data: {'reason': reason},
        );
        return _toNotice(asJsonMap(response));
      });

  // ------------------------------------------------------------ work prefs --

  @override
  Future<WorkPreferences> workPreferences() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consoleWorkPreferences,
    );
    return _toWorkPreferences(asJsonMap(response));
  });

  @override
  Future<WorkPreferences> saveWorkPreferences(WorkPreferences prefs) =>
      guardApi(() async {
        final response = await _client.put<dynamic>(
          ApiEndpoints.consoleWorkPreferences,
          data: {
            'acceptsChat': prefs.acceptsChannel(ConsultChannel.chat),
            'acceptsVoice': prefs.acceptsChannel(ConsultChannel.voice),
            'acceptsVideo': prefs.acceptsChannel(ConsultChannel.video),
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
            'autoDeclineAfterSeconds': prefs.autoDeclineAfterSeconds,
            'autoAcceptRepeatClients': prefs.autoAcceptRepeatClients,
            'maxQueueLength': prefs.maxQueueLength,
          },
        );
        return _toWorkPreferences(asJsonMap(response));
      });

  // -------------------------------------------------------------- profile ---

  @override
  Future<AstrologerProfileDraft> profile() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consoleProfile);
    return _toProfile(asJsonMap(response));
  });

  @override
  Future<AstrologerProfileDraft> saveProfile(AstrologerProfileDraft profile) =>
      guardApi(() async {
        final language = _languageCode();
        final response = await _client.put<dynamic>(
          ApiEndpoints.consoleProfile,
          data: {
            'name': {language: profile.displayName},
            'headline': {language: profile.headline},
            'about': {language: profile.about},
            'languageCodes': profile.languageCodes,
            'specialties': profile.specialties.map((s) => s.name).toList(),
            'experienceYears': profile.experienceYears,
            'avatarKey': profile.avatarRef,
            'introVideoKey': profile.introVideoRef,
            'hiddenFromSearch': profile.hiddenFromSearch,
          },
        );
        return _toProfile(asJsonMap(response));
      });

  // ---------------------------------------------------------------- mapping --

  AstrologerApplication _toApplication(Map<String, dynamic> json) {
    final documents = _map(json['documents']);
    final language = _languageCode();

    return AstrologerApplication(
      status: switch (json['status']) {
        'draft' => ApplicationStatus.draft,
        'submitted' => ApplicationStatus.submitted,
        'underReview' => ApplicationStatus.underReview,
        'approved' => ApplicationStatus.approved,
        'rejected' => ApplicationStatus.rejected,
        _ => ApplicationStatus.notStarted,
      },
      fullName: json['fullName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      ratePerMinute: _rates(json['ratePerMinute']),
      experienceYears: _int(json['experienceYears']),
      bio: localizedFor(json['about'], language),
      specialties:
          (json['specialties'] as List?)
              ?.whereType<String>()
              .map(Specialty.fromName)
              .toList(growable: false) ??
          const [],
      languageCodes:
          (json['languageCodes'] as List?)?.whereType<String>().toList() ??
          const [],
      // A document the server knows about has been uploaded; verification is
      // reported through the application's own status, not per file.
      documents: [
        for (final kind in KycDocumentKind.values)
          if (documents[_documentKind(kind)] != null)
            KycDocument(
              kind: kind,
              status: DocumentStatus.uploaded,
              fileRef: documents[_documentKind(kind)] as String?,
            ),
      ],
      termsAcceptedAt: ApiTime.instant(json['termsAcceptedAt']),
      termsVersion: json['termsVersion'] as String? ?? '',
      submittedAt: ApiTime.instant(json['submittedAt']),
      reviewerNote: json['decisionNote'] as String?,
    );
  }

  /// Requested rates, keyed by channel and quoted in minor units.
  ///
  /// The wizard will not let an application be submitted without these, so a
  /// mapping that dropped them would leave the submit button disabled with no
  /// visible reason — which is exactly what it did before.
  static Map<ConsultChannel, double> _rates(Object? raw) {
    if (raw is! Map) return const {};
    final rates = <ConsultChannel, double>{};
    for (final entry in raw.entries) {
      final amount = ApiMoney.toMajor(entry.value);
      if (amount > 0) rates[ConsultChannel.fromName('${entry.key}')] = amount;
    }
    return rates;
  }

  /// The server's name for a document slot.
  ///
  /// It calls the two identity images `idFront` / `idBack` where the app says
  /// `identityFront` / `identityBack`. Sending the app's name is rejected —
  /// and used to be rejected silently, so an uploaded document simply never
  /// appeared and the step could never be completed.
  static String _documentKind(KycDocumentKind kind) => switch (kind) {
    KycDocumentKind.identityFront => 'idFront',
    KycDocumentKind.identityBack => 'idBack',
    KycDocumentKind.selfie => 'selfie',
    KycDocumentKind.certificate => 'certificate',
    KycDocumentKind.addressProof => 'addressProof',
  };

  Availability _toAvailability(Map<String, dynamic> json) {
    final windows = <AvailabilityWindow>[];
    for (final day in _list(json['weekly'])) {
      final weekday = _int(day['weekday']);
      for (final window in _list(day['windows'])) {
        final from = _minuteOfDay(window['from'] as String?);
        final to = _minuteOfDay(window['to'] as String?);
        if (from == null || to == null) continue;
        windows.add(
          AvailabilityWindow(
            weekday: weekday,
            startMinute: from,
            endMinute: to,
            channels:
                (window['channels'] as List?)
                    ?.whereType<String>()
                    .map(ConsultChannel.fromName)
                    .toSet() ??
                const {},
          ),
        );
      }
    }

    return Availability(
      windows: windows,
      blackouts: _list(json['exceptions'])
          .where((e) => e['unavailable'] == true)
          .map(
            (e) => BlackoutDate(
              date: ApiTime.dateOr(e['date'], DateTime.now()),
              reason: e['reason'] as String? ?? '',
            ),
          )
          .toList(growable: false),
      isOnline: json['isOnline'] as bool? ?? false,
      bufferMinutes: _int(json['bufferMinutes']),
    );
  }

  List<Map<String, dynamic>> _weeklyPayload(Availability availability) {
    final byWeekday = <int, List<Map<String, dynamic>>>{};
    for (final window in availability.windows) {
      (byWeekday[window.weekday] ??= []).add({
        'from': _timeOfDay(window.startMinute),
        'to': _timeOfDay(window.endMinute),
        if (window.channels.isNotEmpty)
          'channels': window.channels.map((c) => c.name).toList(),
      });
    }
    return [
      for (final entry in byWeekday.entries)
        {'weekday': entry.key, 'windows': entry.value},
    ];
  }

  QueueEntry _toQueueEntry(Map<String, dynamic> json) => QueueEntry(
    id: json['id'] as String? ?? '',
    seekerName: json['seekerName'] as String? ?? '',
    channel: ConsultChannel.fromName(json['channel'] as String?),
    joinedAt: ApiTime.instantOr(json['enqueuedAt'], DateTime.now()),
    seekerAvatar: json['seekerAvatar'] as String?,
    question: json['question'] as String? ?? '',
    isRepeatClient: json['isRepeatClient'] as bool? ?? false,
    affordableMinutes: _int(json['affordableMinutes']),
  );

  AstrologerClient _toClient(Map<String, dynamic> json) => AstrologerClient(
    id: json['clientId'] as String? ?? '',
    name: json['clientName'] as String? ?? '',
    sessionCount: _int(json['sessionCount']),
    lifetimeValue: ApiMoney.toMajor(json['totalSpentMinor']),
    lastSessionAt: ApiTime.instantOr(json['lastSessionAt'], DateTime.now()),
    avatar: json['clientAvatar'] as String?,
    notes: json['notes'] as String? ?? '',
    averageRating: (json['averageRating'] as num?)?.toDouble(),
  );

  PayoutRequest _toPayout(Map<String, dynamic> json) => PayoutRequest(
    id: json['id'] as String? ?? '',
    amount: ApiMoney.toMajor(json['amountMinor']),
    status: switch (json['status']) {
      'processing' => PayoutStatus.processing,
      'paid' => PayoutStatus.paid,
      'failed' || 'rejected' => PayoutStatus.failed,
      _ => PayoutStatus.requested,
    },
    requestedAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    settledAt: ApiTime.instant(json['paidAt']),
    reference: json['reference'] as String?,
    failureReason: json['note'] as String?,
  );

  ConsolePricing _toPricing(Map<String, dynamic> json) {
    final channels = _map(json['channels']);
    final rates = <ConsultChannel, double>{};
    for (final entry in channels.entries) {
      final value = _map(entry.value);
      if (value['enabled'] == false) continue;
      rates[ConsultChannel.fromName(entry.key)] = ApiMoney.toMajor(
        value['ratePerMinuteMinor'],
      );
    }

    return ConsolePricing(
      ratePerMinute: rates,
      firstSessionRate: json['firstSessionRateMinor'] == null
          ? null
          : ApiMoney.toMajor(json['firstSessionRateMinor']),
      freeFirstMinutes: _int(json['freeFirstMinutes']),
      commissionRate: _double(json['commissionPercent']) / 100,
    );
  }

  AstrologerReview _toReview(Map<String, dynamic> json) => AstrologerReview(
    id: json['id'] as String? ?? '',
    // The console only ever lists this astrologer's own reviews, so the id is
    // implied by the endpoint rather than repeated per row.
    astrologerId: '',
    authorName: json['authorName'] as String? ?? '',
    rating: _int(json['rating']),
    comment: json['body'] as String? ?? '',
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    authorAvatar: json['authorAvatar'] as String?,
    reply: json['reply'] as String?,
  );

  ComplianceNotice _toNotice(Map<String, dynamic> json) {
    final language = _languageCode();
    final severity = switch (json['severity']) {
      'warning' => ComplianceSeverity.warning,
      'strike' => ComplianceSeverity.critical,
      _ => ComplianceSeverity.info,
    };

    return ComplianceNotice(
      id: json['id'] as String? ?? '',
      // The server grades notices by severity rather than by cause; the app's
      // finer kinds are a presentation concern, so an info notice reads as a
      // policy update and anything sterner as a quality warning.
      kind: severity == ComplianceSeverity.info
          ? ComplianceKind.policyUpdate
          : ComplianceKind.qualityWarning,
      severity: severity,
      title: localizedFor(json['title'], language),
      body: localizedFor(json['detail'], language),
      issuedAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
      status: json['appealedAt'] != null
          ? ComplianceStatus.appealed
          : json['acknowledgedAt'] != null
          ? ComplianceStatus.acknowledged
          : ComplianceStatus.open,
      acknowledgedAt: ApiTime.instant(json['acknowledgedAt']),
      appealReason: json['appealReason'] as String?,
      appealedAt: ApiTime.instant(json['appealedAt']),
    );
  }

  WorkPreferences _toWorkPreferences(Map<String, dynamic> json) {
    final channels = <ConsultChannel>{
      if (json['acceptsChat'] == true) ConsultChannel.chat,
      if (json['acceptsVoice'] == true) ConsultChannel.voice,
      if (json['acceptsVideo'] == true) ConsultChannel.video,
    };

    return WorkPreferences(
      newRequestAlerts: json['newRequestAlerts'] as bool? ?? true,
      alertSound: json['alertSound'] as bool? ?? true,
      ringUntilAnswered: json['ringUntilAnswered'] as bool? ?? true,
      scheduleReminders: json['scheduleReminders'] as bool? ?? true,
      payoutAlerts: json['payoutAlerts'] as bool? ?? true,
      reviewAlerts: json['reviewAlerts'] as bool? ?? true,
      marketingAlerts: json['marketingAlerts'] as bool? ?? false,
      quietHoursEnabled: json['quietHoursEnabled'] as bool? ?? false,
      quietStartMinute: _int(json['quietStartMinute']),
      quietEndMinute: _int(json['quietEndMinute']),
      acceptedChannels: channels,
      maxQueueLength: _int(json['maxQueueLength']),
      autoDeclineAfterSeconds: _int(json['autoDeclineAfterSeconds']),
      autoAcceptRepeatClients:
          json['autoAcceptRepeatClients'] as bool? ?? false,
    );
  }

  AstrologerProfileDraft _toProfile(Map<String, dynamic> json) {
    final language = _languageCode();
    return AstrologerProfileDraft(
      displayName: localizedFor(json['name'], language),
      headline: localizedFor(json['headline'], language),
      about: localizedFor(json['about'], language),
      specialties:
          (json['specialties'] as List?)
              ?.whereType<String>()
              .map(Specialty.fromName)
              .toList(growable: false) ??
          const [],
      languageCodes:
          (json['languageCodes'] as List?)?.whereType<String>().toList() ??
          const [],
      experienceYears: _int(json['experienceYears']),
      avatarRef: json['avatarKey'] as String?,
      introVideoRef: json['introVideoKey'] as String?,
      hiddenFromSearch: json['hiddenFromSearch'] as bool? ?? false,
    );
  }

  static BoostPlacement _placement(String? placement) => switch (placement) {
    'homeRail' => BoostPlacement.homeRail,
    'targeted' => BoostPlacement.targeted,
    _ => BoostPlacement.topOfList,
  };

  /// The console asks for a range; the API counts days.
  static int _daysIn(EarningsRange range) => switch (range) {
    EarningsRange.today => 1,
    EarningsRange.week => 7,
    EarningsRange.month => 30,
    EarningsRange.year => 365,
  };

  static int? _minuteOfDay(String? time) {
    final parts = (time ?? '').split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return hour * 60 + minute;
  }

  static String _timeOfDay(int minuteOfDay) =>
      '${(minuteOfDay ~/ 60).toString().padLeft(2, '0')}:'
      '${(minuteOfDay % 60).toString().padLeft(2, '0')}';

  static Map<String, dynamic> _map(Object? raw) =>
      raw is Map ? Map<String, dynamic>.from(raw) : const {};

  static List<Map<String, dynamic>> _list(Object? raw) => raw is List
      ? raw.whereType<Map>().map(Map<String, dynamic>.from).toList()
      : const [];

  static int _int(Object? raw) => (raw as num?)?.toInt() ?? 0;

  static double _double(Object? raw) => (raw as num?)?.toDouble() ?? 0;

  static String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
