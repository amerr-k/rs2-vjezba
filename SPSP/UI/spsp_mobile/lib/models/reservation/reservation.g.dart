// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: json['id'] as int?,
      qrTableId: json['qrTableId'] as int?,
      qrTable: json['qrTable'] == null
          ? null
          : QRTable.fromJson(json['qrTable'] as Map<String, dynamic>),
      customerId: json['customerId'] as int?,
      contactInfo: json['contactInfo'] as String?,
      specialRequest: json['specialRequest'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      status: json['status'] as String?,
      valid: json['valid'] as bool?,
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrTableId': instance.qrTableId,
      'qrTable': instance.qrTable,
      'customerId': instance.customerId,
      'contactInfo': instance.contactInfo,
      'specialRequest': instance.specialRequest,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': instance.status,
      'valid': instance.valid,
    };
