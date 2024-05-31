import 'package:spsp_mobile/models/pdf/customer_pdf.dart';
import 'package:spsp_mobile/models/pdf/supplier_pdf.dart';

class InvoicePdf {
  final InvoiceInfoPdf info;
  final SupplierPdf supplier;
  final CustomerPdf? customer;
  final List<InvoiceItemPdf> items;
  final DateTime orderDateTime;
  final double totalAmountWithVAT;
  final double vat;
  final double totalAmount;

  const InvoicePdf(
      {required this.info,
      required this.supplier,
      this.customer,
      required this.items,
      required this.orderDateTime,
      required this.totalAmountWithVAT,
      required this.totalAmount,
      required this.vat});
}

class InvoiceInfoPdf {
  final String? description;
  final String number;
  final DateTime date;

  const InvoiceInfoPdf({
    this.description,
    required this.number,
    required this.date,
  });
}

class InvoiceItemPdf {
  final String name;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  const InvoiceItemPdf(
      {required this.name,
      required this.quantity,
      required this.unitPrice,
      required this.subtotal});
}
