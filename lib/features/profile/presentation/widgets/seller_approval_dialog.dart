import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../l10n/profile_strings.dart';

/// "Seller Approval" confirmation dialog used by the admin moderation flow
/// (same shell as the DELETE POPUP): shield icon, title, message, an
/// optional reason field for rejections and Cancel + Approve/Reject buttons.
class SellerApprovalDialog extends StatefulWidget {
  const SellerApprovalDialog({required this.approve, super.key});

  /// `true` = approve variant, `false` = reject variant (with reason field).
  final bool approve;

  /// Shows the dialog. Resolves to the entered reason (may be empty) when
  /// confirmed, or `null` when cancelled.
  static Future<String?> show(BuildContext context, {required bool approve}) =>
      showDialog<String>(
        context: context,
        builder: (_) => SellerApprovalDialog(approve: approve),
      );

  @override
  State<SellerApprovalDialog> createState() => _SellerApprovalDialogState();
}

class _SellerApprovalDialogState extends State<SellerApprovalDialog> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ProfileStrings.of(context);
    final accent = widget.approve ? colors.success : colors.error;
    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xxl,
          AppSpacing.xl,
          AppSpacing.xl,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withValues(alpha: 0.12),
                ),
                child: Icon(
                  widget.approve
                      ? Icons.verified_user_outlined
                      : Icons.block_rounded,
                  color: accent,
                  size: 30,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                s.sellerApproval,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.approve ? s.approveMessage : s.rejectMessage,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              if (!widget.approve) ...[
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _reason,
                  label: s.rejectionReason,
                  maxLines: 2,
                ),
              ],
              const SizedBox(height: AppSpacing.xxl),
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: s.cancel,
                      height: 36,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: PrimaryButton(
                      label: widget.approve ? s.approve : s.reject,
                      height: 36,
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(_reason.text.trim()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
