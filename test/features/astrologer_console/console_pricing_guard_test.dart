import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/console_pricing.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';

/// A rate is entered once and then quoted to every seeker, multiplied by the
/// length of a sitting. A stray zero is therefore not a small mistake, and it
/// is invisible at the point it is made — ₹1,000 a minute looks like a number
/// until it is shown as ₹30,000 for half an hour.
void main() {
  ConsolePricing withRate(double rate) => ConsolePricing(
    ratePerMinute: {ConsultChannel.chat: rate},
    freeFirstMinutes: 0,
    commissionRate: 0.2,
  );

  test('an ordinary rate saves', () {
    expect(withRate(20).isValid, isTrue);
    expect(withRate(ConsolePricing.maxRatePerMinute).isValid, isTrue);
  });

  test('a rate past the cap cannot be saved', () {
    expect(withRate(ConsolePricing.maxRatePerMinute + 1).isValid, isFalse);
    // The value that started this: ₹10,000/min quoted a seeker ₹3,00,000 for
    // a thirty-minute sitting.
    expect(withRate(10000).isValid, isFalse);
  });

  test('a free or negative rate is still refused', () {
    expect(withRate(0).isValid, isFalse);
    expect(withRate(-5).isValid, isFalse);
  });

  test('an empty price list is not a saveable state', () {
    expect(
      const ConsolePricing(
        ratePerMinute: {},
        freeFirstMinutes: 0,
        commissionRate: 0.2,
      ).isValid,
      isFalse,
    );
  });
}
