// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      json['id'] as int?,
      json['orderId'] as int?,
      json['menuItemId'] as int?,
      json['quantity'] as int?,
      (json['subtotal'] as num?)?.toDouble(),
      json['menuItem'] == null
          ? null
          : MenuItem.fromJson(json['menuItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'menuItemId': instance.menuItemId,
      'quantity': instance.quantity,
      'subtotal': instance.subtotal,
      'menuItem': instance.menuItem,
    };
