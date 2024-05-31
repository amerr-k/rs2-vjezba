// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthInfo _$UserAuthInfoFromJson(Map<String, dynamic> json) => UserAuthInfo(
      UserAccount.fromJson(json['userAccount'] as Map<String, dynamic>),
      json['token'] as String,
    );

Map<String, dynamic> _$UserAuthInfoToJson(UserAuthInfo instance) =>
    <String, dynamic>{
      'userAccount': instance.userAccount,
      'token': instance.token,
    };
