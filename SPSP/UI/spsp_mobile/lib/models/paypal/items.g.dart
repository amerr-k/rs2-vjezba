// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      json['name'] as String,
      json['quantity'] as int,
      (json['price'] as num).toDouble(),
      json['currency'] as String,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'currency': instance.currency,
    };
