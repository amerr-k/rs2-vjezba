// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      json['id'] as int,
      json['userAccountId'] as int?,
      json['userAccount'] == null
          ? null
          : UserAccount.fromJson(json['userAccount'] as Map<String, dynamic>),
      json['address'] as String?,
      json['phone'] as String?,
      json['penaltyPoints'] as int?,
      json['valid'] as bool?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'userAccountId': instance.userAccountId,
      'userAccount': instance.userAccount,
      'address': instance.address,
      'phone': instance.phone,
      'penaltyPoints': instance.penaltyPoints,
      'valid': instance.valid,
    };
