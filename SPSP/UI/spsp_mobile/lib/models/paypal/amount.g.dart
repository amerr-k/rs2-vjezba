// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Amount _$AmountFromJson(Map<String, dynamic> json) => Amount(
      (json['total'] as num).toDouble(),
      json['currency'] as String,
      Details.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
      'details': instance.details,
    };
