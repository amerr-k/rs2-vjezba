// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      (json['items'] as List<dynamic>)
          .map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
      'items': instance.items,
    };
