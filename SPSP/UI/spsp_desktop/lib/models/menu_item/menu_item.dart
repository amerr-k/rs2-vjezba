import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable()
class MenuItem {
  int? id;
  String? code;
  String? name;
  String? description;
  double? price;
  int? inStorage;
  String? image;
  int? categoryId;
  int? menuId;

  MenuItem(this.id, this.name, this.description, this.price, this.inStorage, this.code,
      this.image, this.categoryId, this.menuId);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
