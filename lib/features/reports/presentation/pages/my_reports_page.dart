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
import '../cubit/my_reports_cubit.dart';
import '../l10n/report_strings.dart';
import '../widgets/report_kind_icon.dart';

/// Everything the buyer has paid for.
class MyReportsPage extends StatelessWidget {
  const MyReportsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<MyReportsCubit>()..load(),
    child: const _MyReportsView(),
  );
}

class _MyReportsView extends StatelessWidget {
  const _MyReportsView();

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.myReports, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<MyReportsCubit, MyReportsState>(
          builder: (context, state) {
            final cubit = context.read<MyReportsCubit>();
            return switch (state.reports) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.refresh,
              ),
              _ when state.isEmpty => EmptyViewWithBody(
                title: s.noReportsTitle,
                body: s.noReportsBody,
                icon: Icons.picture_as_pdf_outlined,
                actionLabel: s.browseReports,
                onAction: () => context.push(AppRoutes.reports),
              ),
              _ => RefreshIndicator(
                onRefresh: cubit.refresh,
                color: colors.accent,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.xxxl,
                  ),
                  itemCount: state.all.length,
                  itemBuilder: (context, i) => _ReportRow(report: state.all[i]),
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({required this.report});

  final PurchasedReport report;

  StatusTone get _tone => switch (report.status) {
    ReportStatus.generating => StatusTone.info,
    ReportStatus.ready => StatusTone.success,
    ReportStatus.failed => StatusTone.danger,
    ReportStatus.refunded => StatusTone.neutral,
  };

  @override
  Widget build(BuildContext context) {
    final s = ReportStrings.of(context);
    final colors = context.colors;
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        onTap: () => context.push(AppRoutes.reportDeliveryPath(report.id)),
        child: Row(
          children: [
            ReportKindIcon(kind: report.kind),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(report.title, style: context.textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    // Whose chart it is matters more than the price here:
                    // people buy the same report for several relatives.
                    '${report.profileName} · '
                    '${dateFormat.format(report.purchasedAt)}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            StatusChip(
              label: s.reportStatus(report.status),
              tone: _tone,
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
