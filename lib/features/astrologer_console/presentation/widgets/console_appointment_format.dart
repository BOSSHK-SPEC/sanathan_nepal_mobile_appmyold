import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../domain/entities/console_appointment.dart';

/// Dates, times and money on the appointment screens, in the reader's
/// language — with Devanagari digits for Nepali and Hindi.
///
/// Falls back to English date words when a locale's date data is not loaded,
/// rather than throwing while the screen builds.
class ConsoleAppointmentFormat {
  ConsoleAppointmentFormat.of(BuildContext context)
    : _context = context,
      _locale =
          Intl.verifiedLocale(
            context.languageCode,
            DateFormat.localeExists,
            onFailure: (_) => 'en',
          ) ??
          'en',
      _devanagari = context.usesDevanagariDigits;

  final BuildContext _context;
  final String _locale;
  final bool _devanagari;

  String _digits(String value) =>
      _devanagari ? value.toDevanagariDigits() : value;

  String number(int value) => _digits('$value');

  /// "Fri, Sep 18 · 4:55 PM"
  String when(DateTime at) => _digits(
    '${DateFormat.MMMEd(_locale).format(at)} · '
    '${DateFormat.jm(_locale).format(at)}',
  );

  /// "4:55 PM – 5:25 PM"
  String timeRange(DateTime from, DateTime to) => _digits(
    '${DateFormat.jm(_locale).format(from)} – '
    '${DateFormat.jm(_locale).format(to)}',
  );

  /// "Fri, Sep 18"
  String day(DateTime at) => _digits(DateFormat.MMMEd(_locale).format(at));

  /// "18"
  String dayOfMonth(DateTime at) => _digits(DateFormat.d(_locale).format(at));

  /// "Sep"
  String month(DateTime at) => DateFormat.MMM(_locale).format(at);

  String money(double amount) => RegionFormat.money(
    amount,
    config: _context.regionConfig,
    languageCode: _context.languageCode,
  );

  /// A birth date as the client typed it (`YYYY-MM-DD`), or the raw text when
  /// it is not a date.
  String birthDate(String iso) {
    final parsed = DateTime.tryParse(iso);
    return parsed == null
        ? iso
        : _digits(DateFormat.yMMMd(_locale).format(parsed));
  }

  /// A birth time as the client typed it (`HH:mm`).
  String birthTime(String hhmm) {
    final parts = hhmm.split(':');
    final hour = int.tryParse(parts.first);
    final minute = parts.length > 1 ? int.tryParse(parts[1]) : 0;
    if (hour == null || minute == null) return hhmm;
    return _digits(
      DateFormat.jm(_locale).format(DateTime(2000, 1, 1, hour, minute)),
    );
  }
}

/// The colour a status reads in, the same on every appointment screen.
StatusTone consoleAppointmentTone(ConsoleAppointmentStatus status) =>
    switch (status) {
      ConsoleAppointmentStatus.pending => StatusTone.warning,
      ConsoleAppointmentStatus.confirmed => StatusTone.info,
      ConsoleAppointmentStatus.completed => StatusTone.success,
      ConsoleAppointmentStatus.cancelled => StatusTone.danger,
      ConsoleAppointmentStatus.noShow => StatusTone.warning,
      ConsoleAppointmentStatus.rescheduled => StatusTone.neutral,
      // Live sessions: nobody answered, or the astrologer turned it down.
      ConsoleAppointmentStatus.missed => StatusTone.warning,
      ConsoleAppointmentStatus.declined => StatusTone.neutral,
    };

/// Payment rails by their own names — brand names are not translated.
String consolePaymentLabel(String method) => switch (method) {
  'esewa' => 'eSewa',
  'khalti' => 'Khalti',
  'upi' => 'UPI',
  'card' => 'Card',
  'netBanking' => 'Net banking',
  'bankTransfer' => 'Bank transfer',
  'cashOnDelivery' => 'Cash',
  'wallet' => 'Wallet',
  _ => method,
};
