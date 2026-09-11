import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/appointment.dart';
import '../../../../core/utils/localized_text_model.dart';
import 'sitting_option_model.dart';
import 'time_slot_model.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

/// JSON-serialisable [Appointment]. Enums travel by their `code`
/// (`booked`, `esewa`, `net_banking`, …); unknown codes fall back to
/// `booked` / `esewa` like [AppointmentStatus.fromCode] and
/// [PaymentMethod.fromCode].
@freezed
abstract class AppointmentModel with _$AppointmentModel {
  const AppointmentModel._();

  const factory AppointmentModel({
    required String id,
    required String astrologerId,
    required LocalizedTextModel astrologerName,
    required SittingOptionModel service,
    @Default(1) int quantity,
    required DateTime date,
    required TimeSlotModel slot,
    @JsonKey(unknownEnumValue: AppointmentStatus.booked)
    @Default(AppointmentStatus.booked)
    AppointmentStatus status,
    @Default('') String customerName,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String country,
    @JsonKey(unknownEnumValue: PaymentMethod.esewa)
    @Default(PaymentMethod.esewa)
    PaymentMethod paymentMethod,
    required DateTime createdAt,
    String? birthPlace,
    DateTime? birthDate,
    String? birthTime,
    String? notes,
    String? cheenaMediaId,
    String? receiptMediaId,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  factory AppointmentModel.fromEntity(Appointment e) => AppointmentModel(
    id: e.id,
    astrologerId: e.astrologerId,
    astrologerName: LocalizedTextModel.fromEntity(e.astrologerName),
    service: SittingOptionModel.fromEntity(e.service),
    quantity: e.quantity,
    date: e.date,
    slot: TimeSlotModel.fromEntity(e.slot),
    status: e.status,
    customerName: e.customerName,
    phone: e.phone,
    email: e.email,
    country: e.country,
    paymentMethod: e.paymentMethod,
    createdAt: e.createdAt,
    birthPlace: e.birthPlace,
    birthDate: e.birthDate,
    birthTime: e.birthTime,
    notes: e.notes,
    cheenaMediaId: e.cheenaMediaId,
    receiptMediaId: e.receiptMediaId,
  );

  Appointment toEntity() => Appointment(
    id: id,
    astrologerId: astrologerId,
    astrologerName: astrologerName.toEntity(),
    service: service.toEntity(),
    quantity: quantity,
    date: date,
    slot: slot.toEntity(),
    status: status,
    customerName: customerName,
    phone: phone,
    email: email,
    country: country,
    paymentMethod: paymentMethod,
    createdAt: createdAt,
    birthPlace: birthPlace,
    birthDate: birthDate,
    birthTime: birthTime,
    notes: notes,
    cheenaMediaId: cheenaMediaId,
    receiptMediaId: receiptMediaId,
  );
}
