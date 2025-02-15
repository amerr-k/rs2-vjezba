import 'package:json_annotation/json_annotation.dart';

import 'package:spsp_mobile/models/menu_item.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  int? id;
  int? orderId;
  int? menuItemId;
  int? quantity;
  double? subtotal;
  MenuItem? menuItem;

  OrderItem(this.id, this.orderId, this.menuItemId, this.quantity, this.subtotal,
      this.menuItem);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
