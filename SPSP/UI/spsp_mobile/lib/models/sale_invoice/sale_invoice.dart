import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/order.dart';
import 'package:spsp_mobile/models/order_item.dart';
import 'package:spsp_mobile/models/paypal/payment_gateway_data.dart';
import 'package:spsp_mobile/models/sale_invoice/sale_invoice_item.dart';

part 'sale_invoice.g.dart';

@JsonSerializable()
class SaleInvoice {
  SaleInvoice(
      {this.id,
      this.invoiceNumber,
      this.saleDate,
      required this.totalAmount,
      required this.totalAmountWithVAT,
      required this.vat,
      this.valid,
      this.processed,
      this.paymentGatewayData,
      this.paymentGatewayDataId,
      // required this.employeeId,
      // required this.employee,
      this.orderId,
      required this.saleInvoiceItems,
      this.pdfInvoice});

  int? id;
  String? invoiceNumber;
  DateTime? saleDate;
  double totalAmount;
  double totalAmountWithVAT;
  double? vat;
  bool? valid;
  bool? processed;
  int? paymentGatewayDataId;
  PaymentGatewayData? paymentGatewayData;
  int? orderId;
  // final Employee employee;
  List<SaleInvoiceItem> saleInvoiceItems;
  String? pdfInvoice;

  factory SaleInvoice.fromOrder(Order order) {
    List<SaleInvoiceItem> saleInvoiceItems = order.orderItems.map((orderItem) {
      return SaleInvoiceItem(
          menuItemId: orderItem.menuItemId!,
          quantity: orderItem.quantity!,
          unitPrice: orderItem.menuItem!.price!,
          subtotal: orderItem.subtotal!);
    }).toList();

    return SaleInvoice(
        saleInvoiceItems: saleInvoiceItems,
        saleDate: DateTime.now(),
        totalAmount: order.totalAmount!,
        totalAmountWithVAT: order.totalAmountWithVAT!,
        vat: order.vat,
        orderId: order.id);
  }

  factory SaleInvoice.fromJson(Map<String, dynamic> json) => _$SaleInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$SaleInvoiceToJson(this);
}
