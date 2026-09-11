// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    _AppointmentModel(
      id: json['id'] as String,
      astrologerId: json['astrologer_id'] as String,
      astrologerName: LocalizedTextModel.fromJson(
        json['astrologer_name'] as Map<String, dynamic>,
      ),
      service: SittingOptionModel.fromJson(
        json['service'] as Map<String, dynamic>,
      ),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      date: DateTime.parse(json['date'] as String),
      slot: TimeSlotModel.fromJson(json['slot'] as Map<String, dynamic>),
      status:
          $enumDecodeNullable(
            _$AppointmentStatusEnumMap,
            json['status'],
            unknownValue: AppointmentStatus.booked,
          ) ??
          AppointmentStatus.booked,
      customerName: json['customer_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      country: json['country'] as String? ?? '',
      paymentMethod:
          $enumDecodeNullable(
            _$PaymentMethodEnumMap,
            json['payment_method'],
            unknownValue: PaymentMethod.esewa,
          ) ??
          PaymentMethod.esewa,
      createdAt: DateTime.parse(json['created_at'] as String),
      birthPlace: json['birth_place'] as String?,
      birthDate: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      birthTime: json['birth_time'] as String?,
      notes: json['notes'] as String?,
      cheenaMediaId: json['cheena_media_id'] as String?,
      receiptMediaId: json['receipt_media_id'] as String?,
    );

Map<String, dynamic> _$AppointmentModelToJson(_AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'astrologer_id': instance.astrologerId,
      'astrologer_name': instance.astrologerName.toJson(),
      'service': instance.service.toJson(),
      'quantity': instance.quantity,
      'date': instance.date.toIso8601String(),
      'slot': instance.slot.toJson(),
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'customer_name': instance.customerName,
      'phone': instance.phone,
      'email': instance.email,
      'country': instance.country,
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'created_at': instance.createdAt.toIso8601String(),
      'birth_place': ?instance.birthPlace,
      'birth_date': ?instance.birthDate?.toIso8601String(),
      'birth_time': ?instance.birthTime,
      'notes': ?instance.notes,
      'cheena_media_id': ?instance.cheenaMediaId,
      'receipt_media_id': ?instance.receiptMediaId,
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.booked: 'booked',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.cancelled: 'cancelled',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.esewa: 'esewa',
  PaymentMethod.khalti: 'khalti',
  PaymentMethod.bank: 'bank',
  PaymentMethod.paypal: 'paypal',
  PaymentMethod.upi: 'upi',
  PaymentMethod.card: 'card',
  PaymentMethod.netBanking: 'net_banking',
  PaymentMethod.cash: 'cash',
};
