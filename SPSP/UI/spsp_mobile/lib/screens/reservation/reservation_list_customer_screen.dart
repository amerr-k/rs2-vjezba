// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spsp_mobile/models/enums/ReservationStatus.dart';
import 'package:spsp_mobile/models/qr_table.dart';
import 'package:spsp_mobile/models/reservation/reservation.dart';
import 'package:spsp_mobile/models/search_result.dart';
import 'package:spsp_mobile/providers/qr_table_provider.dart';
import 'package:spsp_mobile/providers/reservation_provider.dart';
import 'package:spsp_mobile/screens/reservation/reservation_details_customer_screen.dart';
import 'package:spsp_mobile/utils/util.dart';
import 'package:spsp_mobile/widgets/master_screen.dart';

class ReservationListCustomerScreen extends StatefulWidget {
  static const String routeName = "/reservation";

  const ReservationListCustomerScreen({super.key});

  @override
  State<ReservationListCustomerScreen> createState() =>
      _ReservationListCustomerScreenState();
}

class _ReservationListCustomerScreenState extends State<ReservationListCustomerScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late QRTableProvider _qrTableProvider;
  late ReservationProvider _reservationProvider;

  RequestResult<Reservation>? reservationListRequestResult;

  List<QRTable> qrTableList = [];
  bool isLoading = true;
  bool isSearchVisible = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _reservationProvider = context.read<ReservationProvider>();

    reservationListRequestResult = await _reservationProvider?.get(filter: {
      "reservationStatus": ReservationStatus.PENDING_CONFIRMATION.name,
      "isReservationItemsIncluded": true,
      "isQRTableIncluded": true,
      "searchByCustomer": true
    });
    setState(() {
      reservationListRequestResult = reservationListRequestResult!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _reservationProvider = context.read<ReservationProvider>();
    _qrTableProvider = context.read<QRTableProvider>();

    _initialValue = {
      'reservationStatus': ReservationStatus.PENDING_CONFIRMATION.name.toString(),
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
      title: "Rezervacije",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isSearchVisible = !isSearchVisible;
                    });
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text("Filteri")),
                        Icon(Icons.filter_list),
                      ]),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReservationDetailsCustomerScreen(),
                      ),
                    );
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text("Kreiraj rezervaciju")),
                        Icon(Icons.add),
                      ]),
                ),
              ),
            ],
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
        itemCount: reservationListRequestResult?.count,
        itemBuilder: (context, index) {
          var rowNumber = index + 1;
          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child:
                _buildProductCard(reservationListRequestResult!.result[index], rowNumber),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Reservation item, int rowNumber) {
    return ListTile(
        onTap: () {
          // Navigator.pushNamed(
          //     context, "${ReservationDetailsCustomerScreen.routeName}/${item.id}");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ReservationDetailsCustomerScreen(
                reservation: item,
              ),
            ),
          );
        },
        leading: Text(rowNumber.toString()),
        title: Text('${Utils.formatDate(item.startTime!)}'),
        subtitle: Text("Sto br: ${item.qrTable!.tableNumber.toString()}"),
        trailing: Text('${Utils.formatTime(item.startTime!)}h'));
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
                name: "startTime",
                decoration: InputDecoration(
                    labelText: "Datum od",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _formKey.currentState?.fields['startTime']?.reset();
                        });
                      },
                    )),
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                inputType: InputType.date,
                format: DateFormat('dd.MM.yyyy'),
                onChanged: (value) {},
                onSaved: (value) {},
              ),
            ),
            Expanded(
              child: FormBuilderDateTimePicker(
                name: "endTime",
                decoration: InputDecoration(
                    labelText: "Datum do",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _formKey.currentState?.fields['endTime']?.reset();
                        });
                      },
                    )),
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                inputType: InputType.date,
                format: DateFormat('dd.MM.yyyy'),
                onChanged: (value) {},
                onSaved: (value) {},
              ),
            ),
            Expanded(
              child: FormBuilderDropdown<String>(
                name: 'reservationStatus',
                decoration: InputDecoration(
                    labelText: "Status rezervacije", hintText: "Odaberi status narudžbe"),
                items: [
                  DropdownMenuItem<String>(
                    value: ReservationStatus.PENDING_CONFIRMATION.name,
                    child: Text(ReservationStatus.PENDING_CONFIRMATION.value),
                  ),
                  DropdownMenuItem<String>(
                    value: ReservationStatus.CONFIRMED.name,
                    child: Text(ReservationStatus.CONFIRMED.value),
                  ),
                  DropdownMenuItem<String>(
                    value: ReservationStatus.CANCELED.name,
                    child: Text(ReservationStatus.CANCELED.value),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.saveAndValidate();
                    var request = Map.from(_formKey.currentState!.value);
                    request['isReservationItemsIncluded'] = true;
                    request['isQRTableIncluded'] = true;
                    request['searchByCustomer'] = true;

                    var reservationListSearchResult =
                        await _reservationProvider.get(filter: request);
                    setState(() {
                      reservationListRequestResult = reservationListSearchResult!;
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
