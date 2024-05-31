import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:spsp_desktop/models/invoice/customer.dart';
import 'package:spsp_desktop/models/customer_report_data/customer_report_data.dart';
import 'package:spsp_desktop/models/invoice/invoice.dart';
import 'package:spsp_desktop/models/invoice/supplier.dart';
import 'package:spsp_desktop/pdf_utils/pdf_api.dart';

class PdfCustomerReportApi {
  static Future<File> generateAsFile(
      Invoice invoice, List<CustomerReportData> menuItemReportData) async {
    var pdf = await generatePdfDocument(invoice, menuItemReportData);
    return PdfApi.saveDocument(name: 'customer_report.pdf', pdf: pdf);
  }

  static Future<Document> generatePdfDocument(
      Invoice invoice, List<CustomerReportData> menuItemReportData) async {
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
        buildInvoice(menuItemReportData),
        Divider(),
      ],
      footer: (context) => buildFooter(invoice),
    ));
    return pdf;
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>['Broj racuna:', 'Datum narudzbe:'];
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

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name!, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address!),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Izvještaj za 10 najboljih kupaca",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(List<CustomerReportData> customerReportData) {
    final headers = ['Ime', 'Prezime', 'Email', 'Broj narudzbi', 'Ukupan prihod'];
    final data = customerReportData.map((item) {
      return [
        item.firstName,
        item.lastName,
        item.email,
        item.orderCount,
        '${item.totalAmount.toStringAsFixed(2)} KM ',
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

  static Widget buildFooter(Invoice invoice) => Column(
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
      crossAxisAlignment: pw.CrossAxisAlignment.end,
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
