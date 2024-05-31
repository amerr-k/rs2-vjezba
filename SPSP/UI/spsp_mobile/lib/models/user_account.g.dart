// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      json['id'] as int,
      json['username'] as String,
      json['email'] as String,
      json['password'] as String?,
      json['firstName'] as String,
      json['lastName'] as String,
      json['valid'] as bool,
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'valid': instance.valid,
    };
