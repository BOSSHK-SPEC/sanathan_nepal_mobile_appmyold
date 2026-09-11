import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/payment_intent.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'payment_status_cubit.freezed.dart';
part 'payment_status_state.dart';

/// Polls a payment intent until it settles.
///
/// Gateways confirm asynchronously, so "not yet succeeded" is a legitimate
/// state to sit in rather than an error. Polling stops on settlement and at
/// [maxAttempts], after which the user is told it is taking longer than
/// usual instead of being left on a spinner forever.
class PaymentStatusCubit extends AppCubit<PaymentStatusState> {
  PaymentStatusCubit({
    required String intentId,
    required GetPaymentIntent getIntent,
  }) : _intentId = intentId,
       _getIntent = getIntent,
       super(const PaymentStatusState());

  final String _intentId;
  final GetPaymentIntent _getIntent;

  static const Duration pollInterval = Duration(seconds: 2);
  static const int maxAttempts = 15;

  Timer? _timer;

  Future<void> start() async {
    emit(state.copyWith(intent: state.intent.toLoading()));
    await _poll();
    _timer?.cancel();
    _timer = Timer.periodic(pollInterval, (_) => _poll());
  }

  Future<void> _poll() async {
    if (isClosed) return;
    final result = await _getIntent(_intentId);
    if (isClosed) return;

    final attempts = state.attempts + 1;
    result.fold(
      (failure) => emit(
        state.copyWith(
          intent: state.intent.toFailed(failure),
          attempts: attempts,
        ),
      ),
      (intent) => emit(
        state.copyWith(intent: LoadState.loaded(intent), attempts: attempts),
      ),
    );

    if (state.isSettled || attempts >= maxAttempts) _stop();
  }

  /// Manual retry from the "taking longer than usual" state.
  Future<void> checkAgain() async {
    emit(state.copyWith(attempts: 0));
    await start();
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _stop();
    return super.close();
  }
}
