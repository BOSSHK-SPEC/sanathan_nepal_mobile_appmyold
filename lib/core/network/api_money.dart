/// Money conversion between the wire format and the app's domain types.
///
/// The server keeps money as an **integer string in minor units** (paisa):
/// integers because floating point does not add up in a ledger, and strings
/// because JSON numbers lose precision above 2^53. The Flutter domain uses
/// `double` major units, which is what the formatters and widgets expect.
///
/// Both conversions live here so the rounding rule is stated once. Rounding at
/// the boundary is safe — a `double` holds far more precision than any balance
/// this app will carry — but doing it ad hoc in each data source is how two
/// screens end up disagreeing by a paisa.
abstract final class ApiMoney {
  const ApiMoney._();

  /// Minor units per major unit. Both NPR and INR use 100.
  static const int _scale = 100;

  /// `"250000"` → `2500.0`. Tolerates a number as well as a string, since not
  /// every endpoint is under our control.
  static double toMajor(Object? minor) {
    if (minor == null) return 0;
    if (minor is num) return minor / _scale;
    final parsed = int.tryParse(minor.toString());
    if (parsed != null) return parsed / _scale;
    // Some upstreams send a decimal already in major units.
    return double.tryParse(minor.toString()) ?? 0;
  }

  /// `2500.0` → `"250000"`. Rounds to the nearest paisa rather than
  /// truncating, so a price of 99.995 is charged as 100.00, not 99.99.
  static String toMinorString(double major) =>
      (major * _scale).round().toString();

  static int toMinor(double major) => (major * _scale).round();
}
