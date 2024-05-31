import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
  double subtotal;
  double? shipping;
  double? shipping_discount;

  Details(this.subtotal, {this.shipping = 0, this.shipping_discount = 0});

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
