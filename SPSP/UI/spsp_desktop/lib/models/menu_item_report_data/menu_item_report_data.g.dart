// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemReportData _$MenuItemReportDataFromJson(Map<String, dynamic> json) =>
    MenuItemReportData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num).toDouble(),
      orderCount: json['orderCount'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$MenuItemReportDataToJson(MenuItemReportData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'price': instance.price,
      'orderCount': instance.orderCount,
      'totalAmount': instance.totalAmount,
    };
