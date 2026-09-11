import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/entities/puja_service.dart';
import '../cubit/puja_booking_cubit.dart';
import '../l10n/puja_strings.dart';

/// One booked puja: the muhurta, the live link, and afterwards the recording
/// and prasad photos.
class PujaBookingPage extends StatelessWidget {
  const PujaBookingPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PujaBookingCubit>(param1: bookingId)..load(),
    child: const _BookingView(),
  );
}

class _BookingView extends StatelessWidget {
  const _BookingView();

  Future<void> _cancel(BuildContext context) async {
    final s = PujaStrings.of(context);
    final cubit = context.read<PujaBookingCubit>();
    final confirmed = await AppConfirmSheet.show(
      context,
      title: s.cancelConfirmTitle,
      message: s.cancelConfirmBody,
      confirmLabel: s.cancelBooking,
      cancelLabel: s.viewBooking,
    );
    if (!confirmed || !context.mounted) return;
    final ok = await cubit.cancel(s.cancelReasonHint);
    if (!context.mounted) return;
    if (!ok) AppSnack.error(context, cubit.state.actionError ?? s.cannotCancel);
  }

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<PujaBookingCubit, PujaBookingState>(
      builder: (context, state) {
        final cubit = context.read<PujaBookingCubit>();
        final booking = state.value;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: booking?.serviceName ?? s.pujas,
            showBack: true,
            // Booking replaced the details page, so there may be nothing
            // behind this screen to pop back to.
            onBack: () => context.canPop()
                ? context.pop()
                : context.go(AppRoutes.myPujas),
          ),
          body: SafeArea(
            top: false,
            child: switch (state.booking) {
              Idle() || Loading(previous: null) => const LoadingView(),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => _Body(
                booking: booking!,
                onCancel: () => _cancel(context),
                cancelling: state.cancelling,
              ),
            },
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.booking,
    required this.onCancel,
    required this.cancelling,
  });

  final PujaBooking booking;
  final VoidCallback onCancel;
  final bool cancelling;

  StatusTone get _tone => switch (booking.status) {
    PujaBookingStatus.pendingPayment => StatusTone.warning,
    PujaBookingStatus.confirmed => StatusTone.info,
    PujaBookingStatus.inProgress => StatusTone.accent,
    PujaBookingStatus.completed => StatusTone.success,
    PujaBookingStatus.cancelled => StatusTone.neutral,
  };

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;
    final dateFormat = DateFormat.yMMMMEEEEd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_jm();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.lg,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        Center(
          child: Column(
            children: [
              StatusChip(label: s.statusName(booking.status), tone: _tone),
              const SizedBox(height: AppSpacing.md),
              Text(
                dateFormat.format(booking.scheduledAt),
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        // The live link is the point of the screen while a puja is running,
        // so it sits above the details rather than below them.
        if (booking.canJoin)
          PrimaryButton(
            label: s.joinLive,
            icon: const Icon(Icons.live_tv_rounded, size: 18),
            onPressed: () => AppSnack.show(context, s.recordingUnavailable),
          )
        else if (booking.mode == PujaMode.templeOnline && booking.isUpcoming)
          Text(
            s.streamOpensSoon,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          child: Column(
            children: [
              KeyValueRow(
                label: s.chooseMode,
                value: booking.mode == PujaMode.templeOnline
                    ? s.modeOnline
                    : s.modeAtHome,
              ),
              KeyValueRow(
                label: s.devoteeName,
                value: booking.sankalp.fullName,
              ),
              if (booking.sankalp.gotra.isNotEmpty)
                KeyValueRow(label: s.gotra, value: booking.sankalp.gotra),
              if (booking.priestName != null)
                KeyValueRow(label: s.priest, value: booking.priestName!),
              if (booking.address != null)
                KeyValueRow(label: s.addressTitle, value: booking.address!),
              if (booking.paymentRail != null)
                KeyValueRow(
                  label: s.paymentTitle,
                  value: s.railName(booking.paymentRail!),
                ),
              Divider(color: colors.divider),
              KeyValueRow(
                label: s.totalLabel,
                emphasised: true,
                valueWidget: MoneyText(
                  booking.amount,
                  style: context.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
        if (booking.isDelivered) ...[
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(title: s.prasadPhotos),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: booking.prasadPhotos.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, i) => Container(
                width: 96,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(Icons.photo_outlined, color: colors.textMuted),
              ),
            ),
          ),
          if (booking.recordingUrl != null) ...[
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              label: s.watchRecording,
              icon: Icon(
                Icons.play_circle_outline_rounded,
                size: 17,
                color: colors.accent,
              ),
              onPressed: () => AppSnack.show(context, s.recordingUnavailable),
            ),
          ],
        ],
        if (booking.cancellationReason != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            '${s.cancelled} · ${booking.cancellationReason}',
            style: context.textTheme.labelSmall?.copyWith(color: colors.error),
          ),
        ],
        if (booking.canCancel) ...[
          const SizedBox(height: AppSpacing.xl),
          SecondaryButton(
            label: s.cancelBooking,
            onPressed: cancelling ? null : onCancel,
          ),
        ],
      ],
    );
  }
}
