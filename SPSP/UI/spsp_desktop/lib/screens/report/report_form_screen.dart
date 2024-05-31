import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:spsp_desktop/models/customer_report_data/customer_report_data.dart';
import 'package:spsp_desktop/models/enums/ReportParameter.dart';
import 'package:spsp_desktop/models/invoice/invoice.dart';
import 'package:spsp_desktop/models/menu/menu.dart';
import 'package:spsp_desktop/models/menu_item_report_data/menu_item_report_data.dart';
import 'package:spsp_desktop/models/search_result.dart';
import 'package:spsp_desktop/models/invoice/supplier.dart';
import 'package:spsp_desktop/pdf_utils/pdf_api.dart';
import 'package:spsp_desktop/pdf_utils/pdf_customer_report_api.dart';
import 'package:spsp_desktop/pdf_utils/pdf_menu_item_report_api.dart';
import 'package:spsp_desktop/providers/report_provider.dart';
import 'package:spsp_desktop/widgets/master_screen.dart';

class ReportFormScreen extends StatefulWidget {
  ReportFormScreen({super.key});
  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late ReportProvider _reportProvider;

  Map<String, dynamic> _initialValue = {};
  RequestResult<Menu>? menuResult;
  bool isLoading = true;
  List<MenuItemReportData> menuItemReportData = [];
  List<CustomerReportData> customerReportData = [];

  @override
  void initState() {
    super.initState();
    _initialValue = {};

    _reportProvider = context.read<ReportProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Izvještaji",
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: _buildForm(),
                  ),
                  _buildGenerateButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildGenerateButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () async {
                var isValid = _formKey.currentState?.saveAndValidate() ?? false;
                if (isValid) {
                  var request = _formKey.currentState!.value;

                  try {
                    const invoice = Invoice(
                      supplier: Supplier(
                          name: 'Caffe Pub - Skeniraj Plati',
                          address: 'ul. Abdulaha Sidrana, Sarajevo, BiH',
                          contactInfo: "+387 62 123 321"),
                    );

                    switch (request['subject']) {
                      case 'MENU_ITEM':
                        menuItemReportData =
                            await _reportProvider.getMenuItemsReportData(filter: request);

                        await _generateMenuItemsReport(invoice, menuItemReportData);

                        break;
                      case 'CUSTOMER':
                        customerReportData =
                            await _reportProvider.getCustomersReportData(filter: request);

                        await _generateCustomersReport(invoice, customerReportData);

                        break;
                    }
                  } on Exception catch (e) {
                    showDialog(
                      context: context,
                      builder: ((BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(
                              e.toString(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Uredu"),
                              ),
                            ],
                          )),
                    );
                  }
                }
              },
              child: const Text("Generiši izvještaj")),
        )
      ],
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        children: [
          FormBuilderDropdown<String>(
            name: 'quarter',
            decoration: InputDecoration(
                labelText: "Kvartal",
                suffix: IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    _formKey.currentState!.fields['quarter']?.reset();
                  },
                ),
                hintText: "Odaberi kategoriju"),
            items: [
              DropdownMenuItem<String>(
                value: ReportQuarterParameter.Q1.name,
                child: Text(ReportQuarterParameter.Q1.value),
              ),
              DropdownMenuItem<String>(
                value: ReportQuarterParameter.Q2.name,
                child: Text(ReportQuarterParameter.Q2.value),
              ),
              DropdownMenuItem<String>(
                value: ReportQuarterParameter.Q3.name,
                child: Text(ReportQuarterParameter.Q3.value),
              ),
              DropdownMenuItem<String>(
                value: ReportQuarterParameter.Q4.name,
                child: Text(ReportQuarterParameter.Q4.value),
              ),
            ],
          ),
          FormBuilderDropdown<String>(
            validator:
                FormBuilderValidators.required(errorText: "Polje ne smije biti prazno."),
            name: 'subject',
            decoration: InputDecoration(
                labelText: "Predmet",
                suffix: IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    _formKey.currentState!.fields['menuId']?.reset();
                  },
                ),
                hintText: "Predmet po kojem želite kreiran izvještaj."),
            items: [
              DropdownMenuItem<String>(
                value: ReportSubjectParameter.CUSTOMER.name,
                child: Text(ReportSubjectParameter.CUSTOMER.value),
              ),
              DropdownMenuItem<String>(
                value: ReportSubjectParameter.MENU_ITEM.name,
                child: Text(ReportSubjectParameter.MENU_ITEM.value),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future _generateCustomersReport(
      Invoice invoice, List<CustomerReportData> customerReportData) async {
    final pdfFile =
        await PdfCustomerReportApi.generateAsFile(invoice, customerReportData);

    PdfApi.openFile(pdfFile);
  }

  Future _generateMenuItemsReport(
      Invoice invoice, List<MenuItemReportData> menuItemReportData) async {
    final pdfFile =
        await PdfMenuItemReportApi.generateAsFile(invoice, menuItemReportData);

    PdfApi.openFile(pdfFile);
  }
}
