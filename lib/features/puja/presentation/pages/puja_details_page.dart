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
import '../cubit/book_puja_cubit.dart';
import '../l10n/puja_strings.dart';

/// One puja, and the whole booking on the same page.
///
/// A wizard was tempting, but every step here is a single choice and the
/// price moves with them — keeping the total visible while the devotee picks
/// mode, muhurta and samagri is worth more than paged progress.
class PujaDetailsPage extends StatelessWidget {
  const PujaDetailsPage({required this.serviceId, super.key});

  final String serviceId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<BookPujaCubit>(param1: serviceId)..load(),
    child: const _DetailsView(),
  );
}

class _DetailsView extends StatelessWidget {
  const _DetailsView();

  Future<void> _confirm(BuildContext context) async {
    final cubit = context.read<BookPujaCubit>();
    final booking = await cubit.confirm();
    if (!context.mounted) return;
    if (booking == null) {
      AppSnack.error(
        context,
        cubit.state.bookingError ?? PujaStrings.of(context).cannotCancel,
      );
      return;
    }
    context.pushReplacement(AppRoutes.pujaBookingPath(booking.id));
  }

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;
    final language = Localizations.localeOf(context).languageCode;

    return BlocBuilder<BookPujaCubit, BookPujaState>(
      builder: (context, state) {
        final cubit = context.read<BookPujaCubit>();
        final service = state.service.dataOrNull;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: service?.name.forLanguage(language) ?? s.pujas,
            showBack: true,
          ),
          body: SafeArea(
            top: false,
            child: switch (state.service) {
              Idle() || Loading(previous: null) => const LoadingView(),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => _BookingForm(service: service!, state: state),
            },
          ),
          bottomNavigationBar: service == null
              ? null
              : _ConfirmBar(state: state, onConfirm: () => _confirm(context)),
        );
      },
    );
  }
}

class _BookingForm extends StatelessWidget {
  const _BookingForm({required this.service, required this.state});

