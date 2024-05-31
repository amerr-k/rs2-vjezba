import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/menu_item.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  int id;
  DateTime startTime;
  DateTime? endTime;
  String description;
  bool active;
  int? menuItemId;
  MenuItem? menuItem;
  bool? valid;

  Promotion(this.id, this.startTime, this.endTime, this.description, this.active,
      this.menuItemId, this.menuItem, this.valid);

  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}
