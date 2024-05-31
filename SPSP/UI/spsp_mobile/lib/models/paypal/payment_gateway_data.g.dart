// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_gateway_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentGatewayData _$PaymentGatewayDataFromJson(Map<String, dynamic> json) =>
    PaymentGatewayData(
      json['data'] as String,
      json['message'] as String,
      json['error'] as bool,
    );

Map<String, dynamic> _$PaymentGatewayDataToJson(PaymentGatewayData instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
