import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../core/calendar/traditional_calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/article.dart';

/// Formatting helpers shared by the content widgets.
abstract final class ArticleFormat {
  /// Resolves the effective content language code: an explicit reader
  /// choice wins, otherwise the app locale.
  static String languageCode(BuildContext context, ContentLanguage? language) =>
      language?.code ?? context.languageCode;

  /// Whether digits render in Devanagari for the effective content language
  /// (follows `context.usesDevanagariDigits` when no explicit choice is made).
  static bool devanagari(BuildContext context, ContentLanguage? language) =>
      language == null
      ? context.usesDevanagariDigits
      : TraditionalCalendar.devanagariDigits(language.code);

  /// "April 22, 2023" (English) or the region's traditional-calendar date in
  /// Devanagari for Nepali / Hindi – e.g. "वैशाख ९, २०८०" (Bikram Sambat) or
  /// "वैशाख २, १९४५" (Saka).
  static String date(
    DateTime date, {
    required String languageCode,
    required TraditionalCalendar calendar,
  }) {
    if (!TraditionalCalendar.devanagariDigits(languageCode)) {
      return DateFormat('MMMM d, yyyy').format(date);
    }
    final t = calendar.fromGregorian(date);
    final month = calendar.monthName(t.month, languageCode: languageCode);
    final day = '${t.day}'.toDevanagariDigits();
    final year = '${t.year}'.toDevanagariDigits();
    return '$month $day, $year';
  }

  /// "3 min read" / "३ मिनेट पढाइ".
  static String readTime(
    int minutes,
    String suffix, {
    required bool devanagari,
  }) {
    final n = devanagari ? '$minutes'.toDevanagariDigits() : '$minutes';
    return '$n $suffix';
  }

  /// Digits localised for like counters etc.
  static String number(int n, {required bool devanagari}) =>
      devanagari ? '$n'.toDevanagariDigits() : '$n';
}
