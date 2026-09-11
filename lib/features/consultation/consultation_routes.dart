import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/session/permission.dart';
import '../../core/session/route_guard.dart';
import '../astrologers/domain/entities/consult_channel.dart';
import 'presentation/pages/astrologer_call_page.dart';
import 'presentation/pages/astrologer_console_page.dart';
import 'presentation/pages/consult_call_page.dart';
import 'presentation/pages/consult_chat_page.dart';
import 'presentation/pages/consult_intake_page.dart';
import 'presentation/pages/consult_queue_page.dart';
import 'presentation/pages/consult_summary_page.dart';
import 'presentation/pages/consultation_history_page.dart';
import 'presentation/pages/session_notes_page.dart';
import 'presentation/pages/transcript_page.dart';

/// Live consultation routes.
///
/// `/consult/history` is registered before `/consult/:id/...` so `history` is
/// not matched as a consultation id. Everything here needs a signed-in seeker
/// with a wallet, so the whole group is guarded.
final List<RouteBase> consultationRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.consultHistory,
    name: 'consultHistory',
    redirect: RouteGuard.require(
      Permission.bookConsultation,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => const ConsultationHistoryPage(),
  ),
  GoRoute(
    path: AppRoutes.consultIntake,
    name: 'consultIntake',
    redirect: RouteGuard.require(
      Permission.bookConsultation,
      fallback: AppRoutes.home,
    ),
    builder: (context, state) => ConsultIntakePage(
      astrologerId: state.pathParameters['astrologerId'] ?? '',
      channel: state.uri.queryParameters['channel'] == null
          ? null
          : ConsultChannel.fromName(state.uri.queryParameters['channel']),
    ),
  ),
  GoRoute(
    path: AppRoutes.consultQueue,
    name: 'consultQueue',
    builder: (context, state) =>
        ConsultQueuePage(consultationId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.consultChat,
    name: 'consultChat',
    builder: (context, state) =>
        ConsultChatPage(consultationId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.consultCall,
    name: 'consultCall',
    builder: (context, state) =>
        ConsultCallPage(consultationId: state.pathParameters['id'] ?? ''),
  ),
  // Astrologer side. Guarded on the console permission, so a seeker who
  // guesses the URL is sent to the application flow.
  GoRoute(
    path: AppRoutes.astrologerNotes,
    name: 'astrologerNotes',
    redirect: RouteGuard.require(
      Permission.viewAstrologerConsole,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) =>
        SessionNotesPage(consultationId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.astrologerCall,
    name: 'astrologerCall',
    redirect: RouteGuard.require(
      Permission.viewAstrologerConsole,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) =>
        AstrologerCallPage(consultationId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.astrologerSession,
    name: 'astrologerSession',
    redirect: RouteGuard.require(
      Permission.viewAstrologerConsole,
      fallback: AppRoutes.astrologerApply,
    ),
    builder: (context, state) =>
        AstrologerConsolePage(consultationId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.consultTranscript,
    name: 'consultTranscript',
    builder: (context, state) =>
        TranscriptPage(consultationId: state.pathParameters['id'] ?? ''),
  ),
  GoRoute(
    path: AppRoutes.consultSummary,
    name: 'consultSummary',
    builder: (context, state) =>
        ConsultSummaryPage(consultationId: state.pathParameters['id'] ?? ''),
  ),
];
