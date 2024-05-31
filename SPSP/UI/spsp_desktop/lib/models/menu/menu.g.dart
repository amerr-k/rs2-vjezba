// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      json['id'] as int?,
      json['name'] as String?,
      json['qrCode'] as String?,
      json['isActive'],
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'qrCode': instance.qrCode,
      'isActive': instance.isActive,
    };
