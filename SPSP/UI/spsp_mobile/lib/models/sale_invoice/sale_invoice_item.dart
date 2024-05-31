import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/menu_item.dart';
import 'package:spsp_mobile/models/paypal/payment_gateway_data.dart';
part 'sale_invoice_item.g.dart';

@JsonSerializable()
class SaleInvoiceItem {
  final int? id;
  final int? saleInvoiceId;
  final int? menuItemId;
  final int? quantity;
  final double? unitPrice;
  final double? subtotal;
  final bool? valid;
  final MenuItem? menuItem;

  SaleInvoiceItem({
    this.id,
    this.saleInvoiceId,
    this.menuItemId,
    this.quantity,
    this.unitPrice,
    this.subtotal,
    this.valid,
    this.menuItem,
  });
  factory SaleInvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$SaleInvoiceItemToJson(this);
}
