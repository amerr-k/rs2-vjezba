import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/paypal/items.dart';

part 'item_list.g.dart';

@JsonSerializable()
class ItemList {
  List<Items> items;

  ItemList(this.items);

  factory ItemList.fromJson(Map<String, dynamic> json) => _$ItemListFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}
