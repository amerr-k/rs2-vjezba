import 'package:spsp_desktop/models/invoice/customer.dart';
import 'package:spsp_desktop/models/invoice/supplier.dart';

class Invoice {
  final InvoiceInfo? info;
  final Supplier supplier;
  final Customer? customer;
  final List<InvoiceItem>? items;
  final DateTime? orderDateTime;
  final double? totalAmountWithVAT;
  final double? vat;
  final double? totalAmount;

  const Invoice(
      {this.info,
      required this.supplier,
      this.customer,
      this.items,
      this.orderDateTime,
      this.totalAmountWithVAT,
      this.totalAmount,
      this.vat});
}

class InvoiceInfo {
  final String? description;
  final String number;
  final DateTime date;

  const InvoiceInfo({
    this.description,
    required this.number,
    required this.date,
  });
}

class InvoiceItem {
  final String name;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  const InvoiceItem(
      {required this.name,
      required this.quantity,
      required this.unitPrice,
      required this.subtotal});
}
