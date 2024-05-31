// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      json['id'] as int,
      DateTime.parse(json['startTime'] as String),
      json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      json['description'] as String,
      json['active'] as bool,
      json['menuItemId'] as int?,
      json['menuItem'] == null
          ? null
          : MenuItem.fromJson(json['menuItem'] as Map<String, dynamic>),
      json['valid'] as bool?,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'description': instance.description,
      'active': instance.active,
      'menuItemId': instance.menuItemId,
      'menuItem': instance.menuItem,
      'valid': instance.valid,
    };
