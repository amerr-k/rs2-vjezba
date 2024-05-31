// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      (json['subtotal'] as num).toDouble(),
      shipping: (json['shipping'] as num?)?.toDouble() ?? 0,
      shipping_discount: (json['shipping_discount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'subtotal': instance.subtotal,
      'shipping': instance.shipping,
      'shipping_discount': instance.shipping_discount,
    };
