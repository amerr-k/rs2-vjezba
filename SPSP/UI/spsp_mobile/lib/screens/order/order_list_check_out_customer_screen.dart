// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:provider/provider.dart';
import 'package:spsp_mobile/environment_config.dart';
import 'package:spsp_mobile/models/enums/OrderStatus.dart';
import 'package:spsp_mobile/models/invoice_pdf.dart';
import 'package:spsp_mobile/models/order.dart';
import 'package:spsp_mobile/models/paypal/amount.dart';
import 'package:spsp_mobile/models/paypal/details.dart';
import 'package:spsp_mobile/models/paypal/item_list.dart';
import 'package:spsp_mobile/models/paypal/items.dart';
import 'package:spsp_mobile/models/paypal/payment_gateway_data.dart';
import 'package:spsp_mobile/models/paypal/transaction.dart';
import 'package:spsp_mobile/models/sale_invoice/sale_invoice.dart';
import 'package:spsp_mobile/models/search_result.dart';
import 'package:spsp_mobile/models/pdf/supplier_pdf.dart';
import 'package:spsp_mobile/pdf_utils/pdf_invoice_api.dart';
import 'package:spsp_mobile/providers/order_provider.dart';
import 'package:spsp_mobile/providers/sale_invoice_provider.dart';
import 'package:spsp_mobile/providers/transaction_provider.dart';

class OrderListCheckOutCustomerScreen extends StatefulWidget {
  final String? qrTableId;

  const OrderListCheckOutCustomerScreen({Key? key, required this.qrTableId})
      : super(key: key);

  @override
  _OrderListCheckOutCustomerScreenState createState() =>
      _OrderListCheckOutCustomerScreenState();
}

