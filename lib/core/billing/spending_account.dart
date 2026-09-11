/// What a feature needs from the wallet in order to charge for something.
///
/// Consultations, paid reports and orders all spend money, but none of them
/// should import the wallet feature to do it. The contract lives in core and
/// the wallet provides the implementation — the same inversion `SessionSource`
/// and `RegionResolver` use.
///
/// Affordability is decided by the implementation, not by the caller: a
/// pre-check followed by a charge is a race, so [charge] is expected to fail
/// when the balance is short.
abstract interface class SpendingAccount {
  /// Balance the user can spend right now, real plus promotional.
  Future<double> spendable();

  /// Charges the account. Throws when the balance is insufficient.
  Future<void> charge({
    required double amount,
    required SpendCategory category,
    required String description,
    String? referenceId,
  });
}

/// What the money was spent on, in terms core can express without knowing
/// about the wallet's own ledger categories.
enum SpendCategory { consultation, report, product }

/// Never-charges implementation for tests and previews.
class NoopSpendingAccount implements SpendingAccount {
  const NoopSpendingAccount({this.balance = 0});

  final double balance;

  @override
  Future<double> spendable() async => balance;

  @override
  Future<void> charge({
    required double amount,
    required SpendCategory category,
    required String description,
    String? referenceId,
  }) async {}
}
