import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/compliance_notice.dart';
import '../cubit/compliance_cubit.dart';
import '../l10n/console_strings.dart';

/// Contesting a notice.
///
/// Presented over the list rather than as a route so the notice being
/// appealed stays visible behind it — the astrologer is writing *about* it.
class AppealSheet extends StatefulWidget {
  const AppealSheet({required this.notice, super.key});

  final ComplianceNotice notice;

  static Future<void> show(
    BuildContext context, {
    required ComplianceNotice notice,
  }) {
    final cubit = context.read<ComplianceCubit>();
    return AppBottomSheet.show<void>(
      context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: AppealSheet(notice: notice),
      ),
    );
  }

  @override
  State<AppealSheet> createState() => _AppealSheetState();
}

class _AppealSheetState extends State<AppealSheet> {
  final _reason = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final s = ConsoleStrings.of(context);
    final cubit = context.read<ComplianceCubit>();
    setState(() => _submitting = true);
    final ok = await cubit.appeal(widget.notice.id, _reason.text);
    if (!mounted) return;
    setState(() => _submitting = false);
    if (!ok) return;
    Navigator.of(context).pop();
    AppSnack.show(context, s.appealSubmitted);
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);

    return AppBottomSheet(
      title: s.appealTitle,
      subtitle: widget.notice.title,
      actions: PrimaryButton(
        label: s.submitAppeal,
        isLoading: _submitting,
        // The 20-character floor is the data source's rule; mirroring it
        // here keeps the button honest instead of failing after a tap.
        onPressed: _reason.text.trim().length >= 20 && !_submitting
            ? _submit
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.appealBody,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _reason,
            hint: s.appealReasonHint,
            maxLines: 5,
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }
}
