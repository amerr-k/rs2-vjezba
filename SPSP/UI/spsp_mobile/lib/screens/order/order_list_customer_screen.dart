// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spsp_mobile/models/enums/OrderStatus.dart';
import 'package:spsp_mobile/models/order.dart';
import 'package:spsp_mobile/models/qr_table.dart';
import 'package:spsp_mobile/models/search_result.dart';
import 'package:spsp_mobile/providers/order_provider.dart';
import 'package:spsp_mobile/utils/util.dart';
import 'package:spsp_mobile/widgets/master_screen.dart';

class OrderListCustomerScreen extends StatefulWidget {
  static const String routeName = "/orders";

  const OrderListCustomerScreen({super.key});

  @override
  State<OrderListCustomerScreen> createState() => _OrderListCustomerScreenState();
}

class _OrderListCustomerScreenState extends State<OrderListCustomerScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late OrderProvider _orderProvider;

  RequestResult<Order>? orderListRequestResult;

  List<QRTable> qrTableList = [];
  bool isLoading = true;
  bool isSearchVisible = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _orderProvider = context.read<OrderProvider>();

    orderListRequestResult = await _orderProvider?.get(filter: {
      "orderStatus": OrderStatus.COMPLETED.name,
      "isOrderItemsIncluded": true,
      "searchByCustomer": true
    });
    setState(() {
      orderListRequestResult = orderListRequestResult!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Historija narudžbi",
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isSearchVisible = !isSearchVisible;
                });
              },
              child:
                  const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Pretraga po filterima"),
                Icon(Icons.filter_list),
              ]),
            ),
          ),
          if (isSearchVisible) Expanded(child: _buildSearch()),
          Expanded(
              child: isLoading
                  ? Container(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _buildProductCardList()),
        ],
      ),
    );
  }

  Widget _buildProductCardList() {
    return Container(
      child: ListView.builder(
        itemCount: orderListRequestResult?.count,
        itemBuilder: (context, index) {
          var rowNumber = index + 1;
          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: _buildProductCard(orderListRequestResult!.result[index], rowNumber),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Order item, int rowNumber) {
    return ListTile(
      leading: Text(rowNumber.toString()),
      title: Text(Utils.formatDate(item.orderDateTime!)),
      subtitle: Text(" ${item.totalAmountWithVAT.toString()} KM"),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Column(
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
                  ),
                ),
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                inputType: InputType.date,
                format: DateFormat('dd.MM.yyyy'),
                onChanged: (value) {},
                onSaved: (value) {},
              ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.saveAndValidate();
                    var request = Map.from(_formKey.currentState!.value);
                    request['isOrderItemsIncluded'] = true;
                    request['searchByCustomer'] = true;
                    var orderListSearchResult = await _orderProvider.get(filter: request);
                    setState(() {
                      orderListRequestResult = orderListSearchResult!;
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Traži")],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
