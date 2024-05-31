import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:spsp_mobile/models/pdf/customer_pdf.dart';
import 'package:spsp_mobile/models/invoice_pdf.dart';
import 'package:spsp_mobile/models/pdf/supplier_pdf.dart';
import 'package:spsp_mobile/pdf_utils/pdf_api.dart';
import 'package:spsp_mobile/utils/util.dart';

class PdfInvoiceApi {
  static Future<File> generateAsFile(InvoicePdf invoice) async {
    var pdf = await generatePdfDocument(invoice);
    return PdfApi.saveDocument(name: 'invoice_.pdf', pdf: pdf);
  }

  static Future<Uint8List> generateAsBytes(InvoicePdf invoice) async {
    var pdf = await generatePdfDocument(invoice);
    return PdfApi.generatePdfBytes(pdf: pdf);
  }

  static Future<Document> generatePdfDocument(InvoicePdf invoice) async {
    final pdf = Document(
        theme: ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf")),
      italic: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Italic.ttf")),
    ));

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));
    return pdf;
  }

  static Future<String> bytesToBase64(Uint8List bytes) async {
    String base64String = base64Encode(bytes);

    return base64String;
  }

  static Widget buildHeader(InvoicePdf invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              // Container(
              //   height: 50,
              //   width: 50,
              //   child: BarcodeWidget(
              //     barcode: Barcode.qrCode(),
              //     data: invoice.info.number,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(CustomerPdf customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfoPdf info) {
    final titles = <String>['Broj računa:', 'Datum narudžbe:'];
    final data = <String>[info.number, DateFormat('dd.MM.yyyy').format(info.date)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(SupplierPdf supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name!, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address!),
        ],
      );

  static Widget buildTitle(InvoicePdf invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "RAČUN:  ${invoice.info.number}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(InvoicePdf invoice) {
    final headers = ['Naziv', 'Cijena', 'Količina', 'Ukupna cijena'];
    final data = invoice.items.map((item) {
      return [
        item.name,
        '${item.unitPrice} KM',
        '${item.quantity}',
        '${item.subtotal.toStringAsFixed(2)} KM ',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(InvoicePdf invoice) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Vrijeme narudžbe',
                  value: DateFormat('dd.MM.yyyy').format(invoice.orderDateTime),
                  unite: true,
                ),
                buildText(
                  title: 'Iznos',
                  value: Utils.formatPrice(invoice.totalAmount).toString(),
                  unite: true,
                ),
                buildText(
                  title: 'PDV ${(invoice.vat * 100).toInt()} %',
                  value: "",
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Ukupan iznos',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(invoice.totalAmountWithVAT).toString(),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(InvoicePdf invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Adresa', value: invoice.supplier.address!),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Kontakt', value: invoice.supplier.contactInfo!),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
