import 'package:json_annotation/json_annotation.dart';

part 'customer_report_data.g.dart';

@JsonSerializable()
class CustomerReportData {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  int orderCount;
  double totalAmount;

  CustomerReportData({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    required this.orderCount,
    required this.totalAmount,
  });

  factory CustomerReportData.fromJson(Map<String, dynamic> json) =>
      _$CustomerReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerReportDataToJson(this);
}
