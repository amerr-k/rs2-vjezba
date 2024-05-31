// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceItem _$SaleInvoiceItemFromJson(Map<String, dynamic> json) =>
    SaleInvoiceItem(
      id: json['id'] as int?,
      saleInvoiceId: json['saleInvoiceId'] as int?,
      menuItemId: json['menuItemId'] as int?,
      quantity: json['quantity'] as int?,
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      valid: json['valid'] as bool?,
      menuItem: json['menuItem'] == null
          ? null
          : MenuItem.fromJson(json['menuItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleInvoiceItemToJson(SaleInvoiceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'saleInvoiceId': instance.saleInvoiceId,
      'menuItemId': instance.menuItemId,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'subtotal': instance.subtotal,
      'valid': instance.valid,
      'menuItem': instance.menuItem,
    };