  final PujaService service;
  final BookPujaState state;

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<BookPujaCubit>();
    final language = Localizations.localeOf(context).languageCode;
    final config = context.regionConfig;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.md,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        Text(
          service.summary.forLanguage(language),
          style: context.textTheme.bodySmall?.copyWith(
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          child: Column(
            children: [
              KeyValueRow(
                label: s.duration,
                value: s.minutes(service.duration.inMinutes),
              ),
              if (service.templeName != null)
                KeyValueRow(
                  label: s.temple,
                  value: service.templeName!.forLanguage(language),
                ),
            ],
          ),
        ),
        if (service.procedure.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(title: s.procedureTitle),
          AppTimeline(
            // Every step is upcoming: this describes what will happen, not
            // where a booking has got to.
            steps: [
              for (final step in service.procedure)
                TimelineStep(
                  title: step.forLanguage(language),
                  state: TimelineStepState.pending,
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: s.chooseMode),
        for (final mode in service.modes)
          _ChoiceTile(
            title: mode == PujaMode.templeOnline ? s.modeOnline : s.modeAtHome,
            subtitle: mode == PujaMode.templeOnline
                ? s.modeOnlineNote
                : s.modeAtHomeNote,
            trailing: mode == PujaMode.atHome && service.atHomeSurcharge > 0
                ? MoneyText(
                    service.atHomeSurcharge,
                    signed: true,
                    style: context.textTheme.labelSmall,
                    color: colors.textMuted,
                  )
                : null,
            selected: state.mode == mode,
            onTap: () => cubit.selectMode(mode),
          ),
        if (state.needsAddress) ...[
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(title: s.addressTitle),
          AppTextField(
            hint: s.addressHint,
            maxLines: 3,
            onChanged: cubit.setAddress,
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: s.chooseDate),
        _DateStrip(selected: state.date, onSelected: cubit.selectDate),
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: s.chooseMuhurta),
        switch (state.times) {
          Idle() || Loading(previous: null) => const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          ),
          _ when state.slots.isEmpty => EmptyViewWithBody(
            title: s.noMuhurtaTitle,
            body: s.noMuhurtaBody,
            icon: Icons.schedule_rounded,
          ),
          _ => Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final slot in state.slots)
                ChoiceChip(
                  label: Text(TimeOfDay.fromDateTime(slot).format(context)),
                  selected: state.selectedTime == slot,
                  onSelected: (_) => cubit.selectTime(slot),
                ),
            ],
          ),
        },
        if (service.includesSamagriOption) ...[
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(title: s.samagriTitle),
          AppCard(
            child: ToggleRow(
              label: state.withSamagri ? s.includeSamagri : s.iHaveSamagri,
              note: s.samagriNote,
              value: state.withSamagri,
              onChanged: cubit.setSamagri,
              trailing: MoneyText(
                service.samagriPrice,
                style: context.textTheme.labelMedium,
              ),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: s.sankalpTitle),
        Text(
          s.sankalpNote,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _SankalpFields(sankalp: state.sankalp, onChanged: cubit.setSankalp),
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: s.paymentTitle),
        for (final rail in config.paymentRails)
          _ChoiceTile(
            title: s.railName(rail),
            selected: state.rail == rail,
            onTap: () => cubit.selectRail(rail),
          ),
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: s.summaryTitle),
        AppCard(
          child: Column(
            children: [
              KeyValueRow(
                label: s.basePriceLabel,
                valueWidget: MoneyText(service.basePrice),
              ),
              if (state.withSamagri)
                KeyValueRow(
                  label: s.samagriLabel,
                  valueWidget: MoneyText(service.samagriPrice),
                ),
              if (state.mode == PujaMode.atHome && service.atHomeSurcharge > 0)
                KeyValueRow(
                  label: s.travelLabel,
                  valueWidget: MoneyText(service.atHomeSurcharge),
                ),
              Divider(color: colors.divider),
              KeyValueRow(
                label: s.totalLabel,
                emphasised: true,
                valueWidget: MoneyText(
                  state.total,
                  style: context.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SankalpFields extends StatelessWidget {
  const _SankalpFields({required this.sankalp, required this.onChanged});

  final SankalpDetails sankalp;
  final ValueChanged<SankalpDetails> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    return Column(
      children: [
        AppTextField(
          label: s.devoteeName,
          required: true,
          onChanged: (v) => onChanged(sankalp.copyWith(fullName: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          label: s.gotra,
          hint: s.gotraOptional,
          onChanged: (v) => onChanged(sankalp.copyWith(gotra: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          label: s.rashiNakshatra,
          onChanged: (v) => onChanged(sankalp.copyWith(rashiOrNakshatra: v)),
        ),
      ],
    );
  }
}

/// Two weeks of dates. A full calendar would be more screen than the choice
/// deserves — pujas are booked days ahead, not months.
class _DateStrip extends StatelessWidget {
  const _DateStrip({required this.selected, required this.onSelected});

  final DateTime selected;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final today = DateTime.now();
    final dayFormat = DateFormat.E(
      Localizations.localeOf(context).toLanguageTag(),
    );

    return SizedBox(
      height: 62,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final date = DateTime(today.year, today.month, today.day + i + 1);
          final isSelected =
              date.year == selected.year &&
              date.month == selected.month &&
              date.day == selected.day;
          return InkWell(
            onTap: () => onSelected(date),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Container(
              width: 54,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: isSelected ? colors.chipSelected : colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: isSelected ? colors.accent : colors.border,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayFormat.format(date),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  Text(
                    '${date.day}',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: isSelected ? colors.accent : colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected ? colors.chipSelected : colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: selected ? colors.accent : colors.border),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 18,
                color: selected ? colors.accent : colors.textMuted,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.textTheme.bodyMedium),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmBar extends StatelessWidget {
  const _ConfirmBar({required this.state, required this.onConfirm});

  final BookPujaState state;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.pageGutter),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  s.totalLabel,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                MoneyText(state.total, style: context.textTheme.titleMedium),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: PrimaryButton(
                label: s.confirmBooking,
                isLoading: state.booking.isLoading,
                onPressed: state.canConfirm ? onConfirm : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
