import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/refund_request.dart';
import '../cubit/refund_cubit.dart';
import '../l10n/wallet_strings.dart';

/// Dispute one transaction.
///
/// "Something else" requires an explanation; every other reason is specific
/// enough to act on, so the form does not force typing that adds nothing.
class RefundRequestPage extends StatefulWidget {
  const RefundRequestPage({required this.transactionId, super.key});

  final String transactionId;

  @override
  State<RefundRequestPage> createState() => _RefundRequestPageState();
}

class _RefundRequestPageState extends State<RefundRequestPage> {
  final TextEditingController _details = TextEditingController();

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<RefundCubit>(param1: widget.transactionId),
    child: BlocConsumer<RefundCubit, RefundState>(
      listenWhen: (p, n) => p.submission != n.submission,
      listener: (context, state) {
        final s = WalletStrings.of(context);
        if (state.isSubmitted) {
          AppSnack.success(context, s.refundSubmittedBody);
          // Deep links land here with nothing beneath, where pop() is a
          // no-op and would strand the user on a submitted form.
          if (context.canPop()) {
            context.pop(true);
          } else {
            context.go(AppRoutes.wallet);
          }
        } else if (state.submission.isFailed) {
          AppSnack.error(
            context,
            state.submission.errorMessage ?? context.l10n.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        final s = WalletStrings.of(context);
        final colors = context.colors;
        final cubit = context.read<RefundCubit>();

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.requestRefund, showBack: true),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Text(
                  s.refundSubtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(s.refundReason, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                for (final reason in RefundReason.values)
                  AppRadioOption<RefundReason?>(
                    value: reason,
                    groupValue: state.reason,
                    label: s.reasonName(reason),
                    onChanged: (v) => v == null ? null : cubit.selectReason(v),
                  ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _details,
                  label: s.refundDetails,
                  hint: s.refundDetailsHint,
                  required: state.reason == RefundReason.other,
                  maxLines: 5,
                  minLines: 3,
                  onChanged: cubit.setDetails,
                ),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: s.submitRefund,
                  height: 46,
                  isLoading: state.submission.isLoading,
                  onPressed: state.canSubmit ? cubit.submit : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                SecondaryButton(
                  label: s.cancel,
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
