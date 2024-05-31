import 'package:json_annotation/json_annotation.dart';

part 'payment_gateway_data.g.dart';

@JsonSerializable()
class PaymentGatewayData {
  bool error;
  String message;
  String data;

  PaymentGatewayData(this.data, this.message, this.error);

  factory PaymentGatewayData.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentGatewayDataToJson(this);
}
