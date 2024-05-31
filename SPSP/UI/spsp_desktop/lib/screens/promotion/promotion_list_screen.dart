import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spsp_desktop/models/promotion/promotion.dart';
import 'package:spsp_desktop/models/search_result.dart';
import 'package:spsp_desktop/providers/promotion_provider.dart';
import 'package:spsp_desktop/screens/promotion/promotion_detail_screen.dart';
import 'package:spsp_desktop/utils/util.dart';
import 'package:spsp_desktop/widgets/master_screen.dart';

class PromotionListScreen extends StatefulWidget {
  const PromotionListScreen({super.key});

  @override
  State<PromotionListScreen> createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen> {
  RequestResult<Promotion>? searchResult;
  late PromotionProvider _promotionProvider;
  final TextEditingController _ftsController = TextEditingController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _promotionProvider = context.read<PromotionProvider>();

    var data = await _promotionProvider.get();
    setState(() {
      searchResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        child: Column(
          children: [_buildSearch(), _buildDataListView()],
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: _buildDataTable(),
      ),
    );
  }

  Widget _buildDataTable() {
    return Row(
      children: [
        Expanded(
          child: DataTable(
              showCheckboxColumn: false,
              columns: const [
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Id',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      "Opis",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Početak promocije',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Kraj promocije',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Meni stavka',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Aktivno',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: searchResult?.result
                      .map(
                        (e) => DataRow(
                            onSelectChanged: (selected) => {
                                  if (selected == true)
                                    {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => PromotionDetailScreen(
                                            promotion: e,
                                          ),
                                        ),
                                      )
                                    }
                                },
                            cells: [
                              DataCell(
                                Text(e.id?.toString() ?? ""),
                              ),
                              DataCell(
                                Text(e.description ?? ""),
                              ),
                              DataCell(
                                Text(Utils.formatDate(e.startTime!) ?? ""),
                              ),
                              DataCell(
                                Text(e.endTime != null
                                    ? Utils.formatDate(e.endTime!)
                                    : ""),
                              ),
                              DataCell(
                                Text(e.menuItem!.name! ?? ""),
                              ),
                              DataCell(
                                Text(e.active ? "Aktivna" : "Neaktivna"),
                              ),
                            ]),
                      )
                      .toList() ??
                  []),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Naziv meni stavke ili opis promocije",
              ),
              controller: _ftsController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var data = await _promotionProvider.get(filter: {
                'fts': _ftsController.text,
              });
              setState(() {
                searchResult = data;
              });
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PromotionDetailScreen(),
                ),
              );
            },
            child: const Text("Kreiraj novu meni stavku"),
          ),
        ],
      ),
    );
  }
}
