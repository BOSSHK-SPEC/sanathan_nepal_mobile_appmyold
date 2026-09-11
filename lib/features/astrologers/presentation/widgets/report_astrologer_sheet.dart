import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer_review.dart';
import '../cubit/astrologer_profile_cubit.dart';
import '../l10n/astrologers_strings.dart';

/// Report / block flow. Required for store review on any app with
/// one-to-one communication between strangers.
class ReportAstrologerSheet extends StatefulWidget {
  const ReportAstrologerSheet({required this.astrologerId, super.key});

  final String astrologerId;

  static Future<bool> show(
    BuildContext context, {
    required String astrologerId,
  }) async {
    final cubit = context.read<AstrologerProfileCubit>();
    final result = await AppBottomSheet.show<bool>(
      context,
      builder: (_) => BlocProvider<AstrologerProfileCubit>.value(
        value: cubit,
        child: ReportAstrologerSheet(astrologerId: astrologerId),
      ),
    );
    return result ?? false;
  }

  @override
  State<ReportAstrologerSheet> createState() => _ReportAstrologerSheetState();
}

class _ReportAstrologerSheetState extends State<ReportAstrologerSheet> {
  ReportReason? _reason;
  bool _alsoBlock = false;
  bool _submitting = false;
  String? _error;
  final TextEditingController _details = TextEditingController();

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_reason == null) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    final ok = await context.read<AstrologerProfileCubit>().report(
      ReportDraft(
        astrologerId: widget.astrologerId,
        reason: _reason!,
        details: _details.text,
        alsoBlock: _alsoBlock,
      ),
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        _submitting = false;
        _error = context
            .read<AstrologerProfileCubit>()
            .state
            .reporting
            .errorMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return AppBottomSheet(
      title: s.reportTitle,
      subtitle: s.reportSubtitle,
      actions: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              label: s.cancel,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 2,
            child: PrimaryButton(
              label: s.submitReport,
              isLoading: _submitting,
              onPressed: _reason == null ? null : _submit,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final reason in ReportReason.values)
            AppRadioOption<ReportReason?>(
              value: reason,
              groupValue: _reason,
              label: s.reportReason(reason),
              onChanged: (v) => setState(() => _reason = v),
            ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _details,
            hint: s.reportDetailsHint,
            maxLines: 4,
            minLines: 3,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.error,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          LabeledToggle(
            label: s.alsoBlock,
            value: _alsoBlock,
            onChanged: (v) => setState(() => _alsoBlock = v),
          ),
        ],
      ),
    );
  }
}
