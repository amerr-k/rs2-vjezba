// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerReportData _$CustomerReportDataFromJson(Map<String, dynamic> json) =>
    CustomerReportData(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      orderCount: json['orderCount'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$CustomerReportDataToJson(CustomerReportData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'orderCount': instance.orderCount,
      'totalAmount': instance.totalAmount,
    };
