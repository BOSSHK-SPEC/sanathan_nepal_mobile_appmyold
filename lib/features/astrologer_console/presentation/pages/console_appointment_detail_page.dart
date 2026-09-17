import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/system/external_links.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../consultation/domain/entities/session_summary.dart';
import '../../domain/entities/console_appointment.dart';
import '../cubit/console_appointment_cubit.dart';
import '../l10n/console_strings.dart';
import '../widgets/console_appointment_format.dart';

/// One booked sitting: who it is with, what they told us, and closing it out.
class ConsoleAppointmentDetailPage extends StatelessWidget {
  const ConsoleAppointmentDetailPage({required this.appointmentId, super.key});

  final String appointmentId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        GetIt.I<ConsoleAppointmentCubit>(param1: appointmentId)..load(),
    child: const _DetailView(),
  );
}

class _DetailView extends StatelessWidget {
  const _DetailView();

  void _say(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<ConsoleAppointmentCubit, ConsoleAppointmentState>(
      listenWhen: (p, n) =>
          (n.lastAction != null && p.lastAction != n.lastAction) ||
          (n.actionFailure != null && p.actionFailure != n.actionFailure),
      listener: (context, state) {
        final failure = state.actionFailure;
        if (failure != null) {
          AppSnack.error(context, failure.message);
          return;
        }
        final message = switch (state.lastAction) {
          ConsoleAppointmentAction.completed => s.apptMarkedCompleted,
          ConsoleAppointmentAction.noShow => s.apptMarkedNoShow,
          ConsoleAppointmentAction.cancelled => s.apptCancelled,
          null => null,
        };
        if (message != null) _say(context, message);
      },
      builder: (context, state) {
        final cubit = context.read<ConsoleAppointmentCubit>();
        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.apptDetails, showBack: true),
          body: SafeArea(
            top: false,
            child: switch (state.appointment) {
              Idle() || Loading(previous: null) => const LoadingView(),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => RefreshIndicator(
                onRefresh: cubit.load,
                child: _Details(
                  appointment: state.appointment.dataOrNull!,
                  acting: state.acting,
                  onSay: (message) => _say(context, message),
                ),
              ),
            },
          ),
        );
      },
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    required this.appointment,
    required this.acting,
    required this.onSay,
  });

  final ConsoleAppointment appointment;
  final bool acting;
  final ValueChanged<String> onSay;

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final fmt = ConsoleAppointmentFormat.of(context);
    final colors = context.colors;
    final cubit = context.read<ConsoleAppointmentCubit>();
    final a = appointment;
    final now = DateTime.now();

    // The booking form takes the national number and prints the dial code
    // beside it, so a stored number often has none — which neither the
    // dialler abroad nor WhatsApp can use.
    final phone = a.clientPhone.trim().isEmpty
        ? ''
        : a.clientPhone.trim().startsWith('+')
        ? a.clientPhone.trim()
        : '${context.regionConfig.phonePrefix}${a.clientPhone.trim()}';

    Future<void> launch(Future<bool> Function() open) async {
      if (!await open()) onSay(s.apptCouldNotOpen);
    }

    Future<void> openFile(String? url) async {
      if (url == null) return onSay(s.apptFileUnavailable);
      await launch(() => ExternalLinks.website(url));
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.md,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        // --- Who and when
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      a.clientName.isEmpty ? a.reference : a.clientName,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  StatusChip(
                    label: s.apptStatus(a.status),
                    tone: consoleAppointmentTone(a.status),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                fmt.when(a.startsAt),
                style: context.textTheme.titleSmall?.copyWith(
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                a.isSession
                    ? s.apptChannel(a.channel)
                    : s.apptReference(a.reference),
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
              if (a.cancelReason != null) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colors.error.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(
                    a.cancelReason!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // --- Client
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: s.apptClient),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (phone.isNotEmpty)
                KeyValueRow(label: s.apptPhone, value: phone),
              if (a.clientEmail.isNotEmpty)
                KeyValueRow(label: s.apptEmail, value: a.clientEmail),
              if (a.country.isNotEmpty)
                KeyValueRow(label: s.apptCountry, value: a.country),
              if (phone.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            launch(() => ExternalLinks.call(phone)),
                        icon: const Icon(Icons.call_outlined, size: 18),
                        label: Text(s.apptCall),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            launch(() => ExternalLinks.whatsapp(phone)),
                        icon: const Icon(Icons.chat_outlined, size: 18),
                        label: Text(s.apptWhatsapp),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),

        // --- The sitting
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: s.apptSitting),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KeyValueRow(
                label: s.apptWhen,
                value: fmt.timeRange(a.startsAt, a.endsAt),
              ),
              if (a.isSession)
                KeyValueRow(label: s.apptType, value: s.apptChannel(a.channel)),
              KeyValueRow(
                label: s.apptLength,
                value: s.minutesLabel(fmt.number(a.length.inMinutes)),
              ),
              KeyValueRow(
                label: s.apptAmount,
                value: a.quantity > 1
                    ? '${fmt.money(a.price)} · '
                          '${s.apptSeats(fmt.number(a.quantity))}'
                    : fmt.money(a.price),
              ),
              if (a.paymentMethod != null)
                KeyValueRow(
                  label: s.apptPayment,
                  value: consolePaymentLabel(a.paymentMethod!),
                ),
            ],
          ),
        ),

        // --- Birth details
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: s.apptBirthDetails),
        AppCard(
          child: a.hasBirthDetails
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (a.birthDate != null)
                      KeyValueRow(
                        label: s.apptBirthDate,
                        value: fmt.birthDate(a.birthDate!),
                      ),
                    if (a.birthTime != null)
                      KeyValueRow(
                        label: s.apptBirthTime,
                        value: fmt.birthTime(a.birthTime!),
                      ),
                    if (a.birthPlace != null)
                      KeyValueRow(label: s.apptBirthPlace, value: a.birthPlace),
                  ],
                )
              : Text(
                  s.apptBirthMissing,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
        ),

        // --- What the client wrote
        if (a.note.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(title: s.apptClientNote),
          AppCard(
            child: Text(a.note.trim(), style: context.textTheme.bodyMedium),
          ),
        ],

        // --- What the astrologer advised
        if (a.hasAdvice) ...[
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(title: s.apptAdvice),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (a.adviceNotes.trim().isNotEmpty)
                  Text(
                    a.adviceNotes.trim(),
                    style: context.textTheme.bodyMedium,
                  ),
                for (final remedy in a.remedies) ...[
                  const SizedBox(height: AppSpacing.md),
                  _RemedyRow(remedy: remedy),
                ],
                if (a.followUpAt != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  KeyValueRow(
                    label: s.apptFollowUp,
                    value: fmt.day(a.followUpAt!),
                  ),
                ],
              ],
            ),
          ),
        ],

        // --- Attachments
        if (a.hasAttachments) ...[
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(title: s.apptAttachments),
          AppCard(
            child: Column(
              children: [
                if (a.hasBirthChart)
                  _AttachmentRow(
                    icon: Icons.auto_graph_rounded,
                    label: s.apptBirthChart,
                    action: s.apptOpenFile,
                    onOpen: () => openFile(a.birthChartUrl),
                  ),
                if (a.hasReceipt)
                  _AttachmentRow(
                    icon: Icons.receipt_long_outlined,
                    label: s.apptReceipt,
                    action: s.apptOpenFile,
                    onOpen: () => openFile(a.receiptUrl),
                  ),
              ],
            ),
          ),
        ],

        // --- Closing it out
        const SizedBox(height: AppSpacing.xl),
        if (a.canRecordOutcome(now)) ...[
          PrimaryButton(
            label: s.apptMarkCompleted,
            isLoading: acting,
            onPressed: acting ? null : cubit.complete,
          ),
          const SizedBox(height: AppSpacing.sm),
          SecondaryButton(
            label: s.apptMarkNoShow,
            onPressed: acting ? null : cubit.markNoShow,
          ),
        ] else if (a.status.isOpen)
          Text(
            s.apptOutcomeAfterStart,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
        if (a.canCancel(now)) ...[
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: acting
                ? null
                : () async {
                    final reason = await _CancelSheet.show(context);
                    if (reason != null) await cubit.cancel(reason);
                  },
            icon: Icon(Icons.event_busy_outlined, color: colors.error),
            label: Text(s.apptCancel, style: TextStyle(color: colors.error)),
          ),
        ],
      ],
    );
  }
}

