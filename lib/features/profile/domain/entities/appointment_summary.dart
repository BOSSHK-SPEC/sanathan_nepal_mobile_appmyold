import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_summary.freezed.dart';

/// Compact appointment shown in the profile ACTIVITIES tab.
@freezed
abstract class AppointmentSummary with _$AppointmentSummary {
  const factory AppointmentSummary({
    required String id,
    required String titleEn,
    required String titleNe,
    required String doctorName,
    required String serviceEn,
    required String serviceNe,
    required DateTime dateTime,
  }) = _AppointmentSummary;
}
