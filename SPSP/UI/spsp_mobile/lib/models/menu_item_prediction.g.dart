// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemPrediction _$MenuItemPredictionFromJson(Map<String, dynamic> json) =>
    MenuItemPrediction(
      json['id'] as int?,
      json['mainMenuItemId'] as int?,
      json['recommendedMenuItemId'] as int?,
      json['recommendedMenuItem'] == null
          ? null
          : MenuItem.fromJson(
              json['recommendedMenuItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MenuItemPredictionToJson(MenuItemPrediction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainMenuItemId': instance.mainMenuItemId,
      'recommendedMenuItemId': instance.recommendedMenuItemId,
      'recommendedMenuItem': instance.recommendedMenuItem,
    };
