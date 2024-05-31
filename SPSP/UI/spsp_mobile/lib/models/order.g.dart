// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      (json['orderItems'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      customerId: json['customerId'] as int?,
      orderDateTime: json['orderDateTime'] == null
          ? null
          : DateTime.parse(json['orderDateTime'] as String),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      totalAmountWithVAT: (json['totalAmountWithVAT'] as num?)?.toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      vatAmount: (json['vatAmount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      qrTableId: json['qrTableId'] as int?,
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
      'orderItems': instance.orderItems,
    };
