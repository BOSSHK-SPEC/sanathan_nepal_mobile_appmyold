import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/system/external_links.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/payment_intent.dart';
import '../cubit/payment_status_cubit.dart';
import '../l10n/wallet_strings.dart';

/// Outcome of one payment attempt.
///
/// Three real states, not two: succeeded, failed, and still-confirming.
/// Treating "not yet succeeded" as failure is how apps in this category
/// lose money that has actually left the customer's account.
class PaymentStatusPage extends StatelessWidget {
  const PaymentStatusPage({required this.intentId, super.key});

  final String intentId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PaymentStatusCubit>(param1: intentId)..start(),
    child: const _PaymentStatusView(),
  );
}

class _PaymentStatusView extends StatelessWidget {
  const _PaymentStatusView();

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<PaymentStatusCubit, PaymentStatusState>(
      builder: (context, state) {
        final cubit = context.read<PaymentStatusCubit>();
        final payment = state.payment;

        return PopScope(
          // Leaving mid-confirmation is fine — the wallet reflects the
          // outcome whenever it settles — but the back arrow must not drop
          // the user onto the method picker they just left.
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) context.go(AppRoutes.wallet);
          },
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppTopBar(
              title: s.paymentStatus,
              leading: IconButton(
                icon: Icon(Icons.close_rounded, color: colors.icon),
                onPressed: () => context.go(AppRoutes.wallet),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.pageGutter),
                child: Column(
                  children: [
                    const Spacer(),
                    if (state.isSucceeded)
                      _Outcome(
                        icon: Icons.check_circle_rounded,
                        tint: colors.success,
                        title: s.paymentSuccessTitle,
                        body: s.paymentSuccessBody,
                        payment: payment,
                      )
                    else if (state.isFailed)
                      _Outcome(
                        icon: Icons.error_rounded,
                        tint: colors.error,
                        title: s.paymentFailedTitle,
                        body:
                            payment?.failureReason ??
                            context.l10n.somethingWentWrong,
                        payment: payment,
                      )
                    else if (state.isSlow)
                      _Outcome(
                        icon: Icons.hourglass_bottom_rounded,
                        tint: colors.warning,
                        title: s.takingLongerTitle,
                        body: s.takingLongerBody,
                        payment: payment,
                      )
                    else
                      _Processing(
                        strings: s,
                        checkoutUrl: payment?.checkoutUrl,
                      ),
                    const Spacer(),
                    if (state.isSucceeded)
                      PrimaryButton(
                        label: s.backToWallet,
                        height: 46,
                        onPressed: () => context.go(AppRoutes.wallet),
                      )
                    else if (state.isFailed) ...[
                      PrimaryButton(
                        label: s.tryAgain,
                        height: 46,
                        onPressed: () =>
                            context.pushReplacement(AppRoutes.walletTopUp),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: s.backToWallet,
                        onPressed: () => context.go(AppRoutes.wallet),
                      ),
                    ] else if (!state.isSucceeded &&
                        payment?.checkoutUrl != null &&
                        !state.isSlow) ...[
                      PrimaryButton(
                        label: s.completePayment,
                        height: 46,
                        onPressed: () =>
                            ExternalLinks.website(payment!.checkoutUrl!),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: s.backToWallet,
                        onPressed: () => context.go(AppRoutes.wallet),
                      ),
                    ] else if (state.isSlow) ...[
                      PrimaryButton(
                        label: s.checkAgain,
                        height: 46,
                        onPressed: cubit.checkAgain,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: s.backToWallet,
                        onPressed: () => context.go(AppRoutes.wallet),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Processing extends StatefulWidget {
  const _Processing({required this.strings, this.checkoutUrl});

  final WalletStrings strings;

  /// Where the payer completes the payment, when the rail has a hosted page.
  final String? checkoutUrl;

  @override
  State<_Processing> createState() => _ProcessingState();
}

class _ProcessingState extends State<_Processing> {
  @override
  void initState() {
    super.initState();
    // Opened once, on arrival: the payment cannot progress until the payer has
    // actually been somewhere to pay, and this screen used to poll a gateway
    // nobody had been sent to. Once only — reopening on every rebuild would
    // fight the browser the payer is already typing a card into.
    final url = widget.checkoutUrl;
    if (url != null && url.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(ExternalLinks.website(url));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: colors.accent,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(widget.strings.processing, style: context.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          // A payer sent to a hosted page needs telling that the app is
          // waiting on them, not on the network.
          widget.checkoutUrl == null || widget.checkoutUrl!.isEmpty
              ? widget.strings.processingBody
              : widget.strings.completePaymentHint,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _Outcome extends StatelessWidget {
  const _Outcome({
    required this.icon,
    required this.tint,
    required this.title,
    required this.body,
    this.payment,
  });

  final IconData icon;
  final Color tint;
  final String title;
  final String body;
  final PaymentIntent? payment;

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;

    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tint.withValues(alpha: 0.12),
          ),
          child: Icon(icon, size: 36, color: tint),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.displaySmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          body,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.textMuted,
          ),
        ),
        if (payment != null) ...[
          const SizedBox(height: AppSpacing.xl),
          AppCard(
            child: KeyValueList(
              divided: true,
              children: [
                KeyValueRow(
                  label: s.amountAdded,
                  valueWidget: MoneyText(
                    payment!.credited,
                    style: context.textTheme.titleSmall,
                  ),
                  emphasised: true,
                ),
                KeyValueRow(
                  label: s.paymentMethod,
                  value: s.railName(payment!.rail),
                ),
                if (payment!.gatewayReference != null)
                  KeyValueRow(
                    label: s.reference,
                    value: payment!.gatewayReference!,
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
