// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['id'] as int?,
      json['customerId'] as int?,
      json['orderDateTime'] == null
          ? null
          : DateTime.parse(json['orderDateTime'] as String),
      (json['totalAmount'] as num?)?.toDouble(),
      (json['totalAmountWithVAT'] as num?)?.toDouble(),
      (json['vat'] as num?)?.toDouble(),
      (json['vatAmount'] as num?)?.toDouble(),
      json['status'] as String?,
      json['qrTableId'] as int?,
      json['qrTable'] == null
          ? null
          : QRTable.fromJson(json['qrTable'] as Map<String, dynamic>),
      (json['orderItems'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'orderDateTime': instance.orderDateTime?.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'totalAmountWithVAT': instance.totalAmountWithVAT,
      'vat': instance.vat,
      'vatAmount': instance.vatAmount,
      'status': instance.status,
      'qrTableId': instance.qrTableId,
      'qrTable': instance.qrTable,
      'orderItems': instance.orderItems,
    };
