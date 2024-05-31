import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/menu_item.dart';

part 'menu_item_prediction.g.dart';

@JsonSerializable()
class MenuItemPrediction {
  int? id;
  int? mainMenuItemId;
  int? recommendedMenuItemId;
  MenuItem? recommendedMenuItem;

  MenuItemPrediction(
      this.id, this.mainMenuItemId, this.recommendedMenuItemId, this.recommendedMenuItem);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MenuItemPrediction.fromJson(Map<String, dynamic> json) =>
      _$MenuItemPredictionFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MenuItemPredictionToJson(this);
}
