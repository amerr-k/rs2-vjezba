import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spsp_mobile/models/enums/AllowedMethodsEnum.dart';
import 'package:spsp_mobile/models/qr_table.dart';
import 'package:spsp_mobile/models/reservation/reservation.dart';
import 'package:spsp_mobile/providers/qr_table_selector_provider.dart';
import 'package:spsp_mobile/providers/qr_table_provider.dart';
import 'package:spsp_mobile/providers/reservation_provider.dart';
import 'package:spsp_mobile/screens/reservation/qr_table_reservation_dialog_screen.dart';
import 'package:spsp_mobile/screens/reservation/reservation_list_customer_screen.dart';
import 'package:spsp_mobile/widgets/master_screen.dart';

class ReservationDetailsCustomerScreen extends StatefulWidget {
  static const String routeName = "/reservation-form";

  //ovo je ono sto se prosljedjuje prilikom pusha i
  String? id;
  Reservation? reservation;

  ReservationDetailsCustomerScreen({super.key, this.reservation, this.id});
  @override
  State<ReservationDetailsCustomerScreen> createState() =>
      _ReservationDetailsCustomerScreenState();
}

class _ReservationDetailsCustomerScreenState
    extends State<ReservationDetailsCustomerScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late ReservationProvider _reservationProvider;
  late QRTableProvider _qrTableProvider;
  late QRTableSelectorProvider _qrTableSelectorProvider;

  bool isLoading = true;

  List<QRTable>? qrTableList;

  List<QRTable>? qrTableDropdownList;

  List<String>? allowedMethods;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'startTime':
          widget.reservation != null ? widget.reservation?.startTime : DateTime.now(),
      'qrTableId': widget.reservation?.qrTableId.toString(),
      'specialRequest': widget.reservation?.specialRequest,
      'contactInfo': widget.reservation?.contactInfo,
    };
    _reservationProvider = context.read<ReservationProvider>();
    _qrTableProvider = context.read<QRTableProvider>();
    _qrTableSelectorProvider = context.read<QRTableSelectorProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _qrTableSelectorProvider = context.watch<QRTableSelectorProvider>();
    _qrTableProvider = context.read<QRTableProvider>();

    var qrTableRequestResult = await QRTableProvider()
        .getAllByReservationDate(filter: {"reservationDate": DateTime.now()});

    setState(() {
      qrTableDropdownList = qrTableRequestResult.result;
    });
  }

  Future initForm() async {
    if (widget.reservation != null) {
      List<String> allowedActionsResult = [];
      if (widget.reservation!.status != "CANCELED") {
        allowedActionsResult = await _reservationProvider
            .getAllowedActions(widget.reservation!.id.toString());
      }
      setState(() {
        allowedMethods = allowedActionsResult;
      });
    }

    var qrTableRequestResult = await _qrTableProvider.getAllByReservationDate(filter: {
      "reservationDate": DateTime.now(),
    });
    setState(() {
      qrTableList = qrTableRequestResult.result;
      isLoading = false;
    });
  }

  void updateQRTableList(List<QRTable> qrTableList) {
    setState(() {
      qrTableDropdownList = qrTableList;
    });
  }

  void updateStartTimeFormField(String newValue) async {
    setState(() {
      _formKey.currentState?.fields["qrTableId"]?.didChange("");
    });
    if (_qrTableSelectorProvider.reservationDate != null) {
      var qrTableRequestResult = await QRTableProvider().getAllByReservationDate(filter: {
        "reservationDate": _qrTableSelectorProvider.reservationDate,
      });
      setState(() {
        qrTableList = qrTableRequestResult.result;
      });
      setState(() {
        _formKey.currentState?.fields["startTime"]
            ?.didChange(_qrTableSelectorProvider.reservationDate!);
      });
    }
  }

  void updateQRTableFormField(String newValue) {
    setState(() {
      _formKey.currentState?.fields["qrTableId"]?.didChange(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Rezervacija",
      child: isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                Expanded(
                  child: _buildForm(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text("Natrag"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (String method in allowedMethods ?? [])
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  onAction(method);
                                },
                                child: Text(enumFromString(method).value),
                              ),
                            ),
                        ],
                      ),
                      widget.reservation == null
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors.green),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(Colors.black),
                                ),
                                onPressed: () async {
                                  var isValid =
                                      _formKey.currentState?.saveAndValidate() ?? false;
                                  if (isValid) {
                                    var request =
                                        new Map.from(_formKey.currentState!.value);
                                    var startTime = request['startTime'] as DateTime;

                                    var modifiedStartTime = DateTime(
                                      startTime.year,
                                      startTime.month,
                                      startTime.day,
                                      19,
                                      0,
                                    );

                                    request['startTime'] =
                                        modifiedStartTime.toIso8601String();

                                    try {
                                      if (widget.reservation == null) {
                                        await _reservationProvider.create(request);
                                      } else {
                                        await _reservationProvider.update(
                                            widget.reservation!.id!, request);
                                      }

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReservationListCustomerScreen(),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Uspješno ste kreirali rezervaciju",
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
                                  }
                                },
                                child: Text("Kreiraj"),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  void onAction(String method) async {
    _formKey.currentState?.saveAndValidate();
    var request = new Map.from(_formKey.currentState!.value);
    var startTime = request['startTime'] as DateTime;
    request['startTime'] = startTime.toIso8601String();

    try {
      switch (method) {
        case 'cancel':
        case 'confirm':
          await _reservationProvider.setState(widget.reservation!.id!, method);
          break;
        case 'update':
          await _reservationProvider.update(widget.reservation!.id!, request);
          break;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReservationListCustomerScreen(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Uspješno ste izvršili akciju",
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
  }

  SingleChildScrollView _buildForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (context) => QRTableReservationDialogScreen(
                    updateQRTableFormField: updateQRTableFormField,
                    updateStartTimeFormField: updateStartTimeFormField,
                    updateQRTableList: updateQRTableList,
                    formKey: _formKey,
                    qrTableList: qrTableList!,
                    qrTableSelectorProvider: _qrTableSelectorProvider!,
                    setState: setState),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      enabled: false,
                      name: "startTime",
                      decoration: InputDecoration(
                        labelText: "Datum rezervacije",
                      ),
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      inputType: InputType.date, // Set inputType to date
                      format: DateFormat('dd.MM.yyyy'),
                      onChanged: (value) async {},
                    ),
                  ),
                  Icon(Icons.add_box_sharp),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (context) => QRTableReservationDialogScreen(
                    updateQRTableFormField: updateQRTableFormField,
                    updateStartTimeFormField: updateStartTimeFormField,
                    updateQRTableList: updateQRTableList,
                    formKey: _formKey,
                    qrTableList: qrTableList!,
                    qrTableSelectorProvider: _qrTableSelectorProvider!,
                    setState: setState),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      validator: FormBuilderValidators.required(
                          errorText: "Polje ne smije biti prazno."),
                      name: 'qrTableId',
                      enabled: false,
                      decoration:
                          InputDecoration(labelText: "Sto", hintText: "Odaberi sto"),
                      items: qrTableDropdownList != null
                          ? qrTableDropdownList!
                              .map((item) => DropdownMenuItem(
                                    // alignment: AlignmentDirectional.,
                                    value: item.id != null ? item.id.toString() : "",
                                    child: Text(
                                        "Sto br. ${item.tableNumber.toString()} (${item.locationDescription})" ??
                                            ""),
                                  ))
                              .toList()
                          : [],
                    ),
                  ),
                  Icon(Icons.add_box_sharp)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              decoration: const InputDecoration(
                  labelText: "Specijalni zahtjevi, molbe ili napomene"),
              name: "specialRequest",
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              decoration: const InputDecoration(labelText: "Kontakt"),
              name: "contactInfo",
            ),
          ],
        ),
      ),
    );
  }
}
