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
import '../../domain/entities/purchased_report.dart';
import '../cubit/report_delivery_cubit.dart';
import '../l10n/report_strings.dart';
import '../widgets/report_kind_icon.dart';

/// One purchased report: waiting for it, then opening it.
///
/// The same screen covers both states rather than a "success" page that
/// hands off elsewhere — the buyer lands here from checkout and returns here
/// from the library, and both times the question is "is it ready".
class ReportDeliveryPage extends StatelessWidget {
  const ReportDeliveryPage({required this.reportId, super.key});

  final String reportId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ReportDeliveryCubit>(param1: reportId)..load(),
    child: const _DeliveryView(),
  );
}

class _DeliveryView extends StatelessWidget {
  const _DeliveryView();

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ReportDeliveryCubit, ReportDeliveryState>(
      builder: (context, state) {
        final cubit = context.read<ReportDeliveryCubit>();
        final report = state.report.dataOrNull;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: report?.title ?? s.reports,
            showBack: true,
            // Checkout replaced the product page, so there may be nothing
            // behind this screen to pop back to.
            onBack: () => context.canPop()
                ? context.pop()
                : context.go(AppRoutes.myReports),
          ),
          body: SafeArea(
            top: false,
            child: switch (state.report) {
              Idle() || Loading(previous: null) => const LoadingView(),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => _Body(report: report!),
            },
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.report});

  final PurchasedReport report;

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_jm();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.xl,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      children: [
        Center(
          child: Column(
            children: [
              if (report.isGenerating)
                SizedBox(
                  height: 64,
                  width: 64,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: colors.accent,
                  ),
                )
              else
                ReportKindIcon(kind: report.kind, size: 64),
              const SizedBox(height: AppSpacing.lg),
              Text(
                switch (report.status) {
                  ReportStatus.generating => s.generatingTitle,
                  ReportStatus.ready => s.readyTitle,
                  ReportStatus.failed => s.failedTitle,
                  ReportStatus.refunded => s.reportStatus(report.status),
                },
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
              if (report.isGenerating) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  s.generatingBody,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
              if (report.failureReason != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  report.failureReason!,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.error,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppCard(
          child: Column(
            children: [
              KeyValueRow(label: s.forWhom, value: report.profileName),
              if (report.partnerName != null)
                KeyValueRow(
                  label: s.partnerProfile,
                  value: report.partnerName!,
                ),
              KeyValueRow(
                label: s.purchasedOn,
                value: dateFormat.format(report.purchasedAt),
              ),
              KeyValueRow(
                label: s.amountPaid,
                valueWidget: MoneyText(
                  report.pricePaid,
                  style: context.textTheme.labelLarge,
                ),
              ),
              if (report.pageCount != null)
                KeyValueRow(
                  label: s.pages,
                  value: s.pageCount(report.pageCount!),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        if (report.isReady)
          PrimaryButton(
            label: s.downloadPdf,
            // No PDF viewer or file plugin is wired yet; saying so is
            // better than a button that appears to do nothing.
            onPressed: () => AppSnack.show(context, s.downloadUnavailable),
          ),
        if (report.isRefundable) ...[
          const SizedBox(height: AppSpacing.md),
          SecondaryButton(
            label: s.requestRefund,
            onPressed: () => context.push(AppRoutes.wallet),
          ),
        ],
      ],
    );
  }
}