/// One prescribed remedy, as the astrologer saved it.
class _RemedyRow extends StatelessWidget {
  const _RemedyRow({required this.remedy});

  final Remedy remedy;

  static IconData _icon(RemedyKind kind) => switch (kind) {
    RemedyKind.gemstone => Icons.diamond_outlined,
    RemedyKind.mantra => Icons.record_voice_over_outlined,
    RemedyKind.puja => Icons.local_fire_department_outlined,
    RemedyKind.donation => Icons.volunteer_activism_outlined,
    RemedyKind.fasting => Icons.no_food_outlined,
    RemedyKind.practice => Icons.self_improvement_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;
    final language = context.languageCode;
    final description = remedy.description.forLanguage(language);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(_icon(remedy.kind), size: 20, color: colors.primary),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                remedy.title.forLanguage(language),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (description.isNotEmpty)
                Text(
                  description,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        StatusChip(
          label: s.apptRemedyKind(remedy.kind),
          tone: StatusTone.neutral,
          dense: true,
        ),
      ],
    );
  }
}

class _AttachmentRow extends StatelessWidget {
  const _AttachmentRow({
    required this.icon,
    required this.label,
    required this.action,
    required this.onOpen,
  });

  final IconData icon;
  final String label;
  final String action;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: context.colors.icon),
      const SizedBox(width: AppSpacing.md),
      Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
      TextButton(onPressed: onOpen, child: Text(action)),
    ],
  );
}

/// Asks for the reason the client will read. Returns it, or null to keep
/// the appointment.
class _CancelSheet extends StatefulWidget {
  const _CancelSheet();

  static Future<String?> show(BuildContext context) =>
      AppBottomSheet.show<String>(
        context,
        builder: (_) => const _CancelSheet(),
      );

  @override
  State<_CancelSheet> createState() => _CancelSheetState();
}

class _CancelSheetState extends State<_CancelSheet> {
  final _reason = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _submit() {
    if (_form.currentState?.validate() ?? false) {
      Navigator.of(context).pop(_reason.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;
    return AppBottomSheet(
      title: s.apptCancelTitle,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                s.apptCancelBody,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _reason,
                hint: s.apptCancelReasonHint,
                maxLines: 3,
                validator: (value) => (value ?? '').trim().length < 3
                    ? s.apptCancelReasonTooShort
                    : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(label: s.apptConfirmCancel, onPressed: _submit),
              const SizedBox(height: AppSpacing.xs),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(s.apptKeep),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
