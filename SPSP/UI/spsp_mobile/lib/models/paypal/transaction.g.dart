// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      Amount.fromJson(json['amount'] as Map<String, dynamic>),
      ItemList.fromJson(json['itemList'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'itemList': instance.itemList,
    };