class _OrderListCheckOutCustomerScreenState
    extends State<OrderListCheckOutCustomerScreen> {
  RequestResult<Order>? orders;
  List<bool> _isChecked = [];
  late TransactionProvider _transactionProvider = TransactionProvider();
  late SaleInvoiceProvider _saleInvoiceProvider = SaleInvoiceProvider();
  late OrderProvider _orderProvider = OrderProvider();
  var CLIENT_ID_VALUE = String.fromEnvironment('CLIENT_ID_VALUE',
      defaultValue: EnvironmentConfig.CLIENT_ID_VALUE);
  var SECRET_KEY_VALUE = String.fromEnvironment('SECRET_KEY_VALUE',
      defaultValue: EnvironmentConfig.SECRET_KEY_VALUE);
  @override
  void initState() {
    super.initState();
    _transactionProvider = context.read<TransactionProvider>();
    _saleInvoiceProvider = context.read<SaleInvoiceProvider>();
    _orderProvider = context.read<OrderProvider>();

    _getOrders();
  }

  late ScaffoldMessengerState _scaffoldMessengerState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
  }

  Future<void> _getOrders() async {
    final fetchedOrders = await _orderProvider.get(filter: {
      "qrTableId": widget.qrTableId,
      "orderStatus": OrderStatus.ACTIVE.name,
      "isOrderItemsIncluded": true
    });
    setState(() {
      orders = fetchedOrders;
      _isChecked = List<bool>.filled(fetchedOrders?.result.length ?? 0, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista narudžbi'),
      ),
      body:
          orders != null ? _buildOrderList() : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: orders != null && orders!.result.isNotEmpty
                  ? () {
                      var transactions = _createCheckedTransactions();
                      List<Order> selectedOrders = [];
                      for (var i = 0; i < orders!.result.length; i++) {
                        if (_isChecked[i]) {
                          selectedOrders.add(orders!.result[i]);
                        }
                      }

                      if (!transactions.isEmpty) {
                        _openPaypalGateway(context, transactions, selectedOrders);
                      }
                    }
                  : null,
              child: Text('Plati odabrano'),
            ),
            ElevatedButton(
              onPressed: orders != null && orders!.result.isNotEmpty
                  ? () {
                      var transactions = _createAllTransactions();
                      List<Order> selectedOrders = orders!.result;

                      if (!transactions.isEmpty) {
                        _openPaypalGateway(context, transactions, selectedOrders);
                      }
                    }
                  : null,
              child: Text('Plati sve'),
            ),
          ],
        ),
      ),
    );
  }

  void _openPaypalGateway(
      BuildContext context, List<Transaction> transactions, List<Order> selectedOrders) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SafeArea(
          child: PaypalCheckout(
            sandboxMode: true,
            clientId: CLIENT_ID_VALUE,
            secretKey: SECRET_KEY_VALUE,
            returnURL: "success.snippetcoder.com",
            cancelURL: "cancel.snippetcoder.com",
            transactions: transactions,
            note: "Uživajte u vašem piću i dođite nam ponovo.",
            onSuccess: (Map params) async {
              var paymentGatewayData = PaymentGatewayData(params["data"].toString(),
                  params["message"].toString(), params["error"]);

              _clearOrderItems();

              for (var i = 0; i < selectedOrders.length; i++) {
                var order = selectedOrders[i];
                var create = SaleInvoice.fromOrder(order);
                create.pdfInvoice = await _createPdfInvoice(order);

                create.paymentGatewayData = paymentGatewayData;
                create.processed = true;

                await _saleInvoiceProvider.create(create);
              }

              final fetchedOrders = await _orderProvider.get(filter: {
                "qrTableId": widget.qrTableId,
                "orderStatus": OrderStatus.ACTIVE.name,
                "isOrderItemsIncluded": true
              });
              setState(() {
                orders = fetchedOrders;
                _isChecked = List<bool>.filled(fetchedOrders?.result.length ?? 0, false);
              });

              _scaffoldMessengerState.showSnackBar(
                const SnackBar(
                  content: Text(
                    "Plaćanje je uspješno procesuirano",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Desila se greška prilikom procesuiranja plaćanja. Molimo kontaktirajte administratora",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.pop(context);
            },
            onCancel: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      itemCount: orders!.result.length,
      itemBuilder: (context, index) {
        final order = orders!.result[index];
        return Column(
          children: [
            CheckboxListTile(
              title: Text('ID narudžbe: ${order.id}'),
              subtitle: Text('Ukupno: ${order.totalAmountWithVAT}'),
              value: _isChecked[index],
              onChanged: (value) {
                setState(() {
                  _isChecked[index] = value!;
                });
              },
            ),
            ExpansionTile(
              title: Text('Detalji', style: TextStyle(fontSize: 12)),
              children: order.orderItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Artikal: ${item.menuItem!.name}'),
                      Text('Količina: ${item.quantity}'),
                      Text('Cijena: ${item.subtotal}'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  List<Transaction> _createCheckedTransactions() {
    var currency = "USD";
    double totalAmount = 0;
    ItemList itemList = ItemList([]);

    for (int i = 0; i < orders!.result.length; i++) {
      var order = orders!.result[i];
      if (_isChecked[i]) {
        var newTransaction = createNewTransaction(order);
        totalAmount += newTransaction.amount.total;
        itemList.items.addAll(newTransaction.itemList.items);
      }
    }
    var amount = Amount(totalAmount, currency, Details(totalAmount));
    var transaction = Transaction(amount, itemList, description: "Novo plaćanje");
    return [transaction];
  }

  List<Transaction> _createAllTransactions() {
    var currency = "USD";
    double totalAmount = 0;
    ItemList itemList = ItemList([]);

    orders!.result.forEach((order) {
      var newTransaction = createNewTransaction(order);
      totalAmount += newTransaction.amount.total;
      itemList.items.addAll(newTransaction.itemList.items);
    });

    var amount = Amount(totalAmount, currency, Details(totalAmount));
    var transaction = Transaction(amount, itemList, description: "Novo plaćanje");
    return [transaction];
  }

  Transaction createNewTransaction(Order order) {
    var total = order.totalAmountWithVAT!;
    var currency = "USD";
    var subtotal = order.totalAmountWithVAT!;
    var details = Details(subtotal);
    var amount = Amount(total, currency, details);

    List<Items> items = [];
    order.orderItems.forEach((orderItem) {
      var item = Items(orderItem.menuItem!.name!, orderItem.quantity!,
          orderItem.menuItem!.price!, currency);
      items.add(item);
    });

    var itemList = ItemList(items);
    var transaction = Transaction(amount, itemList, description: "Novo plaćanje");
    return transaction;
  }

  _clearOrderItems() {
    setState(() {
      orders!.count = 0;
      orders!.result = [];
    });

    _transactionProvider.setIsPaymentProcessed(true);
  }

  void _showPaymentSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Your transaction has been processed successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<String> _createPdfInvoice(Order x) async {
    final items = x.orderItems.map((orderItem) {
      final name = orderItem.menuItem?.name ?? '';
      final unitPrice = orderItem.menuItem?.price ?? 0.0;
      final subtotal = orderItem.subtotal ?? 0.0;
      final quantity = orderItem.quantity ?? 0;

      return InvoiceItemPdf(
          name: name, quantity: quantity, unitPrice: unitPrice, subtotal: subtotal);
    }).toList();

    final invoice = InvoicePdf(
      supplier: SupplierPdf(
          name: 'Caffe Pub - Skeniraj Plati',
          address: 'ul. Abdulaha Sidrana, Sarajevo, BiH',
          contactInfo: "+387 62 123 321"),
      info: InvoiceInfoPdf(
        date: x.orderDateTime!,
        number: x.id.toString(),
      ),
      orderDateTime: x.orderDateTime!,
      totalAmount: x.totalAmount!,
      totalAmountWithVAT: x.totalAmountWithVAT!,
      vat: x.vat!,
      items: items,
    );

    final pdfFileBytes = await PdfInvoiceApi.generateAsBytes(invoice);

    return await PdfInvoiceApi.bytesToBase64(pdfFileBytes);
  }
}
