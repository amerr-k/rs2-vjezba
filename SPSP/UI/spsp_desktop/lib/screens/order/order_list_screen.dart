// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spsp_desktop/models/enums/OrderStatus.dart';
import 'package:spsp_desktop/models/invoice/invoice.dart';
import 'package:spsp_desktop/models/order/order.dart';
import 'package:spsp_desktop/models/qr_table/qr_table.dart';
import 'package:spsp_desktop/models/search_result.dart';
import 'package:spsp_desktop/models/invoice/supplier.dart';
import 'package:spsp_desktop/pdf_utils/pdf_api.dart';
import 'package:spsp_desktop/pdf_utils/pdf_invoice_api.dart';
import 'package:spsp_desktop/providers/order_provider.dart';
import 'package:spsp_desktop/providers/qr_table_provider.dart';
import 'package:spsp_desktop/utils/util.dart';
import 'package:spsp_desktop/widgets/master_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late QRTableProvider _qrTableProvider;
  late OrderProvider _orderProvider;

  RequestResult<Order>? orderListRequestResult;

  List<Order> orderList = [];
  List<QRTable> qrTableList = [];
  bool isLoading = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _orderProvider = context.read<OrderProvider>();

    orderListRequestResult = await _orderProvider?.get(filter: {
      "orderStatus": OrderStatus.ACTIVE.name,
      "isOrderItemsIncluded": true,
      "isQRTablesIncluded": true
    });
    setState(() {
      orderList = orderListRequestResult!.result;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _qrTableProvider = context.read<QRTableProvider>();

    _initialValue = {
      'orderStatus': OrderStatus.ACTIVE.name.toString(),
    };

    loadQRTableList();
  }

  Future loadQRTableList() async {
    var tmpQRTableList = await _qrTableProvider?.get();
    setState(() {
      qrTableList = tmpQRTableList!.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  _buildSearch(),
                  isLoading
                      ? Center(
                          child: Container(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : _buildOrderListView()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderListView() {
    return Expanded(
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 50,
          mainAxisSpacing: 30,
          crossAxisCount: 4,
          children: _buildOrderListCards()),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Row(
          children: [
            Expanded(
              child: FormBuilderDateTimePicker(
                name: "orderDateTimeFrom",
                decoration: InputDecoration(
                    labelText: "Datum od",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _formKey.currentState?.fields['orderDateTimeFrom']?.reset();
                        });
                      },
                    )),
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                inputType: InputType.date, // Set inputType to date
                format: DateFormat('dd.MM.yyyy'),
                onChanged: (value) {},
                onSaved: (value) {},
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: FormBuilderDateTimePicker(
                name: "orderDateTimeTo",
                decoration: InputDecoration(
                    labelText: "Datum do",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _formKey.currentState?.fields['orderDateTimeTo']?.reset();
                        });
                      },
                    )),
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                inputType: InputType.date,
                format: DateFormat('dd.MM.yyyy'),
                onChanged: (value) {},
                onSaved: (value) {},
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: FormBuilderDropdown<String>(
                name: 'orderStatus',
                decoration: InputDecoration(
                    labelText: "Status narudžbe",
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.close,
                      ),
                      onPressed: () {
                        _formKey.currentState!.fields['orderStatus']?.reset();
                      },
                    ),
                    hintText: "Odaberi status narudžbe"),
                items: [
                  DropdownMenuItem<String>(
                    value: OrderStatus.ACTIVE.name,
                    child: Text(OrderStatus.ACTIVE.value),
                  ),
                  DropdownMenuItem<String>(
                    value: OrderStatus.COMPLETED.name,
                    child: Text(OrderStatus.COMPLETED.value),
                  ),
                  DropdownMenuItem<String>(
                    value: OrderStatus.CANCELED.name,
                    child: Text(OrderStatus.CANCELED.value),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                _formKey.currentState?.saveAndValidate();
                var request = Map.from(_formKey.currentState!.value);
                request['isOrderItemsIncluded'] = true;
                request['isQRTablesIncluded'] = true;
                var orderListSearchResult = await _orderProvider.get(filter: request);
                setState(() {
                  orderList = orderListSearchResult!.result;
                });
              },
              child: const Text("Pretraga"),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOrderListCards() {
    if (orderList.length == 0) {
      return [Text("Podaci za tražene narudžbe ne postoje.")];
    }

    List<Widget> list = orderList
        .map((x) => Container(
              child: Column(
                children: [
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.blue),
                    ),
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        children: [
                          Container(
                              child: ListTile(
                            dense: true,
                            title: Text("Status narudžbe",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black)),
                            trailing: Text(
                                OrderStatusExtension.enumFromString(x.status!).value,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )),
                          Container(
                              child: ListTile(
                            dense: true,
                            title: Text("STO br.:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            trailing: Text(
                                x.qrTable != null
                                    ? x.qrTable!.tableNumber.toString()
                                    : "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                          Container(
                              child: ListTile(
                            dense: true,
                            title: Text("Vrijeme narudžbe:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black)),
                            trailing: Text(
                              DateFormat('dd.MM.yyyy HH:mm').format(x.orderDateTime!),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                          Container(
                              child: ListTile(
                            dense: true,
                            title: Text("PDV:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black)),
                            trailing: Text((x.vat! * 100).toInt().toString() + "%",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )),
                          Container(
                              child: ListTile(
                            dense: true,
                            title: Text("Iznos (bez uračunatog PDV-a):",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black)),
                            trailing: Text(formatNumber(x.totalAmount),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )),
                          Container(
                              child: ListTile(
                            dense: true,
                            title: Text("Iznos:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black)),
                            trailing: Text(formatNumber(x.totalAmountWithVAT),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )),
                          x.status == "ACTIVE"
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: () async {
                                          try {
                                            await _orderProvider.cancelOrder(x.id!);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            orderListRequestResult =
                                                await _orderProvider?.get(filter: {
                                              "orderStatus": OrderStatus.ACTIVE.name,
                                              "isOrderItemsIncluded": true,
                                              "isQRTablesIncluded": true
                                            });
                                            setState(() {
                                              orderList = orderListRequestResult!.result;
                                              isLoading = false;
                                            });
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Uspješno ste otkazali narudžbu",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          } on Exception catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  e.toString(),
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text("Otkaži"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: () async {
                                          final items = x.orderItems.map((orderItem) {
                                            final name = orderItem.menuItem?.name ?? '';
                                            final unitPrice =
                                                orderItem.menuItem?.price ?? 0.0;
                                            final subtotal = orderItem.subtotal ?? 0.0;
                                            final quantity = orderItem.quantity ?? 0;

                                            return InvoiceItem(
                                                name: name,
                                                quantity: quantity,
                                                unitPrice: unitPrice,
                                                subtotal: subtotal);
                                          }).toList();

                                          final invoice = Invoice(
                                            supplier: Supplier(
                                                name: 'Caffe Pub - Skeniraj Plati',
                                                address:
                                                    'ul. Abdulaha Sidrana, Sarajevo, BiH',
                                                contactInfo: "+387 62 123 321"),
                                            info: InvoiceInfo(
                                              date: x.orderDateTime!,
                                              number: x.id.toString(),
                                            ),
                                            orderDateTime: x.orderDateTime!,
                                            totalAmount: x.totalAmount!,
                                            totalAmountWithVAT: x.totalAmountWithVAT!,
                                            vat: x.vat!,
                                            items: items,
                                          );

                                          try {
                                            await _orderProvider.completeOrder(x.id!);

                                            final pdfFile =
                                                await PdfInvoiceApi.generateAsFile(
                                                    invoice);

                                            PdfApi.openFile(pdfFile);

                                            setState(() {
                                              isLoading = false;
                                            });
                                            orderListRequestResult =
                                                await _orderProvider?.get(filter: {
                                              "orderStatus": OrderStatus.ACTIVE.name,
                                              "isOrderItemsIncluded": true,
                                              "isQRTablesIncluded": true
                                            });
                                            setState(() {
                                              orderList = orderListRequestResult!.result;
                                              isLoading = false;
                                            });

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Uspješno ste generisali račun",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          } on Exception catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  e.toString(),
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text("Generiši račun"),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }
}
