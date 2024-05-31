import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spsp_mobile/models/qr_table.dart';
import 'package:spsp_mobile/providers/qr_table_selector_provider.dart';
import 'package:spsp_mobile/providers/qr_table_provider.dart';
import 'package:spsp_mobile/widgets/qr_table_positions_widget.dart';

class QRTableReservationDialogScreen extends StatefulWidget {
  final List<QRTable> qrTableList;
  final QRTableSelectorProvider qrTableSelectorProvider;
  final void Function(VoidCallback) setState;
  final void Function(String) updateQRTableFormField;
  final void Function(String) updateStartTimeFormField;
  final void Function(List<QRTable>) updateQRTableList;
  final GlobalKey<FormBuilderState> formKey;

  const QRTableReservationDialogScreen(
      {super.key,
      required this.qrTableList,
      required this.qrTableSelectorProvider,
      required this.setState,
      required this.updateQRTableFormField,
      required this.updateStartTimeFormField,
      required this.updateQRTableList,
      required this.formKey});
  @override
  QRTableReservationDialogScreenState createState() =>
      QRTableReservationDialogScreenState();
}

class QRTableReservationDialogScreenState extends State<QRTableReservationDialogScreen> {
  List<QRTable>? qrTableList;
  late QRTableProvider _qrTableProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _qrTableProvider = context.read<QRTableProvider>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchQRTables();
  }

  Future<void> _fetchQRTables() async {
    if (widget.qrTableSelectorProvider.reservationDate != null) {
      final qrTablesResult = await _qrTableProvider.getAllByReservationDate(
        filter: {
          "reservationDate": widget.qrTableSelectorProvider.reservationDate,
        },
      );

      widget.updateQRTableList(qrTablesResult.result);

      setState(() {
        qrTableList = qrTablesResult.result;
        isLoading = false;
      });
    } else {
      final qrTablesResult = await _qrTableProvider.getAllByReservationDate(
        filter: {
          "reservationDate": DateTime.now(),
        },
      );
      setState(() {
        qrTableList = qrTablesResult.result;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Dialog.fullscreen(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FormBuilderDateTimePicker(
                        initialValue: widget.qrTableSelectorProvider.reservationDate ??
                            DateTime.now(),
                        name: "startTime",
                        decoration: InputDecoration(
                          labelText: "Datum rezervacije",
                        ),
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        inputType: InputType.date, // Set inputType to date
                        format: DateFormat('dd.MM.yyyy'),
                        onChanged: (value) async {
                          if (value != null) {
                            setState(() {
                              setState(() {
                                isLoading = true;
                              });
                              widget.qrTableSelectorProvider.setReservationDate(value);
                            });
                            await _fetchQRTables();

                            widget.updateStartTimeFormField("");
                          } else {
                            widget.updateStartTimeFormField("");
                          }
                        },
                        onSaved: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ŠANK',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: -90 * 3.1415926535 / 180,
                    child: const Text(
                      'PROZORI',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: isLoading
                        ? Container(
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : QRTablePositionsWidget(
                            qrTableList: qrTableList!,
                            onTap: (tableNumber) {
                              var tappedTable = qrTableList![tableNumber - 1];
                              if (!tappedTable.isReserved!) {
                                widget.qrTableSelectorProvider
                                    .setSelectedQRTable(tappedTable);
                                widget.updateQRTableFormField(tappedTable.id.toString());
                                Navigator.pop(context);
                              }
                            },
                          ),
                  ),
                  const SizedBox(width: 25),
                  Transform.rotate(
                    angle: 90 * 3.1415926535 / 180,
                    child: const Text(
                      'TOALET',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text("Zatvori"),
                )
              ])
            ],
          ),
        ),
      );
}
