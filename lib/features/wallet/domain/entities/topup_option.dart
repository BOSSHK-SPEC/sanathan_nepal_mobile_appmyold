import 'package:freezed_annotation/freezed_annotation.dart';

part 'topup_option.freezed.dart';

/// A preset top-up amount, optionally with bonus credit attached.
@freezed
abstract class TopUpOption with _$TopUpOption {
  const TopUpOption._();

  const factory TopUpOption({
    required double amount,

    /// Extra promotional credit granted on this tier.
    @Default(0) double bonus,

    /// Highlighted in the picker as the suggested tier.
    @Default(false) bool popular,
  }) = _TopUpOption;

  double get total => amount + bonus;

  bool get hasBonus => bonus > 0;

  int get bonusPercent => amount <= 0 ? 0 : ((bonus / amount) * 100).round();
}
