// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      (json['price'] as num?)?.toDouble(),
      json['inStorage'] as int?,
      json['code'] as String?,
      json['image'] as String?,
      json['categoryId'] as int?,
      json['menuId'] as int?,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'inStorage': instance.inStorage,
      'image': instance.image,
      'categoryId': instance.categoryId,
      'menuId': instance.menuId,
    };
