import 'package:freezed_annotation/freezed_annotation.dart';

part 'panchanga_detail.freezed.dart';

/// Generic label/value row of the expandable "थप जानकारी" tables
/// (दिनमान, उदयकालीन सूर्यस्पष्ट, अयनांश …).
@freezed
abstract class PanchangaDetail with _$PanchangaDetail {
  const PanchangaDetail._();

  const factory PanchangaDetail({
    required String labelNe,
    required String labelEn,

    /// Pre-formatted value with ASCII digits (localised in the UI).
    required String value,
  }) = _PanchangaDetail;

  String label({required bool nepali}) => nepali ? labelNe : labelEn;
}
