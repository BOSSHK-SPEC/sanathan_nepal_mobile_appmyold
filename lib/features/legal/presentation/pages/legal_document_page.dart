import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/legal_document.dart';
import '../cubit/legal_cubit.dart';
import '../l10n/legal_strings.dart';
import '../widgets/legal_section_view.dart';

/// Scrollable legal document page (Privacy Policy `1265:2654`,
/// Terms & Conditions `1332:2744`).
class LegalDocumentPage extends StatelessWidget {
  const LegalDocumentPage({required this.type, super.key});

  final LegalDocumentType type;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<LegalCubit>()..load(type),
    child: _LegalDocumentView(type: type),
  );
}

class _LegalDocumentView extends StatelessWidget {
  const _LegalDocumentView({required this.type});

  final LegalDocumentType type;

  @override
  Widget build(BuildContext context) {
    final strings = LegalStrings.of(context);
    final fallbackTitle = type == LegalDocumentType.privacyPolicy
        ? strings.privacyPolicy
        : strings.termsConditions;
    return BlocBuilder<LegalCubit, LegalState>(
      builder: (context, state) {
        final doc = state.document.dataOrNull;
        final title = doc?.title.resolve(context.languageCode) ?? fallbackTitle;
        return Scaffold(
          appBar: AppTopBar(title: title, showBack: true),
          body: switch (state.document) {
            Idle() || Loading() => const LoadingView(),
            Failed(:final failure) => ErrorView(
              message: failure.message,
              onRetry: () => context.read<LegalCubit>().load(type),
            ),
            Loaded(:final data) => _DocumentBody(document: data),
          },
        );
      },
    );
  }
}

class _DocumentBody extends StatelessWidget {
  const _DocumentBody({required this.document});

  final LegalDocument document;

  /// Nepali/Hindi: the region's traditional calendar (BS / Saka) with
  /// Devanagari digits; English: Gregorian.
  String _formatDate(BuildContext context, DateTime date) {
    if (context.usesDevanagariDigits) {
      final calendar = context.traditionalCalendar;
      final t = calendar.fromGregorian(date);
      final month = calendar.monthName(
        t.month,
        languageCode: context.languageCode,
      );
      return '$month ${t.day}, ${t.year}'.toDevanagariDigits();
    }
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final strings = LegalStrings.of(context);
    final textTheme = context.textTheme;
    final colors = context.colors;
    final isPrivacy = document.type == LegalDocumentType.privacyPolicy;
    final dateLabel = _formatDate(context, document.lastUpdated);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        18,
        AppSpacing.lg,
        18,
        AppSpacing.xxxl,
      ),
      children: [
        // Privacy policy shows the date at the top, T&C at the bottom.
        if (isPrivacy) ...[
          Text(
            '${strings.lastUpdated}: $dateLabel',
            style: textTheme.titleSmall?.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        Text(
          document.intro.resolve(context.languageCode),
          textAlign: TextAlign.justify,
          style: textTheme.bodyMedium?.copyWith(
            height: 1.55,
            color: colors.textSecondary,
          ),
        ),
        for (final section in document.sections)
          LegalSectionView(section: section),
        if (!isPrivacy) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(
            '${strings.documentLastUpdated} $dateLabel',
            style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
          ),
        ],
      ],
    );
  }
}
