import 'package:json_annotation/json_annotation.dart';

part 'menu_item_report_data.g.dart';

@JsonSerializable()
class MenuItemReportData {
  int? id;
  String? name;
  String? category;
  double price;
  int orderCount;
  double totalAmount;

  MenuItemReportData({
    this.id,
    this.name,
    this.category,
    required this.price,
    required this.orderCount,
    required this.totalAmount,
  });

  factory MenuItemReportData.fromJson(Map<String, dynamic> json) =>
      _$MenuItemReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemReportDataToJson(this);
}
